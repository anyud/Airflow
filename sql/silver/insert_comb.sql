TRUNCATE silver.Transaction_Details CASCADE;
INSERT INTO silver.Transaction_Details (
    Transaction_ID,
    Customer_ID,
    Product_ID,
    Date,
    Time,
    Quantity,
    Price,
    Feedback,
    Ratings,
    Product_Name,
    Product_Category,
    Product_Brand,
    Product_Type,
    City_ID,
    Country
)
SELECT 
    t.Transaction_Id,
    t.Customer_id,
    t.Product_id,
    t.Date,
    t.Time,
    t.Quantity,
    t.Price,
    t.Feedback,
    t.Ratings,
    p.Product_Name,
    p.Product_Category,
    p.Product_Brand,
    p.Product_Type,
    c.City_ID,
    ci.Country
FROM 
    staging.Transaction t
JOIN 
    staging.Customer c ON t.Customer_id = c.Customer_id
JOIN 
    staging.Product p ON t.Product_id = p.Product_id
JOIN 
    staging.City ci ON c.City_ID = ci.City_ID;
