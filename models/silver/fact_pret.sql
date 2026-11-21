select
    p.ID_PRET,
    ca.ID_DIM_CALENDAR,
    e.ID_DIM_EMPRUNTEUR,
    tp.ID_DIM_TYPE_PRET,
    sp.ID_DIM_STATUT_PRET,
    pe.ID_DIM_PERIODICITE_REMBOURSEMENT,
    p.MT_PRET,
    p.NB_DUREE_REMBOURSEMENT,
    p.TX_INTERET_PRET,
    1 as PRET_COUNT
from {{ ref('stg_pret') }} p
    left outer join {{ ref('dim_calendar') }} ca
        on p.DT_PRET = ca.DT_CALENDAR
    left outer join {{ ref('dim_emprunteur') }} e
        on p.ID_EMPRUNTEUR = e.ID_EMPRUNTEUR
    left outer join {{ ref('dim_type_pret') }} tp
        on p.CD_TYPE_PRET = tp.CD_TYPE_PRET
    left outer join {{ ref('dim_statut_pret') }} sp
        on p.CD_STATUT_PRET = sp.CD_STATUT_PRET
    left outer join {{ ref('dim_periodicite_remboursement') }} pe
        on p.CD_PERIODICITE_REMBOURSEMENT = pe.CD_PERIODICITE_REMBOURSEMENT
where ca.ID_DIM_CALENDAR is not null
    and e.ID_DIM_EMPRUNTEUR is not null
    and tp.ID_DIM_TYPE_PRET is not null
    and sp.ID_DIM_STATUT_PRET is not null
    and pe.ID_DIM_PERIODICITE_REMBOURSEMENT is not null