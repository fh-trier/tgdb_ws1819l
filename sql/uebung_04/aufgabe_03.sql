SELECT
  AVG(COUNT(ST.STORAGE_ID))
FROM "STORAGE" ST
  RIGHT JOIN EMPLOYEES E ON (E.EMPLOYEE_ID = ST.EMPLOYEE_ID)
GROUP BY
  E.EMPLOYEE_FIRSTNAME,
  E.EMPLOYEE_LASTNAME;