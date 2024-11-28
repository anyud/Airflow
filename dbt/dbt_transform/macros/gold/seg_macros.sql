{% macro segmentation(source_combine, source_cust_loc) %}
WITH scored_data AS (
    SELECT 
        c.Customer_ID,
        DATE_DIFF(CURRENT_DATE(), MAX(c.Date), DAY) AS Recency,  -- Tính số ngày từ lần mua cuối
        COUNT(c.Transaction_ID) AS Total_Transactions,          -- Số giao dịch
        SUM(c.Quantity * c.Price) AS Total_Payment,             -- Tổng giá trị giao dịch

        -- Tính điểm R (Recency Score)
        CASE 
            WHEN DATE_DIFF(CURRENT_DATE(), MAX(c.Date), DAY) <= 90 THEN 4
            WHEN DATE_DIFF(CURRENT_DATE(), MAX(c.Date), DAY) <= 180 THEN 3
            WHEN DATE_DIFF(CURRENT_DATE(), MAX(c.Date), DAY) <= 270 THEN 2
            ELSE 1
        END AS R_Score,

        -- Tính điểm F (Frequency Score)
        CASE 
            WHEN COUNT(DISTINCT c.Transaction_ID) >= 8 THEN 4
            WHEN COUNT(DISTINCT c.Transaction_ID) >= 5 THEN 3
            WHEN COUNT(DISTINCT c.Transaction_ID) >= 2 THEN 2
            ELSE 1  
        END AS F_Score,

        -- Tính điểm M (Monetary Score)
        CASE 
            WHEN SUM(c.Quantity * c.Price) >= 1000 THEN 4
            WHEN SUM(c.Quantity * c.Price) >= 500 THEN 3
            WHEN SUM(c.Quantity * c.Price) >= 200 THEN 2
            ELSE 1
        END AS M_Score
    FROM 
        {{ source('silver', 'combine') }} c
    JOIN 
        {{ source('silver', 'cust_loc') }} t ON c.Customer_ID = t.Customer_ID
    GROUP BY 
        c.Customer_ID
)

SELECT 
    Customer_ID,
    Recency,
    Total_Transactions,
    Total_Payment,
    R_Score,
    F_Score,
    M_Score,
    CASE 
        WHEN 
            (R_Score IN (4, 3)) AND (F_Score IN (3, 4)) AND (M_Score IN (3, 4)) THEN 'Champions'
        WHEN 
            (R_Score IN (4, 3)) AND (F_Score IN (2, 3)) AND (M_Score IN (2, 3)) THEN 'Potential Loyalists'
        WHEN 
            (R_Score IN (1, 2)) AND (F_Score IN (1, 2)) AND (M_Score IN (1, 2)) THEN 'New Customers'
        WHEN 
            (R_Score IN (1, 2)) AND (F_Score IN (2, 3)) AND (M_Score IN (2, 3)) THEN 'At Risk Customers'
        ELSE 
            'Potential New Customers'
    END AS Segment
FROM 
    scored_data
{% endmacro %}
