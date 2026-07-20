with sales as (

    select * from {{ ref('int_sales') }}

),

products as (

    select * from {{ ref('int_products') }}

),

joined as (

    select
        sales.product_id,
        products.product_name,
        products.product_category,
        sum(case when sales.quantity is not null then sales.quantity else 0 end) as total_units,
        sum(case when sales.revenue is not null then sales.revenue else 0 end) as revenue,
        sum(case when sales.gross_cost is not null then sales.gross_cost else 0 end) as gross_cost,
        sum(case when sales.gross_margin is not null then sales.gross_margin else 0 end) as gross_margin
    from sales
    left join products on sales.product_id = products.product_id
    group by 1, 2, 3

)

select
    product_id,
    product_name,
    product_category,
    total_units,
    revenue,
    gross_cost,
    gross_margin,
    case
        when gross_cost > 0 then gross_margin / gross_cost
        else null
    end as gross_margin_pct
from joined
order by gross_margin desc
