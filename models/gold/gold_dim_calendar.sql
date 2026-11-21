{{ config(alias='dim_calendar') }}

with select_min_max_date as (
    select
        min(ID_DIM_CALENDAR) as min_dt,
        max(ID_DIM_CALENDAR) as max_dt
    from (
        select ID_DIM_CALENDAR from {{ ref('fact_pret') }}
        union all
        select ID_DIM_CALENDAR from {{ ref('fact_remboursement') }}
    )
)

select
    c.ID_DIM_CALENDAR,
    c.DT_CALENDAR,
    c.NB_JOUR,
    c.LB_JOUR,
    c.NB_MOIS,
    c.LB_MOIS,
    c.LB_MOIS_COURT,
    c.NB_TRIMESTRE,
    c.LB_TRIMESTRE,
    c.NB_SEMESTRE,
    c.LB_SEMESTRE,
    c.NB_ANNEE
from {{ ref('dim_calendar') }} c
    inner join select_min_max_date mmd
        on c.ID_DIM_CALENDAR between mmd.min_dt and mmd.max_dt