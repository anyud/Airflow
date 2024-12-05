-- Macro tính điểm R_Score (Recency Score)
{% macro calc_r_score(recency) %}
    CASE 
        WHEN {{ recency }} <= 90 THEN 4
        WHEN {{ recency }} <= 180 THEN 3
        WHEN {{ recency }} <= 270 THEN 2
        ELSE 1
    END
{% endmacro %}

-- Macro tính điểm F_Score (Frequency Score)
{% macro calc_f_score(total_transaction) %}
    CASE 
        WHEN {{ total_transaction }} >= 8 THEN 4
        WHEN {{ total_transaction }} >= 5 THEN 3
        WHEN {{ total_transaction }} >= 2 THEN 2
        ELSE 1  
    END
{% endmacro %}

-- Macro tính điểm M_Score (Monetary Score)
{% macro calc_m_score(total_payment) %}
    CASE 
        WHEN {{ total_payment }} >= 60 THEN 4
        WHEN {{ total_payment }} >= 40 THEN 3
        WHEN {{ total_payment }} >= 20 THEN 2
        ELSE 1
    END
{% endmacro %}
