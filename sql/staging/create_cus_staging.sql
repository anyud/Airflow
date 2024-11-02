CREATE TABLE IF NOT EXISTS staging.Customer (
    Customer_id INTEGER,     -- Khóa chính dưới dạng VARCHAR
    Name VARCHAR(255),                        -- Có thể để null
    Email VARCHAR(255),                       -- Có thể để null
    Phone VARCHAR(255),
    Address VARCHAR(255),                        -- Có thể để null
    City_ID INTEGER,
    Age INTEGER,                     -- Thay INTEGER bằng VARCHAR
    Gender VARCHAR(10),                       -- Có thể để null, dùng giá trị như 'Male', 'Female', v.v.
    Income VARCHAR(15),                       -- Thay DECIMAL bằng VARCHAR
    Customer_segment VARCHAR(50)    
)


   