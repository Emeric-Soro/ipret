select
    CD_MODE_REMBOURSEMENT,
    LB_MODE_REMBOURSEMENT
from {{ ref('_stg_mode_remboursement_deduplicated') }}
where rn = 1
    and CD_MODE_REMBOURSEMENT is not null
    and LB_MODE_REMBOURSEMENT is not null