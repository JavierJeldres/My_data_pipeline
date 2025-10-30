-- Este modelo calcula métricas promedio por especie.
-- Usa ref() para referirse al modelo anterior.
-- dbt se encarga de crearlo como una VISTA (por defecto)

-- Le decimos a dbt que esto sea una TABLA
{{
  config(
    materialized='table'  
  )
}}

SELECT
  species_name,
  COUNT(1) AS total_samples,
  AVG(sepal_length_cm) AS avg_sepal_length,
  AVG(sepal_width_cm) AS avg_sepal_width,
  AVG(petal_length_cm) AS avg_petal_length,
  AVG(petal_width_cm) AS avg_petal_width
FROM
  {{ ref('stg_iris') }}
GROUP BY
  species_name
