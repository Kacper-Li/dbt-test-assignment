select
    product_key
from {{ ref('int_products') }}
where product_key is null
