with cleaned_mode_remboursement as (
    select
        {{ null_if_placeholder("upper(CD_MODE_REMBOURSEMENT)") }} as CD_MODE_REMBOURSEMENT,
        {{ null_if_placeholder("regexp_replace(LB_MODE_REMBOURSEMENT, '\\\\s+', ' ')") }} as LB_MODE_REMBOURSEMENT
    from {{ source('bronze', 'TB_MODE_REMBOURSEMENT') }}
)

select
    *,
    row_number() over (
        partition by CD_MODE_REMBOURSEMENT
        order by LB_MODE_REMBOURSEMENT
    ) as rn
from cleaned_mode_remboursement