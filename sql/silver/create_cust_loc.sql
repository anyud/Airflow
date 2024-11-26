CREATE TABLE IF NOT EXISTS silver.Customer_Details (
    Customer_ID INTEGER PRIMARY KEY,
    Name VARCHAR(50),
    Email VARCHAR(50),
    Phone VARCHAR(50),
    Address VARCHAR(100),
    City_ID INTEGER,
    Age INTEGER,
    Gender VARCHAR(10),
    Income VARCHAR(20),
    Customer_Segment VARCHAR(20),
    City VARCHAR(50),
    Country VARCHAR(50)
);
