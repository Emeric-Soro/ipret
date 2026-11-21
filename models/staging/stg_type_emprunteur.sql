select
    CD_TYPE_EMPRUNTEUR,
    LB_TYPE_EMPRUNTEUR
from {{ ref('_stg_type_emprunteur_deduplicated') }}
where rn = 1
    and CD_TYPE_EMPRUNTEUR is not null
    and LB_TYPE_EMPRUNTEUR is not null