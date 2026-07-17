with source as (

    select * from {{ source('raw', 'products') }}

),

renamed as (

    select
        cast("Index" as integer) as product_id,
        cast("Product Name" as varchar) as product_name,
        cast("Product category" as varchar) as product_category,
        cast(is_active as boolean) as is_active
    from source

),

-- Sample choice: keep the active dimension version only.
-- Duplicate Index rows exist in the raw extract — document your rule if you differ.
active_only as (

    select
        product_id,
        product_name,
        product_category
    from renamed
    where is_active

)

select * from active_only
