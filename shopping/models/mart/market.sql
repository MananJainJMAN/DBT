{{
    config(
        tags=['mart']
    )
}}

WITH

final_report as(

    select m.*,p.PRODUCT_CATEGORY,p.PRODUCT_SUB_CATEGORY from {{ref('stg_market')}} m
    join {{ref('product')}} p on p.prod_id = m.prod_id
)

SELECT * from final_report