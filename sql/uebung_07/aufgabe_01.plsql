CREATE OR REPLACE FUNCTION get_suppliers_sales_volume(
  in_supplier_id IN CHAR
) RETURN VARCHAR2 AS
  v_supplier_name           suppliers.supplier_name%TYPE;
  v_supplier_sales_volume   NUMBER(9,2);
BEGIN

  SELECT
    su.supplier_name,
    SUM((st.surface_area / 1000000) * st.metal_thickness * m.metal_price)
  INTO
    v_supplier_name,
    v_supplier_sales_volume
  FROM storage st
    INNER JOIN contacts co ON (co.contact_id = st.contact_id)
    INNER JOIN suppliers su ON (su.supplier_id = co.supplier_id)
    INNER JOIN metals m ON (m.metal_id = st.metal_id)
  WHERE su.supplier_id = in_supplier_id
  GROUP BY su.supplier_name;

  RETURN v_supplier_name || ' hat einen Umsatz von ' || v_supplier_sales_volume || ' erziehlt.';

EXCEPTION
  WHEN OTHERS THEN
    RAISE_APPLICATION_ERROR(-20000, SQLERRM);
END;
/

-- Test
-- Rufe die Funktion anhand eines anonymen PL/SQL-Codeblocks auf.
-- Gebe der Funktion die ID von Thyssenkrupp AG als Beispiel mit.
-- Die ID muss rausgesucht werden, da diese dynamisch durch UUID
-- generiert wurde.
SET serveroutput on
DECLARE
  res VARCHAR2(500);
  v_supplier_id CHAR(36);
BEGIN

  -- Suche nach Supplier-ID
  BEGIN
    SELECT supplier_id
    INTO v_supplier_id
    FROM suppliers
    WHERE supplier_name = 'Thyssenkrupp AG';
  EXCEPTION
    WHEN NO_DATA_FOUND THEN
      RAISE_APPLICATION_ERROR(-20000, 'Konnte die ID nicht ermitteln. Gebe die ID entweder statisch der Funktion mit oder überprüfe den Namen des Lieferanten');
  END;

  -- Führe Funktion aus
  res := get_suppliers_sales_volume(v_supplier_id);
  DBMS_OUTPUT.PUT_LINE(res);
END;
/