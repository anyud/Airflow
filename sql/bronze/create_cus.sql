CREATE TABLE IF NOT EXISTS bronze.Customer (
    Customer_id VARCHAR(255),     -- Khóa chính dưới dạng VARCHAR
    Name VARCHAR(255),                        -- Có thể để null
    Email VARCHAR(255),                       -- Có thể để null
    Phone VARCHAR(255),
    Address VARCHAR(255),                        -- Có thể để null
    City_ID VARCHAR(255),
    Age VARCHAR(255),                     -- Thay INTEGER bằng VARCHAR
    Gender VARCHAR(10),                       -- Có thể để null, dùng giá trị như 'Male', 'Female', v.v.
    Income VARCHAR(15),                       -- Thay DECIMAL bằng VARCHAR
    Customer_segment VARCHAR(50)              -- Có thể để null, phân đoạn khách hàng
);
