{{ config(
    materialized = 'incremental',
    unique_key = ['rejection_id']
) }}

select
    {{ dbt_utils.generate_surrogate_key(['ID_REMBOURSEMENT', 'ID_PRET', 'rn']) }} as rejection_id,
    ID_REMBOURSEMENT,
    DT_REMBOURSEMENT,
    MT_REMBOURSE,
    MT_CAPITAL_PAYE,
    MT_INTERET_PAYE,
    CD_MODE_REMBOURSEMENT,
    ID_PRET,
    convert_timezone('Europe/Paris', current_timestamp()) as rejected_at,
    case
        when ID_REMBOURSEMENT is null then 'missing ID_REMBOURSEMENT'
        when DT_REMBOURSEMENT is null then 'missing or invalid DT_REMBOURSEMENT'
        when MT_REMBOURSE is null then 'missing or invalid MT_REMBOURSE'
        when MT_CAPITAL_PAYE is null then 'missing or invalid MT_CAPITAL_PAYE'
        when MT_INTERET_PAYE is null then 'missing or invalid MT_INTERET_PAYE'
        when CD_MODE_REMBOURSEMENT is null then 'missing CD_MODE_REMBOURSEMENT'
        when ID_PRET is null then 'missing ID_PRET'
        when rn > 1 then 'deduplicate key'
    end as rejected_reason

from {{ ref('_stg_remboursement_deduplicated') }}
where rn > 1
    or ID_REMBOURSEMENT is null
    or DT_REMBOURSEMENT is null
    or MT_REMBOURSE is null
    or MT_CAPITAL_PAYE is null
    or MT_INTERET_PAYE is null
    or CD_MODE_REMBOURSEMENT is null
    or ID_PRET is null