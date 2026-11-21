{{ config(
    materialized = 'incremental',
    unique_key = ['rejection_id']
) }}

select
    {{ dbt_utils.generate_surrogate_key(['ID_PRET', 'ID_EMPRUNTEUR', 'rn']) }} as rejection_id,
    ID_PRET,
    DT_PRET,
    MT_PRET,
    NB_DUREE_REMBOURSEMENT,
    TX_INTERET_PRET,
    CD_TYPE_PRET,
    ID_EMPRUNTEUR,
    CD_STATUT_PRET,
    CD_PERIODICITE_REMBOURSEMENT,
    convert_timezone('Europe/Paris', current_timestamp()) as rejected_at,
    case
        when ID_PRET is null then 'missing ID_PRET'
        when DT_PRET is null then 'missing or invalid DT_PRET'
        when MT_PRET is null then 'missing or invalid MT_PRET'
        when NB_DUREE_REMBOURSEMENT is null then 'missing or invalid NB_DUREE_REMBOURSEMENT'
        when TX_INTERET_PRET is null then 'missing or invalid TX_INTERET_PRET'
        when CD_TYPE_PRET is null then 'missing CD_TYPE_PRET'
        when ID_EMPRUNTEUR is null then 'missing ID_EMPRUNTEUR'
        when CD_STATUT_PRET is null then 'missing CD_STATUT_PRET'
        when CD_PERIODICITE_REMBOURSEMENT is null then 'missing CD_PERIODICITE_REMBOURSEMENT'
        when rn > 1 then 'deduplicate key'
    end as rejected_reason

from {{ ref('_stg_pret_deduplicated') }}
where rn > 1
    or ID_PRET is null
    or DT_PRET is null
    or MT_PRET is null
    or NB_DUREE_REMBOURSEMENT is null
    or TX_INTERET_PRET is null
    or CD_TYPE_PRET is null
    or ID_EMPRUNTEUR is null
    or CD_STATUT_PRET is null
    or CD_PERIODICITE_REMBOURSEMENT is null