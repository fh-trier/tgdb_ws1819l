-- Funktion list_employees
-- Konkadiniere für jeden gefunden Mitarbeiter einen
-- string. Dieser String enthält pro Mitarbeiter
-- informationen wie Vorname, Nachname, Geburtsdatum ect.
-- Gebe den konkadinierten string zurück.
CREATE OR REPLACE FUNCTION list_employees(
  in_cursor IN SYS_REFCURSOR
) RETURN VARCHAR2 AS
  rec_employee employees%ROWTYPE;
  v_out VARCHAR2(4000);
BEGIN

  -- Erstelle den string
  LOOP
    FETCH in_cursor INTO rec_employee;
    EXIT WHEN in_cursor%NOTFOUND;
    v_out := rec_employee.employee_firstname || ' ' ||
             rec_employee.employee_lastname || '; ' ||
             TO_CHAR(rec_employee.employee_birthday, 'YYYY-MM-DD') || '; ' ||
             TO_CHAR(rec_employee.employee_hiredate, 'YYYY-MM-DD') || CHR(10) ||
             v_out;
  END LOOP;

  -- Schließe den Cursor
  CLOSE in_cursor;

  -- Gebe den string zurück
  RETURN v_out;

EXCEPTION
  WHEN OTHERS THEN
    RAISE_APPLICATION_ERROR(-20000, SQLERRM);
END;
/

-- Test_01
-- Gebe einen string für alle Mitarbeiter aus
DECLARE
  rc SYS_REFCURSOR;
  res VARCHAR2(4000);
BEGIN
  OPEN rc FOR SELECT * FROM employees;
  res := list_employees(rc);
  DBMS_OUTPUT.PUT_LINE(res);
END;
/

-- Test_02
-- Gebe einen string für alle Mitarbeiter aus,
-- deren Vorname mit einem J anfängt.
DECLARE
  rc SYS_REFCURSOR;
  res VARCHAR2(4000);
BEGIN
  OPEN rc FOR SELECT * FROM employees WHERE employee_firstname LIKE 'J%';
  res := list_employees(rc);
  DBMS_OUTPUT.PUT_LINE(res);
END;
/