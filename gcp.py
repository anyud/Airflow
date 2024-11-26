from google.cloud import storage

def upload_to_gcs(bucket_name, source_file_path, destination_blob_name):
    """
    Upload file lên Google Cloud Storage.

    Args:
        bucket_name (str): Tên bucket trong Google Cloud Storage.
        source_file_path (str): Đường dẫn file trên máy cục bộ.
        destination_blob_name (str): Tên file khi lưu trên bucket.
    """
    # Khởi tạo client từ key JSON
    storage_client = storage.Client.from_service_account_json(r"D:\Airflow\posgresql-vm-de6c5c9d2b35.json")

    # Lấy bucket
    bucket = storage_client.get_bucket(bucket_name)

    # Tạo blob (file) trong bucket
    blob = bucket.blob(destination_blob_name)

    # Upload file
    blob.upload_from_filename(source_file_path)

    print(f"File {source_file_path} uploaded to gs://{bucket_name}/{destination_blob_name}.")

# Thông tin upload
bucket_name = "migrate-test-123"  # Tên bucket
source_file_path = "D:/Airflow/data/backup.sql"  # Đường dẫn file cục bộ
destination_blob_name = "backup.sql"  # Tên file trên bucket

# Thực hiện upload
upload_to_gcs(bucket_name, source_file_path, destination_blob_name)
