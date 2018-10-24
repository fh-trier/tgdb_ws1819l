COLUMN EMPLOYEE FORMAT a32
COLUMN ALTER FORMAT a32

SELECT
  employee_firstname || ' ' || employee_lastname AS "EMPLOYEE",
  TRUNC(MONTHS_BETWEEN(SYSDATE, employee_birthday)/12) || ' Jahre und ' ||
  TRUNC(MOD(MONTHS_BETWEEN(SYSDATE, employee_birthday),12)) || ' Monate' AS "ALTER"
FROM employees;