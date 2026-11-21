select
    row_number() over (order by CD_MODE_REMBOURSEMENT) as ID_DIM_MODE_REMBOURSEMENT,
    CD_MODE_REMBOURSEMENT,
    LB_MODE_REMBOURSEMENT
from {{ ref('stg_mode_remboursement') }}