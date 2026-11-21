select
    row_number() over (order by CD_STATUT_EMPRUNTEUR) as ID_DIM_STATUT_EMPRUNTEUR,
    CD_STATUT_EMPRUNTEUR,
    LB_STATUT_EMPRUNTEUR
from {{ ref('stg_statut_emprunteur') }}