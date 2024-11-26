-- Xóa toàn bộ dữ liệu trong bảng gold.Segmentation
TRUNCATE gold.Segmentation CASCADE;

-- Sử dụng CTE để tính điểm R, F, M trước khi phân đoạn khách hàng
WITH scored_data AS (
    SELECT 
        c.Customer_ID,
        (MAX(t.Date) - MIN(t.Date))::INTEGER AS Recency,  -- Tính số ngày từ lần mua cuối
        COUNT(t.Transaction_ID) AS Total_transaction,       -- Tính số giao dịch
        SUM(t.Quantity * t.Price) AS Total_payment,         -- Tổng giá trị giao dịch

        -- Tính điểm R (Recency Score)
        CASE 
            WHEN (MAX(t.Date) - MIN(t.Date))::INTEGER <= 90 THEN 4
            WHEN (MAX(t.Date) - MIN(t.Date))::INTEGER <= 180 THEN 3
            WHEN (MAX(t.Date) - MIN(t.Date))::INTEGER <= 270 THEN 2
            ELSE 1
        END AS R_Score,

        -- Tính điểm F (Frequency Score)
        CASE 
            WHEN COUNT(DISTINCT t.Transaction_ID) >= 8 THEN 4
            WHEN COUNT(DISTINCT t.Transaction_ID) >= 5 THEN 3
            WHEN COUNT(DISTINCT t.Transaction_ID) >= 2 THEN 2
            ELSE 1  
        END AS F_Score,

        -- Tính điểm M (Monetary Score)
        CASE 
            WHEN SUM(t.Quantity) >= 60 THEN 4
            WHEN SUM(t.Quantity) >= 40 THEN 3
            WHEN SUM(t.Quantity) >= 20 THEN 2
            ELSE 1
        END AS M_Score
    FROM 
        silver.Customer_Details c
    JOIN 
        silver.Transaction_Details t ON c.Customer_ID = t.Customer_ID
    GROUP BY 
        c.Customer_ID
)

-- Sử dụng kết quả từ CTE scored_data để phân đoạn khách hàng
INSERT INTO gold.Segmentation (Customer_ID, Recency, Total_transaction, Total_payment, R_Score, F_Score, M_Score, Segment)
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
            -- Champions: R = 4 hoặc 3, F = 3 hoặc 4, M = 3 hoặc 4
            (R_Score = 4 OR R_Score = 3) 
            AND (F_Score = 3 OR F_Score = 4) 
            AND (M_Score = 3 OR M_Score = 4) THEN 'Champions'
        
        WHEN 
            -- Potential Loyalists: R = 4, F = 2 hoặc 3, M = 2 hoặc 3
            (R_Score = 4 OR R_score = 3)
            AND (F_Score = 2 OR F_Score = 3) 
            AND (M_Score = 2 OR M_Score = 3) THEN 'Potential Loyalists'

        WHEN 
            -- New Customers: R = 1 hoặc 2, F = 1 hoặc 2, M = 1 hoặc 2
            (R_Score = 1 OR R_Score = 2) 
            AND (F_Score = 2 OR F_Score = 3) 
            AND (M_Score = 2 OR M_Score = 3) THEN 'New Customers'

        WHEN 
            -- At Risk Customers: R = 1 hoặc 2, F = 3 hoặc 2, M = 3 hoặc 2
            (R_Score = 1 OR R_Score = 2) 
            AND (F_Score = 3 OR F_Score = 2) 
            AND (M_Score = 3 OR M_Score = 2) THEN 'At Risk Customers'

        ELSE 
            'Potential New Customers'
    END AS Segment
FROM 
    scored_data;
