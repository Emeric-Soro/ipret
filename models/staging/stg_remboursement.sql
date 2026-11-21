select
    ID_REMBOURSEMENT,
    DT_REMBOURSEMENT,
    MT_REMBOURSE,
    MT_CAPITAL_PAYE,
    MT_INTERET_PAYE,
    CD_MODE_REMBOURSEMENT,
    ID_PRET
from {{ ref('_stg_remboursement_deduplicated') }}
where rn = 1
    and ID_REMBOURSEMENT is not null
    and DT_REMBOURSEMENT is not null
    and MT_REMBOURSE is not null
    and MT_CAPITAL_PAYE is not null
    and MT_INTERET_PAYE is not null
    and CD_MODE_REMBOURSEMENT is not null
    and ID_PRET is not null