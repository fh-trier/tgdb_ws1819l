SELECT
  e.employee_firstname,
  e.employee_lastname,
  e.employee_birthday,
  e.employee_hiredate
FROM employees e
WHERE TO_CHAR(e.employee_birthday, 'YYYY') LIKE '199_';