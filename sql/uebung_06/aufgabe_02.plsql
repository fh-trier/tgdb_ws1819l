-- Funktion insert_employee
-- Parameter employee_mail wurde bewusst
-- weg gelassen, da die Spalte eine virtuelle-
-- Spalte ist und der Wert dynamisch erzeugt wird.
CREATE OR REPLACE FUNCTION insert_employee(
  in_employee_firstname IN VARCHAR2,
  in_employee_lastname  IN VARCHAR2,
  in_employee_birthday  IN DATE,
  in_employee_hiredate  IN DATE,
  in_employee_street    IN VARCHAR,
  in_city_plz           IN VARCHAR2
) RETURN CHAR AS

  v_employee_id   employees.employee_id%TYPE;
  v_city_id       cities.city_id%TYPE;

BEGIN
  -- Suche nach der City-ID zu der die PLZ passt.
  BEGIN
    SELECT city_id
    INTO v_city_id
    FROM cities
    WHERE city_postalcode = in_city_plz;
  EXCEPTION
    WHEN NO_DATA_FOUND THEN
      RAISE_APPLICATION_ERROR(-20000, 'Konnte keine city_id passend zu Postleitzahl ' || in_city_plz || ' finden');
    WHEN OTHERS THEN
      RAISE;
  END;

  -- Füge einen neuen Datensatz in die Tabelle
  -- employees ein. Dabei wird die employee_id
  -- als return wert zurück gegeben und in die
  -- Variable v_employee_id gespeichert.
  INSERT INTO employees(
    employee_id,
    employee_firstname,
    employee_lastname,
    employee_birthday,
    employee_hiredate,
    employee_street,
    city_id)
  VALUES(
    NEW_UUID(),
    in_employee_firstname,
    in_employee_lastname,
    in_employee_birthday,
    in_employee_hiredate,
    in_employee_street,
    v_city_id
  )
  RETURNING employee_id
  INTO v_employee_id;

  -- Bestätige die Transaktion
  COMMIT;

  -- Gebe die endgülte employee_id zurück
  RETURN v_employee_id;

EXCEPTION
  WHEN OTHERS THEN
    RAISE_APPLICATION_ERROR(-20000, SQLERRM);
END;
/

-- Test
-- Rufe die Funktion anhand eines anonymen PL/SQL-Codeblocks auf.
-- Gebe der Funktion alle Parameter explizit mit. Dadurch kann
-- die Reihenfolge der Parametern zu der Reihenfolge
-- bei der Deklaration der Funktion verschieden sein. Außerdem
-- ist es dann Übersichtlicher was was ist ;)
DECLARE
  v_employee_id employees.employee_id%TYPE;
BEGIN
  v_employee_id := insert_employee(
    in_employee_firstname => 'Hugo',
    in_employee_lastname  => 'McKinnock',
    in_employee_birthday  => TO_DATE('1980-10-06', 'YYYY-MM-DD'),
    in_employee_hiredate  => SYSDATE,
    in_employee_street    => 'Hauptsraße',
    in_city_plz           => '54292'
  );
  DBMS_OUTPUT.PUT_LINE(v_employee_id);
END;
/