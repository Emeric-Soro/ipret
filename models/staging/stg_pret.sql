select
    ID_PRET,
    DT_PRET,
    MT_PRET,
    NB_DUREE_REMBOURSEMENT,
    TX_INTERET_PRET,
    CD_TYPE_PRET,
    ID_EMPRUNTEUR,
    CD_STATUT_PRET,
    CD_PERIODICITE_REMBOURSEMENT
from {{ ref('_stg_pret_deduplicated') }}
where rn = 1
    and ID_PRET is not null
    and DT_PRET is not null
    and MT_PRET is not null
    and NB_DUREE_REMBOURSEMENT is not null
    and TX_INTERET_PRET is not null
    and CD_TYPE_PRET is not null
    and ID_EMPRUNTEUR is not null
    and CD_STATUT_PRET is not null
    and CD_PERIODICITE_REMBOURSEMENT is not null