with sales as (

    select * from {{ ref('fact_sales_over_time') }}

),

products as (

    select * from {{ ref('dim_products') }}
    order by gross_margin desc
    limit 5

),

stores as (

    select * from {{ ref('dim_stores') }}
    order by gross_margin desc
    limit 5

),

quality as (

    select * from {{ ref('fact_quality_flags') }}

)

select
    'Monthly trend' as section,
    transaction_month as period,
    revenue,
    gross_margin
from sales

union all

select
    'Top products' as section,
    product_name as period,
    revenue,
    gross_margin
from products

union all

select
    'Top stores' as section,
    store_name as period,
    revenue,
    gross_margin
from stores

union all

select
    'Quality issues' as section,
    concat('missing_product_id=', cast(is_missing_product_id as varchar)) as period,
    cast(total_units as double) as revenue,
    cast(row_count as double) as gross_margin
from quality
