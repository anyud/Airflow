-- Macro đánh giá số lượng giao dịch khu vực (Sales Evaluation)
{% macro geo_sales_evaluation(total_transactions) %}
    CASE 
        WHEN {{ total_transactions }} >= 10000 THEN 'Outstanding'
        WHEN {{ total_transactions }} >= 5000 THEN 'High Activity'
        WHEN {{ total_transactions }} >= 1000 THEN 'Moderate Activity'
        ELSE 'Low Activity'
    END
{% endmacro %}
