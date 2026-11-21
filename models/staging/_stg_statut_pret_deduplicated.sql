with cleaned_statut_pret as (
    select
        {{ null_if_placeholder("upper(CD_STATUT_PRET)") }} as CD_STATUT_PRET,
        {{ null_if_placeholder("regexp_replace(LB_STATUT_PRET, '\\\\s+', ' ')") }} as LB_STATUT_PRET
    from {{ source('bronze', 'TB_STATUT_PRET') }}
)

select
    *,
    row_number() over (
        partition by CD_STATUT_PRET
        order by LB_STATUT_PRET
    ) as rn
from cleaned_statut_pret