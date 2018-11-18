-- Aufgabe 14
SELECT DISTINCT metal_name
FROM metals
WHERE metal_property = '1.4301'
OR metal_type = 'Geschliffen';

-- Abänderung der Aufgabe
-- Gebe alle Metalle aus, die die Eigenschaft Geschliffen
-- oder Träne besitzten als auch vom Typ 1.4301 sind.
SELECT DISTINCT m.metal_name
FROM metals m
WHERE m.metal_type IN ('Träne', 'Geschliffen')
AND m.metal_property = '1.4301';

SELECT DISTINCT m.metal_name
FROM metals m
WHERE (m.metal_type = 'Träne'
OR m.metal_type = 'Geschliffen')
AND m.metal_property = '1.4301';