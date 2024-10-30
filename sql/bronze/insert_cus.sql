COPY bronze.customer
FROM '/opt/airflow/data/customer/customer_202311.txt'
DELIMITER '|'
CSV;

COPY bronze.customer
FROM '/opt/airflow/data/customer/customer_202312.txt'
DELIMITER '|'
CSV;

COPY bronze.customer
FROM '/opt/airflow/data/customer/customer_202401.txt'
DELIMITER '|'
CSV;

COPY bronze.customer
FROM '/opt/airflow/data/customer/customer_202402.txt'
DELIMITER '|'
CSV;
