INSERT INTO staging.Customer (Customer_ID, Name, Email, Phone, Address, City_ID, Age, Gender, Income, Customer_Segment)
SELECT 
    CAST(Customer_ID AS INTEGER) AS Customer_ID, -- Ép kiểu Customer_id từ VARCHAR sang INTEGER
    Name,
    Email,
    Phone,
    Address,
    CAST(City_ID AS INTEGER) AS City_id,
    CAST(Age AS INTEGER) AS Age,
    Gender,
    Income,
    Customer_Segment
FROM bronze.Customer