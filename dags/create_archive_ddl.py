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
SQL_DIR = '/opt/airflow/sql/archive'

# Khởi tạo DAG với cấu hình và template_searchpath
with DAG(
    dag_id='create_archive_ddl',
    default_args=default_args,
    schedule_interval='@once',
    catchup=False,
    template_searchpath=SQL_DIR,  # Đường dẫn để tìm kiếm file SQL
    tags=['etl', 'ddl', 'archive']
) as dag:

    # Task tạo schema bronze
    create_schema = PostgresOperator(
        task_id='create_schema',
        postgres_conn_id='Airflow_postgres',
        sql='create_archive.sql'
    )


    # Task tạo bảng Customer
    create_customer_table = PostgresOperator(
        task_id='create_customer_table',
        postgres_conn_id='Airflow_postgres',
        sql='create_cus_archive.sql'
    )

    # Task tạo bảng City
    create_city_table = PostgresOperator(
        task_id='create_city_table',
        postgres_conn_id='Airflow_postgres',
        sql='create_city_archive.sql'
    )

    # Task tạo bảng Product
    create_product_table = PostgresOperator(
        task_id='create_product_table',
        postgres_conn_id='Airflow_postgres',
        sql='create_prod_archive.sql'
    )

    # Task tạo bảng Transaction
    create_transaction_table = PostgresOperator(
        task_id='create_transaction_table',
        postgres_conn_id='Airflow_postgres',
        sql='create_trans_archive.sql'
    )

    # Xác định thứ tự thực thi của các task
    create_schema >> [create_customer_table, create_city_table, create_product_table, create_transaction_table]
