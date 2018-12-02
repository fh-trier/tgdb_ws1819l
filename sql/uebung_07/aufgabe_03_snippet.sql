CREATE OR REPLACE FUNCTION list_employees(inCursor IN SYS_REFCURSOR) AS
  DBMS_OUTPUT.PUT_LINE('Deine Lösung');
END;
/

EXEC list_employees(CURSOR(SELECT * FROM employees WHERE employee_firstname LIKE 'J%'));