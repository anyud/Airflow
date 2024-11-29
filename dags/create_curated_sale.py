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
SQL_DIR = '/opt/airflow/sql/silver'

# Khởi tạo DAG với cấu hình và template_searchpath
with DAG(
    dag_id='create_silver_ddl',
    default_args=default_args,
    schedule_interval='@once',
    catchup=False,
    template_searchpath=SQL_DIR,  # Đường dẫn để tìm kiếm file SQL
    tags=['etl', 'ddl', 'curated']
) as dag:

    # Task tạo schema bronze
    create_schema = PostgresOperator(
        task_id='create_schema',
        postgres_conn_id='Airflow_postgres',
        sql='create_silver.sql'
    )

    # Task tạo bảng Customer
    create_cust_loc = PostgresOperator(
        task_id='create_customer_loc',
        postgres_conn_id='Airflow_postgres',
        sql='create_cust_loc.sql'
    )
    
    create_comb = PostgresOperator(
        task_id='create_comb',
        postgres_conn_id='Airflow_postgres',
        sql='create_comb.sql'
    )
    
    load_cust_loc_data = PostgresOperator(
        task_id='load_cust_loc_data',
        postgres_conn_id='Airflow_postgres',
        sql='insert_comb.sql'  # Thay bằng đường dẫn thực tế
    )

    load_comb_data = PostgresOperator(
        task_id='load_comb_data',
        postgres_conn_id='Airflow_postgres',
        sql='insert_cust_loc.sql'  # Thay bằng đường dẫn thực tế
    )
    # Xác định thứ tự thực thi của các task
    create_schema >> create_cust_loc >> load_cust_loc_data
    create_schema >> create_comb >> load_comb_data
    
