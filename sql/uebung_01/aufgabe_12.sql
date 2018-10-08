SELECT CONCAT(sh.shelf_name, sh.shelf_number) AS "SHELF"
FROM shelfs sh
  INNER JOIN storage st ON (st.shelf_id = sh.shelf_id)
  INNER JOIN metals m ON (m.metal_id = st.metal_id)
WHERE m.metal_name = 'Edelstahl'
AND m.metal_property = '1.4301'
AND m.metal_type = 'Geschliffen'
GROUP BY sh.shelf_name, sh.shelf_number;