CREATE TABLE IF NOT EXISTS bronze.Customer_staging (
    Customer_id SERIAL PRIMARY KEY,       -- Khóa chính, tự động tăng
    Name VARCHAR(255),                    -- Có thể để null
    Email VARCHAR(255),                   -- Có thể để null
    Phone VARCHAR(20),                    -- Có thể để null
    Address TEXT,                         -- Có thể để null
    City_id INTEGER,                      -- Có thể để null
    Age INTEGER,                          -- Có thể để null
    Gender VARCHAR(10),                   -- Có thể để null, dùng giá trị như 'Male', 'Female', v.v.
    Income DECIMAL(15, 2),                -- Có thể để null, định dạng cho thu nhập
    Customer_segment VARCHAR(50)          -- Có thể để null, phân đoạn khách hàng
);
