with source as (

    select * from {{ source('raw', 'products') }}

),

renamed as (

    select
        cast("Index" as integer) as product_id,
        cast("Product Name" as varchar) as product_name,
        cast("Product category" as varchar) as product_category,
        cast(pack_size as integer) as pack_size,
        cast(effective_from as date) as effective_from,
        cast(effective_to as date) as effective_to
    from source

),

-- Sample choice: one row per product_id.
-- Raw products may have overlapping effective ranges — document your rule if you differ.
deduped as (

    select
        product_id,
        product_name,
        product_category,
        pack_size
    from renamed
    qualify row_number() over (
        partition by product_id
        order by effective_from asc, effective_to desc
    ) = 1

)

select * from deduped
