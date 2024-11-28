{{config(
    materialized= 'table'
)}}

{{ segmentation(
    source_combine='combine',
    source_cust_loc='cust_loc'
)}}