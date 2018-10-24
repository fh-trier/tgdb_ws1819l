COLUMN SATZ FORMAT a32

SELECT
  e.employee_firstname || ' ist ' ||
  TRUNC(MONTHS_BETWEEN(SYSDATE, employee_birthday)/12) || ' Jahre alt' AS "SATZ"
FROM employees e;