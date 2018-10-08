SELECT DISTINCT m.metal_name
FROM metals m
WHERE m.metal_type IN ('Träne', 'Geschliffen')
AND m.metal_propery = '1.4301';

SELECT DISTINCT m.metal_name
FROM metals m
WHERE (m.metal_type = 'Träne'
OR m.metal_type = 'Geschliffen')
AND m.metal_propery = '1.4301';