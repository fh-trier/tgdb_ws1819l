-- Ohne Exist
SELECT a1.klausurnr
FROM anmeldung a1
WHERE (
  (
    SELECT COUNT (*) AS "A_G"
    FROM anmeldung a2
    WHERE a2.klausurnr = a1.klausurnr
  ) -
  (
    SELECT COUNT (*) AS "A_B"
    FROM anmeldung a3
    WHERE a3.klausurnr = a1.klausurnr
    AND a3.note IS NOT NULL)
  ) =
  (
    SELECT COUNT (*) AS "A_G"
    FROM anmeldung a4O
    WHERE a4.klausurnr = a1.klausurnr
  )
ORDER BY a1.klausurnr ASC;

-- Mit Exists
SELECT klausurnr
FROM anmeldung a
WHERE NOT EXISTS (
  SELECT *
  FROM anmeldung
  WHERE a.klausurnr = klausurnr
  AND note IS NOT NULL
);