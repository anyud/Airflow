-- Tạo bảng để lưu trữ phân tích doanh thu theo sản phẩm
CREATE TABLE IF NOT EXISTS gold.Sale_Analysis (
    Product_ID INTEGER PRIMARY KEY,
    Product_Brand VARCHAR(50),
    Product_Type VARCHAR(50),
    Total_Quantity_Sold INTEGER,
    Sales_Evaluation VARCHAR(50) -- Đánh giá số lượng bán ra
);

-- Xóa toàn bộ dữ liệu trong bảng gold.Sale_Analysis
TRUNCATE gold.Sale_Analysis CASCADE;

-- Chèn dữ liệu vào bảng Sale_Analysis
INSERT INTO gold.Sale_Analysis (Product_ID, Product_Brand, Product_Type, Total_Quantity_Sold, Sales_Evaluation)
SELECT 
    Product_ID,
    Product_Brand,
    Product_Type,
    SUM(Quantity) AS Total_Quantity_Sold,  -- Tính tổng số lượng sản phẩm bán ra
    -- Đánh giá số lượng bán ra
    CASE 
        WHEN SUM(Quantity) >= 5000 THEN 'Best Seller'          -- Bán chạy
        WHEN SUM(Quantity) >= 2000 THEN 'Moderate Seller'       -- Bán không chạy
        ELSE 'Low Interest'                                   -- Không được quan tâm
    END AS Sales_Evaluation
FROM 
    silver.Transaction_Details  -- Sử dụng bảng Transaction_Details
GROUP BY 
    Product_ID, Product_Brand, Product_Type  -- Nhóm theo ID, thương hiệu và loại sản phẩm
ORDER BY 
    Total_Quantity_Sold DESC; -- Sắp xếp theo tổng số lượng bán ra giảm dần
