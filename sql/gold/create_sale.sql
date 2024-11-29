CREATE TABLE IF NOT EXISTS Sale_Analysis (
    Product_ID INTEGER,
    Product_Brand VARCHAR (50),
    Product_Type VARCHAR(50),
    Total_Quantity_Sold INTEGER,
    Sales_Evaluation VARCHAR(50), -- Đánh giá doanh thu
    PRIMARY KEY (Product_Brand, Product_ID)  -- Khóa chính là sự kết hợp của tên thương hiệu và ID sản phẩm
);