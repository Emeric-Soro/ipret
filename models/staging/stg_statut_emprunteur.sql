select
    CD_STATUT_EMPRUNTEUR,
    LB_StATUT_EMPRUNTEUR
from {{ ref('_stg_statut_emprunteur_deduplicated') }}
where rn = 1
    and CD_STATUT_EMPRUNTEUR is not null
    and LB_STATUT_EMPRUNTEUR is not null