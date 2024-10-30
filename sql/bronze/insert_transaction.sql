COPY bronze.transaction
FROM '/opt/airflow/data/transaction/transaction_202311.txt'
DELIMITER '|'
CSV;

COPY bronze.transaction
FROM '/opt/airflow/data/transaction/transaction_202312.txt'
DELIMITER '|'
CSV;

COPY bronze.transaction
FROM '/opt/airflow/data/transaction/transaction_202401.txt'
DELIMITER '|'
CSV;
