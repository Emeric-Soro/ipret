{{ config(
    materialized = 'incremental',
    unique_key = ['rejection_id']
) }}

select
    {{ dbt_utils.generate_surrogate_key(['CD_STATUT_EMPRUNTEUR', 'LB_STATUT_EMPRUNTEUR', 'rn']) }} as rejection_id,
    CD_STATUT_EMPRUNTEUR,
    LB_STATUT_EMPRUNTEUR,
    convert_timezone('Europe/Paris', current_timestamp()) as rejected_at,
    case
        when CD_STATUT_EMPRUNTEUR is null then 'missing CD_STATUT_EMPRUNTEUR'
        when LB_STATUT_EMPRUNTEUR is null then 'missing LB_STATUT_EMPRUNTEUR'
        when rn > 1 then 'deduplicate key'
    end as rejected_reason

from {{ ref('_stg_statut_emprunteur_deduplicated') }}
where rn > 1
    or CD_STATUT_EMPRUNTEUR is null
    or LB_STATUT_EMPRUNTEUR is null