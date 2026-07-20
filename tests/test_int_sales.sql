select
    transaction_id
from {{ ref('int_sales') }}
where transaction_id is null
  and transaction_date is null
