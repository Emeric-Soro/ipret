{{ config(alias='fact_remboursement') }}

select
    r.ID_REMBOURSEMENT,
    r.ID_PRET,
    r.ID_DIM_CALENDAR,
    r.ID_DIM_MODE_REMBOURSEMENT,
    p.ID_DIM_EMPRUNTEUR,
    p.ID_DIM_TYPE_PRET,
    p.ID_DIM_PERIODICITE_REMBOURSEMENT,
    r.MT_REMBOURSE,
    r.MT_CAPITAL_PAYE,
    r.MT_INTERET_PAYE,
    r.REMBOURSEMENT_COUNT
from {{ ref('fact_remboursement') }} r
    inner join {{ ref('fact_pret') }} p
        on r.ID_PRET = p.ID_PRET