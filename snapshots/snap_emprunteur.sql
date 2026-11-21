{% snapshot snap_emprunteur %}

{{
    config(
        target_schema='silver',
        unique_key='ID_EMPRUNTEUR',
        strategy='check',
        check_cols=[
            'LB_CIVILITE_EMPRUNTEUR', 
            'LB_NOM_EMPRUNTEUR', 
            'LB_PRENOM_EMPRUNTEUR', 
            'LB_EMAIL_EMPRUNTEUR', 
            'CD_POSTAL_EMPRUNTEUR', 
            'CD_TYPE_EMPRUNTEUR', 
            'CD_STATUT_EMPRUNTEUR'
        ]
    )
}}

select 
    ID_EMPRUNTEUR,
    LB_CIVILITE_EMPRUNTEUR,
    LB_NOM_EMPRUNTEUR,
    LB_PRENOM_EMPRUNTEUR,
    DT_NAISSANCE_EMPRUNTEUR,
    LB_EMAIL_EMPRUNTEUR,
    CD_POSTAL_EMPRUNTEUR,
    CD_TYPE_EMPRUNTEUR,
    CD_STATUT_EMPRUNTEUR
from {{ ref('stg_emprunteur') }}

{% endsnapshot %}