SELECT
  TO_CHAR(st.creation_date, 'YYYY/MM') AS "DATE",
  (
    SELECT SUM((st2.surface_area / 1000000) * st2.metal_thickness * m2.price)
    FROM storage st2
      INNER JOIN metals m2 ON (m2.metal_id = st2.metal_id)
    WHERE TO_CHAR(st.creation_date, 'YYYY/MM') = TO_CHAR(st2.creation_date, 'YYYY/MM')
  ) AS "ASSET"
FROM "STORAGE" st
GROUP BY
  TO_CHAR(st.creation_date, 'YYYY/MM')
ORDER BY
  TO_CHAR(st.creation_date, 'YYYY/MM') ASC;

-- Test
UPDATE storage
SET creation_date = SYSDATE - INTERVAL '2' MONTH
WHERE storage_id = '94c3e3be-32ae-42b8-b6ad-4b0040a8f7fa';
