CREATE TABLE IF NOT EXISTS bronze.Transaction_staging (
    Transaction_Id VARCHAR(255),             -- ID giao dịch, có thể có giá trị trùng lặp và NULL
    Customer_id VARCHAR(255),                -- ID khách hàng, chuyển từ INTEGER sang VARCHAR
    Product_id VARCHAR(255),                 -- ID sản phẩm, chuyển từ INTEGER sang VARCHAR
    Date VARCHAR(10),                        -- Ngày giao dịch, chuyển từ DATE sang VARCHAR (định dạng 'YYYY-MM-DD')
    Time VARCHAR(8),                         -- Thời gian giao dịch, chuyển từ TIME sang VARCHAR (định dạng 'HH:MM:SS')
    Quantity VARCHAR(10),                    -- Số lượng, chuyển từ INTEGER sang VARCHAR
    Price VARCHAR(15),                       -- Giá, chuyển từ DECIMAL sang VARCHAR
    Feedback VARCHAR(255),                   -- Phản hồi từ khách hàng, đổi từ TEXT sang VARCHAR
    Ship_method VARCHAR(50),                 -- Phương thức vận chuyển, giữ nguyên VARCHAR
    Payment_method VARCHAR(50),              -- Phương thức thanh toán, giữ nguyên VARCHAR
    Order_Status VARCHAR(50),                -- Trạng thái đơn hàng, giữ nguyên VARCHAR
    Ratings VARCHAR(3)                       -- Đánh giá, chuyển từ DECIMAL sang VARCHAR (định dạng 'X.X')
);
