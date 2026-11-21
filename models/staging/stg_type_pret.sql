select
    CD_TYPE_PRET,
    LB_TYPE_PRET
from {{ ref('_stg_type_pret_deduplicated') }}
where rn = 1
    and CD_TYPE_PRET is not null
    and LB_TYPE_PRET is not null