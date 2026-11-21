select
    r.ID_REMBOURSEMENT,
    r.ID_PRET,
    ca.ID_DIM_CALENDAR,
    mr.ID_DIM_MODE_REMBOURSEMENT,
    r.MT_REMBOURSE,
    r.MT_CAPITAL_PAYE,
    r.MT_INTERET_PAYE,
    1 as REMBOURSEMENT_COUNT
from {{ ref('stg_remboursement') }} r
    left outer join {{ ref('dim_calendar') }} ca
        on r.DT_REMBOURSEMENT = ca.DT_CALENDAR
    left outer join {{ ref('dim_mode_remboursement') }} mr
        on r.CD_MODE_REMBOURSEMENT = mr.CD_MODE_REMBOURSEMENT
    left outer join {{ ref('fact_pret') }} p
        on r.ID_PRET = p.ID_PRET
where ca.ID_DIM_CALENDAR is not null
    and mr.ID_DIM_MODE_REMBOURSEMENT is not null
    and p.ID_PRET is not null