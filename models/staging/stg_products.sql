with source as (

    select * from {{ source('raw', 'products') }}

),

renamed as (

    select
        cast("Index" as integer) as product_id,
        cast("Product Name" as varchar) as product_name,
        cast("Product category" as varchar) as product_category
    from source

)

select * from renamed
