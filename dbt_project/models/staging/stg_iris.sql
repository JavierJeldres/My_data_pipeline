-- Este modelo limpia y renombra las columnas de la tabla cruda.
-- Usamos source() para referirnos a la tabla declarada en schema.yml

SELECT
  -- dbt usa los nombres de columna que BQ autodetectó (ej. _f0, _f1)
  double_field_0 AS sepal_length_cm,
  double_field_1 AS sepal_width_cm,
  double_field_2 AS petal_length_cm,
  double_field_3 AS petal_width_cm,
  CASE
    WHEN int64_field_4 = 0 THEN 'iris_setosa'
    WHEN int64_field_4 = 1 THEN 'iris_versicolor'
    WHEN int64_field_4 = 2 THEN 'iris_virginica'
  END AS species_name
FROM
  {{ source('raw_data', 'iris') }}
  WHERE
  int64_field_4 IN (0, 1, 2)