select
    e.ID_EMPRUNTEUR,
    e.LB_CIVILITE_EMPRUNTEUR,
    e.LB_NOM_EMPRUNTEUR,
    e.LB_PRENOM_EMPRUNTEUR,
    e.DT_NAISSANCE_EMPRUNTEUR,
    e.LB_EMAIL_EMPRUNTEUR,
    e.CD_POSTAL_EMPRUNTEUR,
    e.CD_TYPE_EMPRUNTEUR,
    e.CD_STATUT_EMPRUNTEUR,
    convert_timezone('Europe/Paris', current_timestamp()) as rejected_at,
    case
        when te.CD_TYPE_EMPRUNTEUR is null then 'unmatched type emprunteur'
        when se.CD_STATUT_EMPRUNTEUR is null then 'unmatched statut emprunteur'
    end as rejected_reason
from {{ ref('stg_emprunteur') }} e
    left outer join {{ ref('dim_type_emprunteur') }} te
        on e.CD_TYPE_EMPRUNTEUR = te.CD_TYPE_EMPRUNTEUR
    left outer join {{ ref('dim_statut_emprunteur') }} se
        on e.CD_STATUT_EMPRUNTEUR = se.CD_STATUT_EMPRUNTEUR
where te.CD_TYPE_EMPRUNTEUR is null
    or se.CD_STATUT_EMPRUNTEUR is null