with source as (

    select * from {{ source('raw', 'consolidated_transactions') }}

),

cleaned as (

    select
        case
            when regexp_matches(nullif(trim(cast("Transaction ID" as varchar)), ''), '^-?\\d+(\\.0+)?$')
                then cast(nullif(trim(cast("Transaction ID" as varchar)), '') as integer)
            else null
        end as transaction_id,
        try_cast("Transaction Date" as date) as transaction_date,
        try_cast(quantity as integer) as quantity,
        try_cast(unit_price as double) as unit_price,
        try_cast(unit_cost as double) as unit_cost,
        try_cast(standard_unit_cost as double) as standard_unit_cost,
        try_cast(landed_unit_cost as double) as landed_unit_cost,
        try_cast(pack_size as integer) as pack_size,
        case
            when regexp_matches(nullif(trim(cast("Product index" as varchar)), ''), '^-?\\d+(\\.0+)?$')
                then cast(nullif(trim(cast("Product index" as varchar)), '') as integer)
            else null
        end as product_id,
        nullif(trim(cast("Product Name" as varchar)), '') as product_name_on_transaction,
        nullif(trim(cast(product_name_catalog as varchar)), '') as product_name_catalog,
        coalesce(
            nullif(trim(cast(product_name_catalog as varchar)), ''),
            nullif(trim(cast("Product Name" as varchar)), '')
        ) as product_name,
        nullif(trim(cast(product_category as varchar)), '') as product_category,
        case
            when regexp_matches(nullif(trim(cast("Store ID" as varchar)), ''), '^-?\\d+(\\.0+)?$')
                then cast(nullif(trim(cast("Store ID" as varchar)), '') as integer)
            else null
        end as store_id,
        nullif(trim(cast(store_name as varchar)), '') as store_name,
        nullif(trim(cast(state_code as varchar)), '') as state_code,
        nullif(trim(cast(region_name as varchar)), '') as region_name,
        nullif(trim(cast(source_system as varchar)), '') as source_system,
        try_cast(ingested_at as date) as ingested_at,
        case when try_cast(quantity as integer) is not null and try_cast(quantity as integer) < 0 then true else false end as is_negative_quantity,
        case when try_cast("Product index" as integer) is null then true else false end as is_missing_product_id,
        case when try_cast("Store ID" as integer) is null then true else false end as is_missing_store_id,
        case when try_cast(unit_cost as double) is null and try_cast(standard_unit_cost as double) is null and try_cast(landed_unit_cost as double) is null then true else false end as is_missing_unit_cost,
        case
            when try_cast(standard_unit_cost as double) is not null
                and try_cast(landed_unit_cost as double) is not null
                and try_cast(standard_unit_cost as double) <> try_cast(landed_unit_cost as double)
                then true
            else false
        end as has_conflicting_costs,
        case
            when try_cast(standard_unit_cost as double) is not null then 'standard'
            when try_cast(landed_unit_cost as double) is not null then 'landed'
            when try_cast(unit_cost as double) is not null then 'unit'
            else null
        end as cost_source,
        coalesce(
            try_cast(standard_unit_cost as double),
            try_cast(landed_unit_cost as double),
            try_cast(unit_cost as double)
        ) as cost_for_margin
    from source

),

flagged as (

    select
        *,
        case
            when transaction_id is not null and count(*) over (partition by transaction_id) > 1 then true else false
        end as is_duplicate_transaction_id
    from cleaned

)

select * from flagged
