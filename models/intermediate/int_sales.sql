with source as (

    select * from {{ ref('stg_consolidated_transactions') }}

),

sales_lines as (

    select
        transaction_id,
        transaction_date,
        quantity,
        unit_price,
        cost_for_margin,
        cost_source,
        product_id,
        store_id,
        product_name,
        store_name,
        region_name,
        is_negative_quantity,
        is_missing_product_id,
        is_missing_store_id,
        is_missing_unit_cost,
        has_conflicting_costs,
        is_duplicate_transaction_id
    from source

)

select
    transaction_id,
    transaction_date,
    quantity,
    unit_price,
    cost_for_margin,
    cost_source,
    product_id,
    store_id,
    product_name,
    store_name,
    region_name,
    is_negative_quantity,
    is_missing_product_id,
    is_missing_store_id,
    is_missing_unit_cost,
    has_conflicting_costs,
    is_duplicate_transaction_id,
    case
        when cost_for_margin is not null and unit_price is not null then cost_for_margin * quantity
        else null
    end as gross_cost,
    case
        when cost_for_margin is not null and unit_price is not null then (unit_price - cost_for_margin) * quantity
        else null
    end as gross_margin,
    case
        when cost_for_margin is not null and unit_price is not null then unit_price * quantity
        else null
    end as revenue
from sales_lines
