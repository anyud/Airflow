{{ config(
    materialized='incremental',  
    unique_key='Transaction_ID'  
) }}

SELECT 
    t.Transaction_Id AS Transaction_ID,
    t.Customer_id AS Customer_ID,
    t.Product_id AS Product_ID,
    t.Date AS Date,
    t.Time AS Time,
    t.Quantity AS Quantity,
    t.Price AS Price,
    t.Feedback AS Feedback,
    t.Ratings AS Ratings,
    p.Product_Name AS Product_Name,
    p.Product_Category AS Product_Category,
    p.Product_Brand AS Product_Brand,
    p.Product_Type AS Product_Type,
    c.City_ID AS City_ID,
    ci.Country AS Country
FROM 
    {{ source('test', 'transaction') }} t
JOIN 
    {{ source('test', 'customer') }} c ON t.Customer_id = c.Customer_id
JOIN 
    {{ source('test', 'product') }} p ON t.Product_id = p.Product_id
JOIN 
    {{ source('test', 'city') }} ci ON c.City_ID = ci.CityId

{% if is_incremental() %}
WHERE t.Date > (SELECT MAX(Date) FROM {{ this }})
{% endif %}
