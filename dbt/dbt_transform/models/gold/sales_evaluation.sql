WITH product_sales AS (
    SELECT 
        Product_ID,
        Product_Brand,
        Product_Type,
        SUM(Quantity) AS Total_Quantity_Sold   -- Tính tổng số lượng bán ra
    FROM 
        silver.Transaction_Details  -- Sử dụng bảng Transaction_Details
    GROUP BY 
        Product_ID, Product_Brand, Product_Type  -- Nhóm theo ID, thương hiệu và loại sản phẩm
)

-- Chèn vào bảng Sale_Analysis và đánh giá doanh thu sản phẩm
INSERT INTO gold.Sale_Analysis (Product_ID, Product_Brand, Product_Type, Total_Quantity_Sold, Sales_Evaluation)
SELECT 
    Product_ID,
    Product_Brand,
    Product_Type,
    Total_Quantity_Sold,
    -- Sử dụng macro để đánh giá doanh thu sản phẩm
    {{ sales_evaluation(Total_Quantity_Sold) }} AS Sales_Evaluation
FROM 
    product_sales
ORDER BY 
    Total_Quantity_Sold DESC;  -- Sắp xếp theo tổng số lượng bán ra giảm dần
