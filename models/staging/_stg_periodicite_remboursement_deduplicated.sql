with cleaned_periodicite_remboursement as (
    select
        {{ null_if_placeholder("upper(CD_PERIODICITE_REMBOURSEMENT)") }} as CD_PERIODICITE_REMBOURSEMENT,
        {{ null_if_placeholder("regexp_replace(LB_PERIODICITE_REMBOURSEMENT, '\\\\s+', ' ')") }} as LB_PERIODICITE_REMBOURSEMENT
    from {{ source('bronze', 'TB_PERIODICITE_REMBOURSEMENT') }}
)

select
    *,
    row_number() over (
        partition by CD_PERIODICITE_REMBOURSEMENT
        order by LB_PERIODICITE_REMBOURSEMENT
    ) as rn
from cleaned_periodicite_remboursement