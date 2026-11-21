select
    case when length(trim(code_commune_postal)) < 5
        then lpad(trim(code_commune_postal), 5, '0')
        else trim(code_commune_postal) end as code_commune_postal,
    trim(nom_commune_postal) as postal_commune_name,
    lpad(trim(code_postal), 5, '0') as code_postal,
    trim(nom_commune_complet) as commune_name,
    case when length(trim(code_departement)) < 2
        then lpad(trim(code_departement), 2, '0')
        else trim(code_departement) end as code_department,
    trim(nom_departement) as department_name,
    case when length(trim(code_region)) < 2
        then lpad(trim(code_region), 2, '0')
        else trim(code_region) end as code_region,
    trim(nom_region) as region_name
from {{ ref('file_zone_geographique') }}