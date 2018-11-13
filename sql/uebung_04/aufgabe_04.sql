SELECT SUM((st.surface_area / 1000000) * st.metal_thickness * m.price) AS "ASSET"
FROM storage st
  INNER JOIN metals m ON (m.metal_id = st.metal_id);