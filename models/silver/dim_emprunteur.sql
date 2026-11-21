select
    row_number() over (order by e.ID_EMPRUNTEUR) as ID_DIM_EMPRUNTEUR,
    e.ID_EMPRUNTEUR,
    e.LB_CIVILITE_EMPRUNTEUR,
    e.LB_NOM_EMPRUNTEUR,
    e.LB_PRENOM_EMPRUNTEUR,
    {{ to_date_multi("e.DT_NAISSANCE_EMPRUNTEUR") }} as DT_NAISSANCE_EMPRUNTEUR,
    e.LB_EMAIL_EMPRUNTEUR,
    coalesce(pc.ID_DIM_POSTAL_CODE, -1) as ID_DIM_POSTAL_CODE,
    te.ID_DIM_TYPE_EMPRUNTEUR,
    se.ID_DIM_STATUT_EMPRUNTEUR
from {{ ref('stg_emprunteur') }} e
    left outer join {{ ref('dim_postal_code') }} pc
        on e.CD_POSTAL_EMPRUNTEUR = pc.cd_postal
    left outer join {{ ref('dim_type_emprunteur') }} te
        on e.CD_TYPE_EMPRUNTEUR = te.CD_TYPE_EMPRUNTEUR
    left outer join {{ ref('dim_statut_emprunteur') }} se
        on e.CD_STATUT_EMPRUNTEUR = se.CD_STATUT_EMPRUNTEUR
where te.CD_TYPE_EMPRUNTEUR is not null
    and se.CD_STATUT_EMPRUNTEUR is not null