TRUNCATE bronze.city;

COPY bronze.city
FROM '/opt/airflow/data/master/city.txt'
DELIMITER '|'
CSV HEADER;
