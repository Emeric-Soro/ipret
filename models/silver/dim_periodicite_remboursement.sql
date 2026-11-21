select
    row_number() over (order by CD_PERIODICITE_REMBOURSEMENT) as ID_DIM_PERIODICITE_REMBOURSEMENT,
    CD_PERIODICITE_REMBOURSEMENT,
    LB_PERIODICITE_REMBOURSEMENT
from {{ ref('stg_periodicite_remboursement') }}