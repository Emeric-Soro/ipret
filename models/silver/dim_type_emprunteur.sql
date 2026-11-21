select
    row_number() over (order by CD_TYPE_EMPRUNTEUR) as ID_DIM_TYPE_EMPRUNTEUR,
    CD_TYPE_EMPRUNTEUR,
    LB_TYPE_EMPRUNTEUR
from {{ ref('stg_type_emprunteur') }}