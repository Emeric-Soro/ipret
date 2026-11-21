{{ config(
    materialized = 'incremental',
    unique_key = ['rejection_id']
) }}

select
    {{ dbt_utils.generate_surrogate_key(['CD_MODE_REMBOURSEMENT', 'LB_MODE_REMBOURSEMENT', 'rn']) }} as rejection_id,
    CD_MODE_REMBOURSEMENT,
    LB_MODE_REMBOURSEMENT,
    convert_timezone('Europe/Paris', current_timestamp()) as rejected_at,
    case
        when CD_MODE_REMBOURSEMENT is null then 'missing CD_MODE_REMBOURSEMENT'
        when LB_MODE_REMBOURSEMENT is null then 'missing LB_MODE_REMBOURSEMENT'
        when rn > 1 then 'deduplicate key'
    end as rejected_reason

from {{ ref('_stg_mode_remboursement_deduplicated') }}
where rn > 1
    or CD_MODE_REMBOURSEMENT is null
    or LB_MODE_REMBOURSEMENT is null