from airflow import DAG
from airflow.providers.postgres.operators.postgres import PostgresOperator
from airflow.operators.dummy import DummyOperator
from datetime import datetime

# Cấu hình các tham số mặc định cho DAG
default_args = {
    'owner': 'anduy',
    'start_date': datetime(2023, 6, 7),
    'retries': 1,
}

# Đường dẫn SQL trong container
SQL_DIR = '/opt/airflow/sql/bronze'

# Khởi tạo DAG với cấu hình và template_searchpath
with DAG(
    dag_id='insert_bronze_data',
    default_args=default_args,
    schedule_interval='@once',
    catchup=False,
    template_searchpath=SQL_DIR,  # Đường dẫn để tìm kiếm file SQL
    tags=['etl', 'load', 'bronze']
) as dag:

    start = DummyOperator(
        task_id = 'start'
    )

    # Task tạo schema bronze
    insert_city = PostgresOperator(
        task_id='insert_city',
        postgres_conn_id='Airflow_postgres',
        sql='insert_city.sql'
    )


    # Task tạo bảng Customer
    insert_customer = PostgresOperator(
        task_id='insert_customer',
        postgres_conn_id='Airflow_postgres',
        sql='insert_cus.sql'
    )

    # Task tạo bảng City
    insert_prod = PostgresOperator(
        task_id='insert_prod',
        postgres_conn_id='Airflow_postgres',
        sql='insert_prod.sql'
    )

    # Task tạo bảng Product
    insert_transaction = PostgresOperator(
        task_id='insert_transaction',
        postgres_conn_id='Airflow_postgres',
        sql='insert_transaction.sql'
    )

   

    # Xác định thứ tự thực thi của các task
    start >> [insert_city, insert_customer, insert_prod, insert_transaction]
