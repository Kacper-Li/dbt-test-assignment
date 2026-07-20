select
    s.transaction_id
from {{ ref('int_sales') }} s
left join {{ ref('int_products') }} p on s.product_id = p.product_id
where s.product_id is not null and p.product_id is null
