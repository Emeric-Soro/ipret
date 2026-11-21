select
    p.ID_PRET,
    p.DT_PRET,
    p.ID_EMPRUNTEUR,
    p.CD_TYPE_PRET,
    p.CD_STATUT_PRET,
    p.CD_PERIODICITE_REMBOURSEMENT,
    convert_timezone('Europe/Paris', current_timestamp()) as rejected_at,
    case
        when ca.ID_DIM_CALENDAR is null then 'unmatched calendar date'
        when e.ID_DIM_EMPRUNTEUR is null then 'unmatched emprunteur'
        when tp.ID_DIM_TYPE_PRET is null then 'unmatched type pret'
        when sp.ID_DIM_STATUT_PRET is null then 'unmatched statut pret'
        when pe.ID_DIM_PERIODICITE_REMBOURSEMENT is null then 'unmatched periodicite remboursement'
    end as rejected_reason
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
where ca.ID_DIM_CALENDAR is null
    or e.ID_DIM_EMPRUNTEUR is null
    or tp.ID_DIM_TYPE_PRET is null
    or sp.ID_DIM_STATUT_PRET is null
    or pe.ID_DIM_PERIODICITE_REMBOURSEMENT is null