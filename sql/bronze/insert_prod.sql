TRUNCATE bronze.product;

COPY bronze.product
FROM '/opt/airflow/data/master/product.txt'
DELIMITER '|'
CSV HEADER;
