CREATE TABLE IF NOT EXISTS staging.City (
    City_id INTEGER PRIMARY KEY,  -- Khóa chính dưới dạng VARCHAR
    City VARCHAR(255),        -- Tên thành phố, không cho phép NULL
    State VARCHAR(255),                -- Tên bang hoặc tỉnh, có thể để NULL
    Country VARCHAR(255)      -- Tên quốc gia, không cho phép NULL
);


