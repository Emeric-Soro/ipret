{{ config(alias='dim_emprunteur') }}

select
    e.ID_DIM_EMPRUNTEUR,
    e.ID_EMPRUNTEUR,
    coalesce(e.LB_CIVILITE_EMPRUNTEUR, 'INCONNU') as LB_CIVILITE_EMPRUNTEUR,
    e.LB_NOM_EMPRUNTEUR,
    e.LB_PRENOM_EMPRUNTEUR,
    e.DT_NAISSANCE_EMPRUNTEUR,
    e.LB_EMAIL_EMPRUNTEUR,
    pc.CD_POSTAL,
    d.CD_DEPARTMENT,
    coalesce(d.DEPARTMENT_NAME, 'INCONNU') as DEPARTMENT_NAME,
    r.CD_REGION,
    coalesce(r.REGION_NAME, 'INCONNU') as REGION_NAME,
    coalesce(c.LIB_COUNTRY, 'INCONNU') as LIB_COUNTRY,
    te.CD_TYPE_EMPRUNTEUR,
    te.LB_TYPE_EMPRUNTEUR,
    se.CD_STATUT_EMPRUNTEUR,
    se.LB_STATUT_EMPRUNTEUR
from {{ ref('dim_emprunteur') }} e
    left outer join {{ ref('dim_postal_code') }} pc
        on e.ID_DIM_POSTAL_CODE = pc.ID_DIM_POSTAL_CODE
    left outer join {{ ref('dim_department') }} d
        on pc.ID_DIM_DEPARTMENT = d.ID_DIM_DEPARTMENT
    left outer join {{ ref('dim_region') }} r
        on d.ID_DIM_REGION = r.ID_DIM_REGION
    left outer join {{ ref('dim_country') }} c
        on r.ID_DIM_COUNTRY = c.ID_DIM_COUNTRY
    left outer join {{ ref('dim_type_emprunteur') }} te
        on e.ID_DIM_TYPE_EMPRUNTEUR = te.ID_DIM_TYPE_EMPRUNTEUR
    left outer join {{ ref('dim_statut_emprunteur') }} se
        on e.ID_DIM_STATUT_EMPRUNTEUR = se.ID_DIM_STATUT_EMPRUNTEUR