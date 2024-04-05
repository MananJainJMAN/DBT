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

total_orders as 
(
    select cust_id,count(*) as total_order from {{ref('stg_market')}} group by cust_id
),
total_amount as 
(
    select cust_id,sum(value) as total_amount from {{ref('stg_market')}} group by cust_id
),

order_details as(
    select o.order_id,o.order_date,m.cust_id from {{ref('stg_orders')}} o join {{ref('stg_market')}} m on m.ord_ship_id = o.ord_ship_id 
),

final as(

SELECT
nunavut.*,
    od.cust_id,
    MIN(od.order_date) OVER (PARTITION BY od.cust_id) AS first_ordered_date,
    MAX(od.order_date) OVER (PARTITION BY od.cust_id) AS most_recent_date,
    tos.total_order,
    ta.total_amount
FROM
    order_details od join total_orders tos on tos.cust_id = od.cust_id
    join total_amount ta on ta.cust_id = od.cust_id
    left join not_nun_avt_cust  nunavut on nunavut.customer_id = od.cust_id
)

select * from final

--null values are present for some of the customername,customerid and customer region