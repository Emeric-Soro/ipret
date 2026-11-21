{{ config(
    materialized = 'incremental',
    unique_key = ['rejection_id']
) }}

select
    {{ dbt_utils.generate_surrogate_key(['ID_EMPRUNTEUR', 'LB_NOM_EMPRUNTEUR', 'rn']) }} as rejection_id,
    ID_EMPRUNTEUR,
    LB_CIVILITE_EMPRUNTEUR,
    LB_NOM_EMPRUNTEUR,
    LB_PRENOM_EMPRUNTEUR,
    DT_NAISSANCE_EMPRUNTEUR,
    LB_EMAIL_EMPRUNTEUR,
    CD_POSTAL_EMPRUNTEUR,
    CD_TYPE_EMPRUNTEUR,
    CD_STATUT_EMPRUNTEUR,
    convert_timezone('Europe/Paris', current_timestamp()) as rejected_at,
    case
        when ID_EMPRUNTEUR is null then 'missing ID_EMPRUNTEUR'
        when LB_NOM_EMPRUNTEUR is null then 'missing LB_NOM_EMPRUNTEUR'
        when CD_TYPE_EMPRUNTEUR is null then 'missing CD_TYPE_EMPRUNTEUR'
        when CD_STATUT_EMPRUNTEUR is null then 'missing CD_STATUT_EMPRUNTEUR'
        when rn > 1 then 'deduplicate key'
    end as rejected_reason

from {{ ref('_stg_emprunteur_deduplicated') }}
where rn > 1
    or ID_EMPRUNTEUR is null
    or LB_NOM_EMPRUNTEUR is null
    or CD_TYPE_EMPRUNTEUR is null
    or CD_STATUT_EMPRUNTEUR is null