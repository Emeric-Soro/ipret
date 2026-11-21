select
    row_number() over (order by CD_TYPE_PRET) as ID_DIM_TYPE_PRET,
    CD_TYPE_PRET,
    LB_TYPE_PRET
from {{ ref('stg_type_pret') }}