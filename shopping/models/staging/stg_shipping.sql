{{
    config(
        tags=['basic', 'staging']
    )
}}

WITH

required_fields as(

    select order_id,
    convert(date,ship_date,103) as ship_date,
    ship_id
    from {{source('shop','shipping')}}
)

select * from required_fields