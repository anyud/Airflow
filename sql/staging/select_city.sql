INSERT INTO staging.City (City_Id, City, State, Country)
SELECT 
    CAST(City_Id AS INTEGER) AS City_Id, -- Sử dụng đúng tên cột
    City,
    State,
    Country
FROM bronze.City;
