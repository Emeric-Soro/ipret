with cleaned_statut_emprunteur as (
    select
        {{ null_if_placeholder("upper(CD_STATUT_EMPRUNTEUR)") }} as CD_STATUT_EMPRUNTEUR,
        {{ null_if_placeholder("regexp_replace(LB_STATUT_EMPRUNTEUR, '\\\\s+', ' ')") }} as LB_STATUT_EMPRUNTEUR
    from {{ source('bronze', 'TB_STATUT_EMPRUNTEUR') }}
)

select
    *,
    row_number() over (
        partition by CD_STATUT_EMPRUNTEUR
        order by LB_STATUT_EMPRUNTEUR
    ) as rn
from cleaned_statut_emprunteur