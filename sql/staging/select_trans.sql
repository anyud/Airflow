TRUNCATE staging.Transaction CASCADE;
INSERT INTO staging.Transaction (Transaction_Id, Customer_id, Product_id, Date, Time, Quantity, Price, Feedback, Ship_method, Payment_method, Order_Status, Ratings)
SELECT DISTINCT ON (Transaction_Id)
    CAST(Transaction_Id AS INTEGER) AS Transaction_Id,  -- Giữ nguyên giá trị NULL nếu có
    CAST(Customer_id AS INTEGER),
    CAST(Product_id AS INTEGER),
    CAST(REPLACE(Date, ':', '-') AS DATE) AS Date,
    CAST(Time AS TIME),
    CAST(Quantity AS INTEGER),
    CAST(REPLACE(Price, ',', '.') AS NUMERIC) AS Price,
    Feedback,
    Ship_method,
    Payment_method,
    Order_Status,
    CAST(Ratings AS INTEGER)
FROM bronze.transactions_true

