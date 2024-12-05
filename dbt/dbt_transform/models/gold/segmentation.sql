WITH scored_data AS (
    SELECT 
        c.Customer_ID,
        -- Tính Recency
        (MAX(t.Date) - MIN(t.Date))::INTEGER AS Recency,  -- Số ngày từ lần mua cuối
        COUNT(t.Transaction_ID) AS Total_transaction,       -- Tính số giao dịch
        SUM(t.Quantity * t.Price) AS Total_payment,         -- Tổng giá trị giao dịch

        -- Sử dụng macros để tính điểm R, F, M
        {{ calc_r_score((MAX(t.Date) - MIN(t.Date))::INTEGER) }} AS R_Score,
        {{ calc_f_score(COUNT(DISTINCT t.Transaction_ID)) }} AS F_Score,
        {{ calc_m_score(SUM(t.Quantity * t.Price)) }} AS M_Score
    FROM 
        silver.Customer_Details c
    JOIN 
        silver.Transaction_Details t ON c.Customer_ID = t.Customer_ID
    GROUP BY 
        c.Customer_ID
)

-- Phân đoạn khách hàng dựa trên điểm R, F, M
SELECT 
    Customer_ID,
    Recency,
    Total_transaction,
    Total_payment,
    R_Score,
    F_Score,
    M_Score,
    CASE 
        WHEN 
            (R_Score = 4 OR R_Score = 3) 
            AND (F_Score = 3 OR F_Score = 4) 
            AND (M_Score = 3 OR M_Score = 4) THEN 'Champions'
        
        WHEN 
            (R_Score = 4 OR R_score = 3)
            AND (F_Score = 2 OR F_Score = 3) 
            AND (M_Score = 2 OR M_Score = 3) THEN 'Potential Loyalists'

        WHEN 
            (R_Score = 1 OR R_Score = 2) 
            AND (F_Score = 2 OR F_Score = 3) 
            AND (M_Score = 2 OR M_Score = 3) THEN 'New Customers'

        WHEN 
            (R_Score = 1 OR R_Score = 2) 
            AND (F_Score = 3 OR F_Score = 2) 
            AND (M_Score = 3 OR M_Score = 2) THEN 'At Risk Customers'

        ELSE 
            'Potential New Customers'
    END AS Segment
FROM 
    scored_data;
