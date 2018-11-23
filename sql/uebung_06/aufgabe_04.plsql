-- Lösung:
-- Die einzelnen Abfragen könnten mit einem eigenen
-- BEGIN EXCEPTION END Block gesichert werden um
-- sicherzustellen, dass die Abfrage funktioniert hat
-- und die Daten beim SELECT auch gefunden wurden.
-- Falls nicht, soll der Prozess abgebrochen werden.

DECLARE

  v_cnt               INTEGER                       := 5;
  v_x_lenght          storage.x_length%TYPE         := 4000;
  v_y_lenght          storage.y_length%TYPE         := 2000;
  v_metal_thickness   storage.metal_thickness%TYPE  := 3;

  v_metal_id          metals.metal_id%TYPE;
  v_metal_name        metals.metal_name%TYPE        := 'Edelstahl';
  v_metal_property    metals.metal_property%TYPE    := '1.4301';
  v_metal_type        metals.metal_type%TYPE        := '';

  v_shelf_id          shelfs.shelf_id%TYPE;
  v_shelf_name        shelfs.shelf_name%TYPE        := 'A';
  v_shelf_number      shelfs.shelf_number%TYPE      := 10;

  v_supplier_id       suppliers.supplier_id%TYPE;
  v_supplier_name     suppliers.supplier_name%TYPE  := 'Thyssenkrupp AG';

  v_contact_id        contacts.contact_id%TYPE;

  v_employee_id       employees.employee_id%TYPE;

BEGIN

  -- Nehme den ersten Datensatz aus der
  -- Tabelle employee als Referenz für
  -- employee_id
  SELECT employee_id
  INTO v_employee_id
  FROM employees
  WHERE ROWNUM = 1;

  -- Suche nach der Metall-ID
  SELECT metal_id
  INTO v_metal_id
  FROM metals
  WHERE metal_name = v_metal_name
  AND metal_property = v_metal_property
  AND metal_type IS NULL;

  -- Suche nach der Regal-ID
  SELECT shelf_id
  INTO v_shelf_id
  FROM shelfs
  WHERE shelf_name = v_shelf_name
  AND shelf_number = v_shelf_number;

  -- Suche nach der Lieferanten-ID
  SELECT supplier_id
  INTO v_supplier_id
  FROM suppliers
  WHERE supplier_name = v_supplier_name;

  -- Nehme den ersten Ansprechpartner aus der
  -- Tabelle suppliers als Referenz für
  -- contact_id
  SELECT contact_id
  INTO v_contact_id
  FROM contacts
  WHERE ROWNUM = 1
  AND supplier_id = v_supplier_id;

  -- Lassen die Schleife so oft laufen wie in
  -- v_cnt definiert ist
  FOR rec IN 1..v_cnt LOOP
    INSERT INTO "STORAGE" (storage_id, contact_id, employee_id, metal_id, shelf_id, x_length, y_length, metal_thickness)
    VALUES (NEW_UUID(), v_contact_id, v_employee_id, v_metal_id, v_shelf_id, v_x_lenght, v_y_lenght, v_metal_thickness);
  END LOOP;

END;
/