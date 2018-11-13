-- Baut auf View aus Aufgabe 5 auf.
SELECT
  js.employee_firstname,
  js.employee_lastname,
  js.asset
FROM joined_storage js
WHERE js.asset = (
  SELECT MAX(asset)
  FROM joined_storage
);