-- Alternative 1
-- Mit DISTINCT
SELECT DISTINCT shelf_name, shelf_number
FROM shelfs s
  INNER JOIN storage r ON s.shelf_id = r.shelf_id
  INNER JOIN metals m ON m.metal_id = r.metal_id
WHERE m.metal_name = 'Edelstahl'
AND m.metal_property = '1.4301'
AND m.metal_type = 'Geschliffen';

-- Alternative 2
-- Mit GROUP BY
SELECT shelf_name, shelf_number
FROM shelfs s
  INNER JOIN storage r ON s.shelf_id = r.shelf_id
  INNER JOIN metals m ON m.metal_id = r.metal_id
WHERE m.metal_name = 'Edelstahl'
AND m.metal_property = '1.4301'
AND m.metal_type = 'Geschliffen'
GROUP BY shelf_name, shelf_number;

-- Alternative 3
-- Als Sub-Query
SELECT shelf_name, shelf_number
FROM shelfs s
WHERE s.shelf_id IN (
  SELECT shelf_id
  FROM storage
  WHERE metal_id IN (
    SELECT metal_id
    FROM metals
    WHERE metal_name = 'Edelstahl'
    AND metal_property = '1.4301'
    AND metal_type = 'Geschliffen'
  )
);
