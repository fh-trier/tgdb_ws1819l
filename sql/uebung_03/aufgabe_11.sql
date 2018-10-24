COLUMN BESCHAEFTIGUNGSDAUER FORMAT a32

SELECT
  employee_firstname || ' ' || employee_lastname AS "EMPLOYEE",
  TRUNC(MONTHS_BETWEEN(SYSDATE, employee_hiredate)/12) AS "BESCHAEFTIGUNGSDAUER"
FROM employees;