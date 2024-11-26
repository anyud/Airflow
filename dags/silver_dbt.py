from airflow import DAG
from airflow.operators.bash import BashOperator
from datetime import datetime, timedelta

default_args = {
    'owner': 'airflow',
    'depends_on_past': False,
    'retries': 1,
    'retry_delay': timedelta(minutes=5),
    'start_date': datetime(2024, 11, 1),  # Chỉnh ngày bắt đầu
}

with DAG(
    dag_id='run_dbt_models',
    default_args=default_args,
    description='Run DBT models for transaction and customer details',
    schedule_interval=None,  # Chạy thủ công hoặc đặt lịch
    catchup=False,
) as dag:

    # Task 1: Run DBT for transaction_details
    run_transaction_details = BashOperator(
        task_id='run_transaction_details',
        bash_command='cd D:\\Airflow\\dbt\\dbt_transform && dbt run --select silver.transaction_details'
    )

    # Task 2: Run DBT for customer_details
    run_customer_details = BashOperator(
        task_id='run_customer_details',
        bash_command='cd D:\\Airflow\\dbt\\dbt_transform && dbt run --select silver.customer_details'
    )

    # Task 3: Run both tasks sequentially
    run_transaction_details >> run_customer_details
