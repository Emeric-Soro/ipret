{{ config(
    materialized = 'incremental',
    unique_key = ['rejection_id']
) }}

select
    {{ dbt_utils.generate_surrogate_key(['CD_TYPE_EMPRUNTEUR', 'LB_TYPE_EMPRUNTEUR', 'rn']) }} as rejection_id,
    CD_TYPE_EMPRUNTEUR,
    LB_TYPE_EMPRUNTEUR,
    convert_timezone('Europe/Paris', current_timestamp()) as rejected_at,
    case
        when CD_TYPE_EMPRUNTEUR is null then 'missing CD_TYPE_EMPRUNTEUR'
        when LB_TYPE_EMPRUNTEUR is null then 'missing LB_TYPE_EMPRUNTEUR'
        when rn > 1 then 'deduplicate key'
    end as rejected_reason

from {{ ref('_stg_type_emprunteur_deduplicated') }}
where rn > 1
    or CD_TYPE_EMPRUNTEUR is null
    or LB_TYPE_EMPRUNTEUR is null