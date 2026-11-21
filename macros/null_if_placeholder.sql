{% macro null_if_placeholder(expr) %}
    case
        when trim({{ expr }}) = ''
          or regexp_like(trim({{ expr }}), 'null|n/a|-', 'i')
        then null
        else trim({{ expr }})
    end
{% endmacro %}