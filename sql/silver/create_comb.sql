CREATE TABLE IF NOT EXISTS silver.Transaction_Details (
    Transaction_ID INTEGER PRIMARY KEY,
    Customer_ID INTEGER,
    Product_ID INTEGER,
    Date DATE,
    Time TIME,
    Quantity INTEGER,
    Price NUMERIC,
    Feedback VARCHAR(20),
    Ratings INTEGER,
    Product_Name VARCHAR(50),
    Product_Category VARCHAR(50),
    Product_Brand VARCHAR(50),
    Product_Type VARCHAR(50),
    City_ID INTEGER,
    Country VARCHAR(50)
);
