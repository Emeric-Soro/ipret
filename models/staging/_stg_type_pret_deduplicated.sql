with cleaned_type_pret as (
    select
        {{ null_if_placeholder("upper(CD_TYPE_PRET)") }} as CD_TYPE_PRET,
        {{ null_if_placeholder("regexp_replace(LB_TYPE_PRET, '\\\\s+', ' ')") }} as LB_TYPE_PRET
    from {{ source('bronze', 'TB_TYPE_PRET') }}
)

select
    *,
    row_number() over (
        partition by CD_TYPE_PRET
        order by LB_TYPE_PRET
    ) as rn
from cleaned_type_pret