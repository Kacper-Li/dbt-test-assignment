with source as (

    select * from {{ source('raw', 'consolidated_transactions') }}

),

renamed as (

    select
        cast("Transaction ID" as integer) as transaction_id,
        cast("Transaction Date" as date) as transaction_month,
        cast(quantity as integer) as quantity,
        cast(unit_price as double) as unit_price,
        cast(unit_cost as double) as unit_cost,
        cast(standard_unit_cost as double) as standard_unit_cost,
        cast(landed_unit_cost as double) as landed_unit_cost,
        cast(pack_size as integer) as pack_size,
        cast("Product index" as integer) as product_id,
        cast("Product Name" as varchar) as product_name_on_transaction,
        cast(product_name_catalog as varchar) as product_name_catalog,
        cast(product_category as varchar) as product_category,
        cast("Store ID" as integer) as store_id,
        cast(store_name as varchar) as store_name,
        cast(state_code as varchar) as state_code,
        cast(region_name as varchar) as region_name,
        cast(source_system as varchar) as source_system,
        cast(ingested_at as date) as ingested_at
    from source

)

select * from renamed
