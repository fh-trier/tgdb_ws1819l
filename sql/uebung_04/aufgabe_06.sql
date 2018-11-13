-- Baut auf View aus Aufgabe 5 auf.
SELECT
  js.*,
  (SELECT AVG(asset) FROM joined_storage) AS "AVG"
FROM joined_storage js
WHERE js.asset > (
  SELECT AVG(asset)
  FROM joined_storage
);