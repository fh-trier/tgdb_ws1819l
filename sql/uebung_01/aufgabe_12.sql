-- Alternative 1
-- Mit DISTINCT
SELECT DISTINCT CONCAT(shelf_name, shelf_number) AS SHELF
FROM shelfs s
	INNER JOIN storage r ON s.shelf_id = r.shelf_id
	INNER JOIN metals m ON m.metal_id = r.metal_id
WHERE m.metal_name = 'Edelstahl'
AND m.metal_property = '1.4301'
AND m.metal_type = 'Geschliffen';

-- Alternative 2
-- Mit GROUP BY
SELECT CONCAT(sh.shelf_name, sh.shelf_number) AS "SHELF"
FROM shelfs sh
  INNER JOIN storage st ON (st.shelf_id = sh.shelf_id)
  INNER JOIN metals m ON (m.metal_id = st.metal_id)
WHERE m.metal_name = 'Edelstahl'
AND m.metal_property = '1.4301'
AND m.metal_type = 'Geschliffen'
GROUP BY sh.shelf_name, sh.shelf_number;