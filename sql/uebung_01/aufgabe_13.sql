SELECT sh.shelf_name, sh.shelf_number
FROM shelfs sh, storage st, metals m
WHERE sh.shelf_id = st.shelf_id
AND st.metal_id = m.metal_id
AND m.metal_name = 'Edelstahl'
AND m.metal_property = '1.4301'
AND m.metal_type = 'Geschliffen'
GROUP BY sh.shelf_name, sh.shelf_number;