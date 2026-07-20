with sales as (

    select * from {{ ref('int_sales') }}

),

sales_by_month as (

    select
        date_trunc('month', transaction_date) as transaction_month,
        product_id,
        store_id,
        sum(case when quantity is not null then quantity else 0 end) as total_units,
        sum(case when revenue is not null then revenue else 0 end) as revenue,
        sum(case when gross_margin is not null then gross_margin else 0 end) as gross_margin
    from sales
    where transaction_date is not null
    group by 1, 2, 3

),

year_2022 as (

    select
        transaction_month,
        product_id,
        store_id,
        total_units,
        revenue,
        gross_margin
    from sales_by_month
    where transaction_month >= date '2022-01-01'
      and transaction_month < date '2023-01-01'

)

select * from year_2022
order by transaction_month, revenue desc
