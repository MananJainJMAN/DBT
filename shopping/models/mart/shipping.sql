{{
    config(
        tags=['mart']
    )
}}


WITH

--Load all customers who are not part of the "NUNAVUT" region.
not_nun_avt_cust as(
    select * from {{ref('stg_customer')}} where cust_region!='NUNAVUT'
),


delayed_in_days as (
    select
    nauvt.*,
   s.order_id,m.ord_ship_id, DATEDIFF(day, o.order_date, s.ship_date) AS delay_date from {{ref('stg_shipping')}} s 
    join  {{ref('stg_orders')}} o on o.order_id = s.order_id
    join {{ref('stg_market')}} m on  m.ord_ship_id = o.ord_ship_id
    left join not_nun_avt_cust nauvt on nauvt.customer_id=m.cust_id
    

)



select * from delayed_in_days