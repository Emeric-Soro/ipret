with cleaned_emprunteur as (
    select
        {{ null_if_placeholder("ID_EMPRUNTEUR") }} as ID_EMPRUNTEUR,
        {{ null_if_placeholder("regexp_replace(initcap(LB_CIVILITE_EMPRUNTEUR), '\\\\s+', ' ')") }} as LB_CIVILITE_EMPRUNTEUR,
        {{ null_if_placeholder("regexp_replace(initcap(LB_NOM_EMPRUNTEUR, ' -'), '\\\\s+', ' ')") }} as LB_NOM_EMPRUNTEUR,
        {{ null_if_placeholder("regexp_replace(initcap(LB_PRENOM_EMPRUNTEUR, ' -'), '\\\\s+', ' ')") }} as LB_PRENOM_EMPRUNTEUR,
        {{ null_if_placeholder("DT_NAISSANCE_EMPRUNTEUR") }} as DT_NAISSANCE_EMPRUNTEUR,
        {{ null_if_placeholder("lower(LB_EMAIL_EMPRUNTEUR)") }} as LB_EMAIL_EMPRUNTEUR,
        {{ null_if_placeholder("upper(CD_POSTAL_EMPRUNTEUR)") }} as CD_POSTAL_EMPRUNTEUR,
        {{ null_if_placeholder("CD_TYPE_EMPRUNTEUR") }} as CD_TYPE_EMPRUNTEUR,
        {{ null_if_placeholder("CD_STATUT_EMPRUNTEUR") }} as CD_STATUT_EMPRUNTEUR
    from {{ source('bronze', 'TB_EMPRUNTEUR') }}
)

select
    *,
    row_number() over (
        partition by ID_EMPRUNTEUR
        order by LB_NOM_EMPRUNTEUR
    ) as rn
from cleaned_emprunteur