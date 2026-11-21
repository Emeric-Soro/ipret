select
    CD_PERIODICITE_REMBOURSEMENT,
    LB_PERIODICITE_REMBOURSEMENT
from {{ ref('_stg_periodicite_remboursement_deduplicated') }}
where rn = 1
    and CD_PERIODICITE_REMBOURSEMENT is not null
    and LB_PERIODICITE_REMBOURSEMENT is not null