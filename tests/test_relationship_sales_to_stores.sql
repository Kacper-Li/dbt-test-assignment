select
    s.transaction_id
from {{ ref('int_sales') }} s
left join {{ ref('int_stores') }} st on s.store_id = st.store_id
where s.store_id is not null and st.store_id is null
