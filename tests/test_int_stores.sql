select
    store_key
from {{ ref('int_stores') }}
where store_key is null
