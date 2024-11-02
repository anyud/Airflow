from airflow import DAG
from airflow.providers.postgres.operators.postgres import PostgresOperator
from datetime import datetime

# Cấu hình các tham số mặc định cho DAG
default_args = {
    'owner': 'anduy',
    'start_date': datetime(2023, 6, 7),
    'retries': 1,
}

# Đường dẫn SQL trong container
SQL_DIR = '/opt/airflow/sql/staging'

# Khởi tạo DAG với cấu hình và template_searchpath
with DAG(
    dag_id='create_staging_ddl',
    default_args=default_args,
    schedule_interval='@once',
    catchup=False,
    template_searchpath=SQL_DIR,  # Đường dẫn để tìm kiếm file SQL
    tags=['etl', 'ddl', 'staging']
) as dag:

    # Task tạo schema bronze
    create_schema = PostgresOperator(
        task_id='create_schema',
        postgres_conn_id='Airflow_postgres',
        sql='create_staging.sql'
    )

    # Task tạo bảng Customer
    create_customer_staging = PostgresOperator(
        task_id='create_customer_staging',
        postgres_conn_id='Airflow_postgres',
        sql='create_cus_staging.sql'
    )

    # Task tạo bảng City
    create_city_staging = PostgresOperator(
        task_id='create_city_staging',
        postgres_conn_id='Airflow_postgres',
        sql='create_city_staging.sql'
    )

    # Task tạo bảng Product
    create_product_staging = PostgresOperator(
        task_id='create_product_staging',
        postgres_conn_id='Airflow_postgres',
        sql='create_prod_staging.sql'
    )

    # Task tạo bảng Transaction
    create_transaction_staging = PostgresOperator(
        task_id='create_transaction_staging',
        postgres_conn_id='Airflow_postgres',
        sql='create_transaction_staging.sql'
    )

    load_city_data = PostgresOperator(
        task_id='load_city_data',
        postgres_conn_id='Airflow_postgres',
        sql='select_city.sql'  # Thay bằng đường dẫn thực tế
    )

    load_cus_data = PostgresOperator(
        task_id='load_cus_data',
        postgres_conn_id='Airflow_postgres',
        sql='select_cus.sql'  # Thay bằng đường dẫn thực tế
    )

    load_prod_data = PostgresOperator(
        task_id='load_prod_data',
        postgres_conn_id='Airflow_postgres',
        sql='select_prod.sql'  # Thay bằng đường dẫn thực tế
    )

    load_trans_data = PostgresOperator(
        task_id='load_trans_data',
        postgres_conn_id='Airflow_postgres',
        sql='select_trans.sql'  # Thay bằng đường dẫn thực tế
    )
    # Xác định thứ tự thực thi của các task
    create_schema >> create_city_staging >> load_city_data
    create_schema >> create_customer_staging >> load_cus_data
    create_schema >> create_product_staging >> load_prod_data
    create_schema >> create_transaction_staging >> load_trans_data
