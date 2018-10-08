SELECT e.employee_firstname, e.employee_lastname, st.storage_id
FROM employees e
  LEFT JOIN storage st ON (st.employee_id = e.employee_id)
WHERE st.storage_id IS NULL
GROUP BY e.employee_firstname, e.employee_lastname, st.storage_id;