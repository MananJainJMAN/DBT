{{
    config(
        tags=['basic', 'staging']
    )
}}

with 
required_fields as(
    select 
    cast(order_id as int) as order_id,
    -- convert(date,order_date) as order_date
    convert(date,order_date,103) as order_date,
    order_priority,
    ord_id as ord_ship_id

    from {{source('shop','order')}}  
)

select * from required_fields