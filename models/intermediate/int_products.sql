with source as (

    select * from {{ ref('stg_consolidated_transactions') }}

),

deduped as (

    select
        product_id,
        product_name,
        product_name_on_transaction,
        product_name_catalog,
        product_category,
        source_system
    from source
    group by
        product_id,
        product_name,
        product_name_on_transaction,
        product_name_catalog,
        product_category,
        source_system

)

select
    case
        when product_id is not null then concat('product_id|', cast(product_id as varchar))
        else concat('product_name|', md5(concat(coalesce(product_name, ''), '|', coalesce(product_category, ''), '|', coalesce(source_system, ''))))
    end as product_key,
    product_id,
    coalesce(product_name, product_name_on_transaction, product_name_catalog) as product_name,
    product_name_on_transaction,
    product_name_catalog,
    product_category,
    source_system
from deduped
