INSERT INTO staging.Product (Product_Id, Product_Name, Product_Category, Product_Brand, Product_Type)
SELECT 
    CAST(Product_Id AS INTEGER) AS Product_id,                               
    Product_Name,
    Product_Category,                          
    Product_Brand,                            
    Product_Type                              
FROM bronze.Product
