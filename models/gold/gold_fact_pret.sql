{{ config(alias='fact_pret') }}

with remboursement_par_pret as (
    select
        ID_PRET,
        sum(MT_CAPITAL_PAYE) as MT_CAPITAL_REMBOURSE
    from {{ ref('fact_remboursement') }}
    group by ID_PRET
)

select
    p.ID_PRET,
    p.ID_DIM_CALENDAR,
    p.ID_DIM_EMPRUNTEUR,
    p.ID_DIM_TYPE_PRET,
    p.ID_DIM_STATUT_PRET,
    p.ID_DIM_PERIODICITE_REMBOURSEMENT,
    p.MT_PRET,
    p.NB_DUREE_REMBOURSEMENT,
    p.TX_INTERET_PRET,
    p.PRET_COUNT,
    coalesce(r.MT_CAPITAL_REMBOURSE, 0) as MT_CAPITAL_REMBOURSE,
    p.MT_PRET - coalesce(r.MT_CAPITAL_REMBOURSE, 0) as MT_RESTANT_A_REMBOURSER,
    case when r.ID_PRET is null then 1 else 0 end as PRET_ETAT_INITIAL_COUNT
from {{ ref('fact_pret') }} p
    left outer join remboursement_par_pret r
        on p.ID_PRET = r.ID_PRET