CREATE TABLE IF NOT EXISTS staging.Transaction (
    Transaction_Id INTEGER,             -- ID giao dịch, có thể có giá trị trùng lặp và NULL
    Customer_id INTEGER,                -- ID khách hàng, chuyển từ INTEGER sang VARCHAR
    Product_id INTEGER,                 -- ID sản phẩm, chuyển từ INTEGER sang VARCHAR
    Date DATE,                        -- Ngày giao dịch, chuyển từ DATE sang VARCHAR (định dạng 'YYYY-MM-DD')
    Time TIME,                         -- Thời gian giao dịch, chuyển từ TIME sang VARCHAR (định dạng 'HH:MM:SS')
    Quantity INTEGER,                    -- Số lượng, chuyển từ INTEGER sang VARCHAR
    Price NUMERIC,                       -- Giá, chuyển từ DECIMAL sang VARCHAR
    Feedback VARCHAR(255),                   -- Phản hồi từ khách hàng, đổi từ TEXT sang VARCHAR
    Ship_method VARCHAR(50),                 -- Phương thức vận chuyển, giữ nguyên VARCHAR
    Payment_method VARCHAR(50),              -- Phương thức thanh toán, giữ nguyên VARCHAR
    Order_Status VARCHAR(50),                -- Trạng thái đơn hàng, giữ nguyên VARCHAR
    Ratings INTEGER     
)


