with sales as (

    select * from {{ ref('int_sales') }}

),

monthly as (

    select
        date_trunc('month', transaction_date) as transaction_month,
        sum(case when quantity is not null then quantity else 0 end) as total_units,
        sum(case when revenue is not null then revenue else 0 end) as revenue,
        sum(case when gross_cost is not null then gross_cost else 0 end) as gross_cost,
        sum(case when gross_margin is not null then gross_margin else 0 end) as gross_margin
    from sales
    where transaction_date is not null
    group by 1
    order by 1

)

select
    transaction_month,
    total_units,
    revenue,
    gross_cost,
    gross_margin,
    case
        when gross_cost > 0 then gross_margin / gross_cost
        else null
    end as gross_margin_pct
from monthly
