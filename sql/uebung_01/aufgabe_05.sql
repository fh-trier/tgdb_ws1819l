SELECT
  e.employee_firstname,
  e.employee_lastname,
  e.employee_birthday,
  e.employee_hiredate
FROM employees e
WHERE e.employee_lastname LIKE '___i%'
OR e.employee_lastname LIKE '___ß%';