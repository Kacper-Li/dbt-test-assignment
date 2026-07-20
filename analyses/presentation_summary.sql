with sales as (

    select * from {{ ref('fact_sales_over_time') }}

),

top_products as (

    select * from {{ ref('dim_products') }}
    where revenue is not null
    order by gross_margin desc
    limit 10

),

top_stores as (

    select * from {{ ref('dim_stores') }}
    where revenue is not null
    order by gross_margin desc
    limit 10

),

quality as (

    select * from {{ ref('fact_quality_flags') }}

)

select
    'sales_trend' as metric_group,
    transaction_month as metric_period,
    revenue as metric_value
from sales

union all

select
    'top_products' as metric_group,
    product_name as metric_period,
    revenue as metric_value
from top_products

union all

select
    'top_stores' as metric_group,
    store_name as metric_period,
    revenue as metric_value
from top_stores

union all

select
    'quality_flags' as metric_group,
    concat('missing_product_id=', cast(is_missing_product_id as varchar)) as metric_period,
    cast(row_count as double) as metric_value
from quality
