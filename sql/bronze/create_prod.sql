CREATE TABLE IF NOT EXISTS bronze.Product_staging (
    Product_id VARCHAR(255) PRIMARY KEY,     -- Khóa chính dưới dạng VARCHAR
    Product_name VARCHAR(255) NOT NULL,      -- Tên sản phẩm, không cho phép NULL
    Product_Brand VARCHAR(255),              -- Thương hiệu sản phẩm, có thể để NULL
    Product_Type VARCHAR(255)                -- Loại sản phẩm, có thể để NULL
);
