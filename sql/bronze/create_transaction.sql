CREATE TABLE IF NOT EXISTS bronze.Transaction (
    Transaction_Id VARCHAR(255),           -- ID giao dịch, có thể có giá trị trùng lặp và NULL
    Customer_id INTEGER,                   -- ID khách hàng, có thể có giá trị trùng lặp và NULL
    Product_id INTEGER,                    -- ID sản phẩm, có thể NULL
    Date DATE,                             -- Ngày giao dịch, định dạng ngày (YYYY-MM-DD), không có giá trị NULL
    Time TIME,                             -- Thời gian giao dịch, không có giá trị NULL
    Quantity INTEGER,                      -- Số lượng, có thể NULL
    Price DECIMAL(15, 2),                  -- Giá, có thể NULL
    Feedback TEXT,                         -- Phản hồi từ khách hàng, có thể NULL
    Ship_method VARCHAR(50),               -- Phương thức vận chuyển, có thể NULL
    Payment_method VARCHAR(50),            -- Phương thức thanh toán, có thể NULL
    Order_Status VARCHAR(50),              -- Trạng thái đơn hàng, có thể NULL
    Ratings DECIMAL(2, 1)                  -- Đánh giá, có thể NULL, định dạng cho rating (ví dụ: 4.5)
);
