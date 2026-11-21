select
    row_number() over (order by CD_STATUT_PRET) as ID_DIM_STATUT_PRET,
    CD_STATUT_PRET,
    LB_STATUT_PRET
from {{ ref('stg_statut_pret') }}