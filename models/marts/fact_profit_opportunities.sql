with sales as (

    select * from {{ ref('int_sales') }}

),

opportunities as (

    select
        product_id,
        store_id,
        sum(case when quantity is not null then quantity else 0 end) as total_units,
        sum(case when revenue is not null then revenue else 0 end) as revenue,
        sum(case when gross_margin is not null then gross_margin else 0 end) as gross_margin,
        sum(case when gross_cost is not null then gross_cost else 0 end) as gross_cost
    from sales
    group by 1, 2

)

select
    product_id,
    store_id,
    total_units,
    revenue,
    gross_cost,
    gross_margin,
    case
        when gross_cost > 0 then gross_margin / gross_cost
        else null
    end as gross_margin_pct
from opportunities
order by gross_margin_pct desc, gross_margin desc
