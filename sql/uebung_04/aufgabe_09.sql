SELECT
  TO_CHAR(st.creation_date, 'YYYY/MM') AS "DATE",
  (
    SELECT SUM((st2.surface_area / 1000000) * st2.metal_thickness * m2.metal_price)
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
WHERE ROWNUM < 20;

UPDATE storage
SET creation_date = SYSDATE - INTERVAL '1' MONTH
WHERE ROWNUM < 10;
