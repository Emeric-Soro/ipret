with cleaned_remboursement as (
    select
        {{ null_if_placeholder("ID_REMBOURSEMENT") }} as ID_REMBOURSEMENT,
        {{ null_if_placeholder("DT_REMBOURSEMENT") }} as DT_REMBOURSEMENT,
        {{ null_if_placeholder("MT_REMBOURSE") }} as MT_REMBOURSE,
        {{ null_if_placeholder("MT_CAPITAL_PAYE") }} as MT_CAPITAL_PAYE,
        {{ null_if_placeholder("MT_INTERET_PAYE") }} as MT_INTERET_PAYE,
        {{ null_if_placeholder("upper(CD_MODE_REMBOURSEMENT)") }} as CD_MODE_REMBOURSEMENT,
        {{ null_if_placeholder("ID_PRET") }} as ID_PRET
    from {{ source('bronze', 'TB_REMBOURSEMENT') }}
),

typed_remboursement as (
    select
        ID_REMBOURSEMENT,
        {{ to_date_multi("DT_REMBOURSEMENT") }} as DT_REMBOURSEMENT,
        try_to_decimal(replace(regexp_replace(MT_REMBOURSE, '[^0-9,.]', ''), ',', '.'), 12, 2) as MT_REMBOURSE,
        try_to_decimal(replace(regexp_replace(MT_CAPITAL_PAYE, '[^0-9,.]', ''), ',', '.'), 12, 2) as MT_CAPITAL_PAYE,
        try_to_decimal(replace(regexp_replace(MT_INTERET_PAYE, '[^0-9,.]', ''), ',', '.'), 12, 2) as MT_INTERET_PAYE,
        CD_MODE_REMBOURSEMENT,
        ID_PRET
    from cleaned_remboursement
)

select
    *,
    row_number() over (
        partition by ID_REMBOURSEMENT
        order by ID_PRET
    ) as rn
from typed_remboursement