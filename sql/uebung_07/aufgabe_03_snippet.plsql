CREATE OR REPLACE FUNCTION list_employees(
  in_cursor IN SYS_REFCURSOR
) RETURN VARCHAR2 AS

BEGIN
  DBMS_OUTPUT.PUT_LINE('Deine Lösung');
END
/

-- Ausführen deiner Funktion
DECLARE
  rc SYS_REFCURSOR;
  res VARCHAR2(4000);
BEGIN
  OPEN rc FOR SELECT * FROM employees WHERE employee_firstname LIKE 'J%';
  res := list_employees(rc);
  DBMS_OUTPUT.PUT_LINE(res);
END;
/