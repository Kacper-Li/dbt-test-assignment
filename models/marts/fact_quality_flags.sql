with sales as (

    select * from {{ ref('int_sales') }}

)

select
    is_missing_product_id,
    is_missing_store_id,
    is_missing_unit_cost,
    has_conflicting_costs,
    is_negative_quantity,
    is_duplicate_transaction_id,
    count(*) as row_count,
    sum(case when quantity is not null then quantity else 0 end) as total_units
from sales
group by 1, 2, 3, 4, 5, 6
order by row_count desc
