CREATE TABLE IF NOT EXISTS bronze.Customer_staging (
    Customer_id VARCHAR(255) PRIMARY KEY,     -- Khóa chính dưới dạng VARCHAR
    Name VARCHAR(255),                        -- Có thể để null
    Email VARCHAR(255),                       -- Có thể để null
    Phone VARCHAR(20),                        -- Có thể để null
    Address VARCHAR(255),                     -- Đổi từ TEXT thành VARCHAR
    City_id VARCHAR(255),                     -- Thay INTEGER bằng VARCHAR
    Age VARCHAR(10),                          -- Thay INTEGER bằng VARCHAR
    Gender VARCHAR(10),                       -- Có thể để null, dùng giá trị như 'Male', 'Female', v.v.
    Income VARCHAR(15),                       -- Thay DECIMAL bằng VARCHAR
    Customer_segment VARCHAR(50)              -- Có thể để null, phân đoạn khách hàng
);
