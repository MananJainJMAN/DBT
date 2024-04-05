{{
    config(
        tags=['basic', 'staging']
    )
}}

WITH
required_fields as(
select
    ord_id as ord_ship_id,
    ship_id,
    prod_id,
    cust_id,
    order_quantity,
    cast(sales as decimal) as value
    from
    {{source('shop','market')}}
)



select * from required_fields