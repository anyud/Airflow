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
SQL_DIR = '/opt/airflow/sql/gold'

# Khởi tạo DAG với cấu hình và template_searchpath
with DAG(
    dag_id='create_gold_ddl',
    default_args=default_args,
    schedule_interval='@once',
    catchup=False,
    template_searchpath=SQL_DIR,  # Đường dẫn để tìm kiếm file SQL
    tags=['etl', 'ddl', 'gold']
) as dag:

    # Task tạo schema bronze
    create_schema = PostgresOperator(
        task_id='create_schema',
        postgres_conn_id='Airflow_postgres',
        sql='create_gold.sql'
    )

    # Task tạo bảng Customer
    create_seg = PostgresOperator(
        task_id='create_seg',
        postgres_conn_id='Airflow_postgres',
        sql='create_seg.sql'
    )

    create_geo = PostgresOperator(
        task_id='create_geo',
        postgres_conn_id='Airflow_postgres',
        sql='create_geo.sql'
    )
    
    create_sale = PostgresOperator(
        task_id='create_sale',
        postgres_conn_id='Airflow_postgres',
        sql='create_sale.sql'
    )

    load_seg_data = PostgresOperator(
        task_id='load_seg_data',
        postgres_conn_id='Airflow_postgres',
        sql='insert_seg.sql'  # Thay bằng đường dẫn thực tế
    )
    
    load_geo_data = PostgresOperator(
        task_id='load_geo_data',
        postgres_conn_id='Airflow_postgres',
        sql='insert_geo.sql'  # Thay bằng đường dẫn thực tế
    )

    load_sale_data = PostgresOperator(
        task_id='load_sale_data',
        postgres_conn_id='Airflow_postgres',
        sql='insert_sale.sql'  # Thay bằng đường dẫn thực tế
    )

    #Xác định thứ tự thực thi của các task
    create_schema >> create_seg >> load_seg_data
    create_schema >> create_geo >> load_geo_data
    create_schema >> create_sale >> load_sale_data
    
    
