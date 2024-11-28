{{ config(
    materialized='incremental',  
    unique_key='Customer_ID'     
) }}

SELECT 
    c.Customer_ID AS Customer_ID,
    c.Name AS Name,
    c.Email AS Email,
    c.Phone AS Phone,
    c.Address AS Address,
    c.City_ID AS City_ID,
    c.Age AS Age,
    c.Gender AS Gender,
    c.Income AS Income,
    c.Customer_Segment AS Customer_Segment,
    city.City AS City,
    city.Country AS Country
FROM 
    {{ source('test', 'customer') }} AS c -- Tham chiếu bảng test_customer trên BigQuery
JOIN 
    {{ source('test', 'city') }} AS city ON c.City_ID = city.CityId

{% if is_incremental() %}
-- Thêm dữ liệu mới dựa trên Customer_ID nếu bảng đã tồn tại
WHERE c.Customer_ID NOT IN (SELECT Customer_ID FROM {{ this }})
{% endif %}
