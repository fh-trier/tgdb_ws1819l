-- View
CREATE OR REPLACE VIEW "JOINED_STORAGE" AS
  SELECT
    COUNT(st.storage_id) AS "COUNT",
    m.metal_name,
    m.metal_property,
    m.metal_type,
    st.x_length,
    st.y_length,
    st.metal_thickness,
    st.surface_area,
    sh.shelf_name,
    sh.shelf_number,
    su.supplier_name,
    e.employee_firstname,
    e.employee_lastname,
    SUM(st.surface_area / 1000000 * st.metal_thickness * m.price) AS "ASSET"
  FROM "STORAGE" ST
    INNER JOIN metals m ON (m.metal_ID = st.metal_ID)
    INNER JOIN shelfs sh ON (sh.shelf_ID = st.shelf_ID)
    INNER JOIN contacts c ON (c.contact_id = st.contact_id)
    INNER JOIN employees e ON (e.employee_id = st.employee_id)
    INNER JOIN suppliers su ON (su.supplier_id = c.supplier_id)
  GROUP BY
    m.metal_name,
    m.metal_property,
    m.metal_type,
    st.x_length,
    st.y_length,
    st.metal_thickness,
    st.surface_area,
    sh.shelf_name,
    sh.shelf_number,
    su.supplier_name,
    e.employee_firstname,
    e.employee_lastname;

-- Ausgabe
SELECT *
FROM joined_storage;