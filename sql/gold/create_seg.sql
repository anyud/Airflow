CREATE TABLE IF NOT EXISTS gold.Segmentation (
    Customer_ID INTEGER PRIMARY KEY,
    Recency INTEGER,
    Total_transaction INTEGER,
    Total_payment NUMERIC,
    R_Score INTEGER,
    F_Score INTEGER,
    M_Score INTEGER,
    Segment VARCHAR(50)
);
