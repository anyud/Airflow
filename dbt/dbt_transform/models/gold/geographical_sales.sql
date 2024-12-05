WITH geographical_sales AS (
    SELECT 
        c.City,                                      -- Lấy tên thành phố từ bảng Customer
        c.Country,                                   -- Lấy tên quốc gia từ bảng Customer                         
        COUNT(t.Transaction_ID) AS Total_Transactions -- Đếm số giao dịch
    FROM 
        silver.Customer_Details c
    JOIN 
        silver.Transaction_Details t ON c.Customer_ID = t.Customer_ID
    GROUP BY 
        c.City, c.Country                           -- Nhóm theo thành phố và quốc gia
)

-- Chèn vào bảng gold.Geographical_Sale và đánh giá hoạt động khu vực
INSERT INTO gold.Geographical_Sale (City, Country, Total_Transactions, Sales_Evaluation)
SELECT 
    City,
    Country,
    Total_Transactions,
    -- Sử dụng macro để đánh giá khu vực
    {{ geo_sales_evaluation(Total_Transactions) }} AS Sales_Evaluation
FROM 
    geographical_sales;
