{% macro to_date_multi(expr) %}
    case
        when regexp_like({{ expr }}, '\\d{2}/\\d{2}/\\d{4}') then try_to_date({{ expr }}, 'DD/MM/YYYY')
        when regexp_like({{ expr }}, '\\d{4}-\\d{2}-\\d{2}') then try_to_date({{ expr }}, 'YYYY-MM-DD')
        when regexp_like({{ expr }}, '\\d{2}-\\d{2}-\\d{4}') then try_to_date({{ expr }}, 'DD-MM-YYYY')
        when regexp_like({{ expr }}, '\\d{2}\\.\\d{2}\\.\\d{4}') then try_to_date({{ expr }}, 'DD.MM.YYYY')
        when regexp_like({{ expr }}, '\\d{2}/\\d{2}/\\d{2}') then try_to_date({{ expr }}, 'DD/MM/YY')
    end
{% endmacro %}