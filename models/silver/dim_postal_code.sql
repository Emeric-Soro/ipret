with postal_department as (
    select
        code_postal,
        code_department,
        count(*) as nb_communes
    from {{ ref('stg_file_zone_geographique') }}
    group by code_postal, code_department
),

deduplicated_postal as (
    select
        code_postal,
        code_department,
        row_number() over (
            partition by code_postal
            order by nb_communes desc, code_department
        ) as rn
    from postal_department
)

select
    row_number() over (order by p.code_postal) as id_dim_postal_code,
    p.code_postal as cd_postal,
    d.id_dim_department
from deduplicated_postal p
    inner join {{ ref('dim_department') }} d
        on p.code_department = d.cd_department
where p.rn = 1

union all

select -1 as id_dim_postal_code, 'INCONNU' as cd_postal, null as id_dim_department