TRUNCATE gold.Geographical_Sale CASCADE;
-- Chèn dữ liệu vào bảng gold.Geographical_Sale
INSERT INTO gold.Geographical_Sale (City, Country, Total_Transactions, Sales_Evaluation)
SELECT 
    c.City,                                      -- Lấy tên thành phố từ bảng Customer
    c.Country,                                   -- Lấy tên quốc gia từ bảng Customer                         
    COUNT(t.Transaction_ID) AS Total_Transactions, -- Đếm số giao dịch
    -- Đánh giá số lượng giao dịch khu vực
    CASE 
        WHEN COUNT(t.Transaction_ID) >= 10000 THEN 'Outstanding'
        WHEN COUNT(t.Transaction_ID) >= 5000 THEN 'High Activity'  -- Đánh giá hoạt động cao
        WHEN COUNT(t.Transaction_ID) >= 1000 THEN 'Moderate Activity' -- Đánh giá hoạt động trung bình
        ELSE 'Low Activity'  -- Đánh giá hoạt động thấp
    END AS Sales_Evaluation
FROM 
    silver.Customer_Details c
JOIN 
    silver.Transaction_Details t ON c.Customer_ID = t.Customer_ID
GROUP BY 
    c.City, c.Country;                           -- Nhóm theo thành phố và quốc gia
