with cleaned_pret as (
    select
        {{ null_if_placeholder("ID_PRET") }} as ID_PRET,
        {{ null_if_placeholder("DT_PRET") }} as DT_PRET,
        {{ null_if_placeholder("MT_PRET") }} as MT_PRET,
        {{ null_if_placeholder("NB_DUREE_REMBOURSEMENT") }} as NB_DUREE_REMBOURSEMENT,
        {{ null_if_placeholder("TX_INTERET_PRET") }} as TX_INTERET_PRET,
        {{ null_if_placeholder("upper(CD_TYPE_PRET)") }} as CD_TYPE_PRET,
        {{ null_if_placeholder("ID_EMPRUNTEUR") }} as ID_EMPRUNTEUR,
        {{ null_if_placeholder("upper(CD_STATUT_PRET)") }} as CD_STATUT_PRET,
        {{ null_if_placeholder("upper(CD_PERIODICITE_REMBOURSEMENT)") }} as CD_PERIODICITE_REMBOURSEMENT
    from {{ source('bronze', 'TB_PRET') }}
),

typed_pret as (
    select
        ID_PRET,
        {{ to_date_multi("DT_PRET") }} as DT_PRET,
        try_to_decimal(replace(regexp_replace(MT_PRET, '[^0-9,.]', ''), ',', '.'), 12, 2) as MT_PRET,
        try_to_number(NB_DUREE_REMBOURSEMENT) as NB_DUREE_REMBOURSEMENT,
        try_to_decimal(replace(regexp_replace(TX_INTERET_PRET, '[^0-9,.]', ''), ',', '.'), 6, 2) as TX_INTERET_PRET,
        CD_TYPE_PRET,
        ID_EMPRUNTEUR,
        CD_STATUT_PRET,
        CD_PERIODICITE_REMBOURSEMENT
    from cleaned_pret
)

select
    *,
    row_number() over (
        partition by ID_PRET
        order by ID_EMPRUNTEUR
    ) as rn
from typed_pret