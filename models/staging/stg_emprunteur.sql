select
    ID_EMPRUNTEUR,
    LB_CIVILITE_EMPRUNTEUR,
    LB_NOM_EMPRUNTEUR,
    LB_PRENOM_EMPRUNTEUR,
    DT_NAISSANCE_EMPRUNTEUR,
    LB_EMAIL_EMPRUNTEUR,
    CD_POSTAL_EMPRUNTEUR,
    CD_TYPE_EMPRUNTEUR,
    CD_STATUT_EMPRUNTEUR
from {{ ref('_stg_emprunteur_deduplicated') }}
where rn = 1
    and ID_EMPRUNTEUR is not null
    and LB_NOM_EMPRUNTEUR is not null
    and CD_TYPE_EMPRUNTEUR is not null
    and CD_STATUT_EMPRUNTEUR is not null