{{
    config(
        tags=['basic', 'staging']
    )
}}


WITH 
-- done type casting and renaming 
required_fields as(
    select
    customer_name,
    cust_id as customer_id,
    region as cust_region
    from {{source('shop','customer')}}
)

select * from required_fields