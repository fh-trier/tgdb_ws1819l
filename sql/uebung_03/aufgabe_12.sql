-- Add Column
ALTER TABLE employees
ADD SALARY NUMBER(7,2);

ALTER TABLE employees
ADD HIRE_YEAR NUMBER(2);

-- Define HIRE_YEAR
UPDATE employees e
SET hire_year = (
  SELECT TRUNC(MONTHS_BETWEEN(SYSDATE, employee_hiredate)/12)
  FROM employees
  WHERE employee_id = e.employee_id
);

-- Define Salary
UPDATE employees
SET salary = CASE
  WHEN 0 <= hire_year AND hire_year < 5 THEN 2000
  WHEN 5 <= hire_year AND hire_year < 7 THEN 2000 * 1.05
  WHEN 7 <= hire_year AND hire_year < 10 THEN 2000 * 1.1
  WHEN 10 <= hire_year AND hire_year < 12 THEN 2000 * 1.125
  ELSE 2000 * 1.15
  END;