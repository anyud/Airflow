-- Macro đánh giá doanh thu sản phẩm dựa trên tổng số lượng bán ra
{% macro sales_evaluation(total_quantity_sold) %}
    CASE 
        WHEN {{ total_quantity_sold }} >= 5000 THEN 'Best Seller'         -- Bán chạy
        WHEN {{ total_quantity_sold }} >= 2000 THEN 'Moderate Seller'     -- Bán trung bình
        ELSE 'Low Interest'                                              -- Không được quan tâm
    END
{% endmacro %}
