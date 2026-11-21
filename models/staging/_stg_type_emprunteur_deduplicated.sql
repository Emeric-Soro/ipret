with cleaned_type_emprunteur as (
    select
        {{ null_if_placeholder("upper(CD_TYPE_EMPRUNTEUR)") }} as CD_TYPE_EMPRUNTEUR,
        {{ null_if_placeholder("regexp_replace(LB_TYPE_EMPRUNTEUR, '\\\\s+', ' ')") }} as LB_TYPE_EMPRUNTEUR
    from {{ source('bronze', 'TB_TYPE_EMPRUNTEUR') }}
)

select
    *,
    row_number() over (
        partition by CD_TYPE_EMPRUNTEUR
        order by LB_TYPE_EMPRUNTEUR
    ) as rn
from cleaned_type_emprunteur