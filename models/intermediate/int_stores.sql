with source as (

    select * from {{ ref('stg_consolidated_transactions') }}

),

deduped as (

    select
        store_id,
        store_name,
        state_code,
        region_name,
        source_system
    from source
    group by
        store_id,
        store_name,
        state_code,
        region_name,
        source_system

)

select
    case
        when store_id is not null then concat('store_id|', cast(store_id as varchar))
        else concat('store_name|', md5(concat(coalesce(store_name, ''), '|', coalesce(state_code, ''), '|', coalesce(region_name, ''))))
    end as store_key,
    store_id,
    store_name,
    state_code,
    region_name,
    source_system
from deduped
