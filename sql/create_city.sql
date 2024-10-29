CREATE TABLE IF NOT EXISTS bronze.City (
    City_id SERIAL PRIMARY KEY,       -- Khóa chính, tự động tăng
    City VARCHAR(255) NOT NULL,       -- Tên thành phố, không cho phép NULL
    State VARCHAR(255),               -- Tên bang hoặc tỉnh, có thể để NULL
    Country VARCHAR(255) NOT NULL     -- Tên quốc gia, không cho phép NULL
);
