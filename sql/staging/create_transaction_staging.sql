CREATE TABLE IF NOT EXISTS staging.Transaction (
    Transaction_Id INTEGER PRIMARY KEY,
    Customer_id INTEGER,
    Product_id INTEGER,
    Date DATE,
    Time TIME,
    Quantity INTEGER,
    Price NUMERIC,
    Feedback VARCHAR(255),
    Ship_method VARCHAR(50),
    Payment_method VARCHAR(50),
    Order_Status VARCHAR(50),
    Ratings INTEGER
)
