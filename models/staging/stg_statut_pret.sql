select
    CD_STATUT_PRET,
    LB_STATUT_PRET
from {{ ref('_stg_statut_pret_deduplicated') }}
where rn = 1
    and CD_STATUT_PRET is not null
    and LB_STATUT_PRET is not null