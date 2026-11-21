select
    r.ID_REMBOURSEMENT,
    r.ID_PRET,
    r.DT_REMBOURSEMENT,
    r.CD_MODE_REMBOURSEMENT,
    convert_timezone('Europe/Paris', current_timestamp()) as rejected_at,
    case
        when ca.ID_DIM_CALENDAR is null then 'unmatched calendar date'
        when mr.ID_DIM_MODE_REMBOURSEMENT is null then 'unmatched mode remboursement'
        when p.ID_PRET is null then 'unmatched pret'
    end as rejected_reason
from {{ ref('stg_remboursement') }} r
    left outer join {{ ref('dim_calendar') }} ca
        on r.DT_REMBOURSEMENT = ca.DT_CALENDAR
    left outer join {{ ref('dim_mode_remboursement') }} mr
        on r.CD_MODE_REMBOURSEMENT = mr.CD_MODE_REMBOURSEMENT
    left outer join {{ ref('fact_pret') }} p
        on r.ID_PRET = p.ID_PRET
where ca.ID_DIM_CALENDAR is null
    or mr.ID_DIM_MODE_REMBOURSEMENT is null
    or p.ID_PRET is null