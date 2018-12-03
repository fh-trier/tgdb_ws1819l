DECLARE
  v_employee_id employees.employee_id%TYPE;
BEGIN
  SELECT
    employee_id
  INTO
    v_employee_id
  FROM employees
  WHERE employee_firstname = 'Leni';

  DBMS_OUTPUT.PUT_LINE('Leni hat die Personal-Nr:' || v_employee_id);

EXCEPTION
  WHEN NO_DATA_FOUND
    THEN RAISE_APPLICATION_ERROR(-20001, 'Es wurde kein Mitarbeiter gefunden unter dem Namen');
  WHEN OTHERS
    THEN DBMS_OUTPUT.PUT_LINE ('Folgender unerwarteter Fehler ist aufgetreten: ');
  RAISE;
END;
/