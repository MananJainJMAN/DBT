{{
    config(
        tags=['mart']
    )
}}

with
not_nun_avt_cust as(
    select * from {{ref('stg_customer')}} where cust_region!='NUNAVUT'
),
order_details as(
    select o.order_id,m.cust_id from {{ref('stg_orders')}} o join {{ref('stg_market')}} m on m.ord_ship_id = o.ord_ship_id 
),
final as(

SELECT
    o.*
FROM
    order_details od
    join {{ref('stg_orders')}} o on o.order_id = od.order_id 
    left join not_nun_avt_cust  nunavut on nunavut.customer_id = od.cust_id
)

select * from final
