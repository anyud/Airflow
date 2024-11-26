TRUNCATE staging.Customer CASCADE;
INSERT INTO staging.Customer (Customer_id, Name, Email, Phone, Address, City_ID, Age, Gender, Income, Customer_Segment)
SELECT DISTINCT ON (Customer_id)
    CAST(Customer_id AS INTEGER) AS Customer_ID,
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

