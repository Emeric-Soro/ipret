{{ config(
    materialized = 'incremental',
    unique_key = ['rejection_id']
) }}

select
    {{ dbt_utils.generate_surrogate_key(['CD_TYPE_PRET', 'LB_TYPE_PRET', 'rn']) }} as rejection_id,
    CD_TYPE_PRET,
    LB_TYPE_PRET,
    convert_timezone('Europe/Paris', current_timestamp()) as rejected_at,
    case
        when CD_TYPE_PRET is null then 'missing CD_TYPE_PRET'
        when LB_TYPE_PRET is null then 'missing LB_TYPE_PRET'
        when rn > 1 then 'deduplicate key'
    end as rejected_reason

from {{ ref('_stg_type_pret_deduplicated') }}
where rn > 1
    or CD_TYPE_PRET is null
    or LB_TYPE_PRET is null