SELECT
  c.contact_firstname,
  c.contact_lastname,
  su.supplier_name,
  SUM(st.surface_area / 1000000 * st.metal_thickness * m.metal_price) AS "ASSET"
FROM "STORAGE" st
  INNER JOIN metals m ON (m.metal_ID = st.metal_ID)
  INNER JOIN contacts c ON (c.contact_id = st.contact_id)
  INNER JOIN suppliers su ON (su.supplier_id = c.supplier_id)
GROUP BY
  c.contact_firstname,
  c.contact_lastname,
  su.supplier_name
HAVING SUM(st.surface_area / 1000000 * st.metal_thickness * m.metal_price) = (
  SELECT
    MIN(SUM(st.surface_area / 1000000 * st.metal_thickness * m.metal_price))
  FROM "STORAGE" st
    INNER JOIN metals m ON (m.metal_ID = st.metal_ID)
    INNER JOIN contacts c ON (c.contact_id = st.contact_id)
    INNER JOIN suppliers su ON (su.supplier_id = c.supplier_id)
  GROUP BY
    c.contact_firstname,
    c.contact_lastname,
    su.supplier_name
);