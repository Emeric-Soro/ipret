{{ config(alias='fact_pret') }}

select
    ID_PRET,
    ID_DIM_CALENDAR,
    ID_DIM_EMPRUNTEUR,
    ID_DIM_TYPE_PRET,
    ID_DIM_STATUT_PRET,
    ID_DIM_PERIODICITE_REMBOURSEMENT,
    MT_PRET,
    NB_DUREE_REMBOURSEMENT,
    TX_INTERET_PRET,
    PRET_COUNT
from {{ ref('fact_pret') }}