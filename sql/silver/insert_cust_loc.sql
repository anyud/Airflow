TRUNCATE silver.Customer_Details CASCADE;
INSERT INTO silver.Customer_Details (Customer_ID, Name, Email, Phone, Address, City_ID, Age, Gender, Income, Customer_Segment, City, Country)
SELECT 
    c.Customer_ID,
    c.Name,
    c.Email,
    c.Phone,
    c.Address,
    c.City_ID,
    c.Age,
    c.Gender,
    c.Income,
    c.Customer_Segment,
    city.City,
    city.Country
FROM 
    staging.Customer AS c
JOIN 
    staging.City AS city ON c.City_ID = city.City_id;
