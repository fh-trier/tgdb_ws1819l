BEGIN
  DBMS_OUTPUT.PUT_LINE('Liste alle Bundesländer/Städte mit');
  DBMS_OUTPUT.PUT_LINE('Lieferanten bezogen auf Deutschland.');
  DBMS_OUTPUT.PUT_LINE('+--------------------------------------+');
  FOR rec IN (
    SELECT
      co.country_name,
      st.state_name,
      ci.city_name,
      ci.city_postalcode,
      ci.city_id
    FROM countries co
      INNER JOIN states st ON (st.country_id = co.country_id)
      INNER JOIN cities ci ON (ci.state_id = st.state_id)
    WHERE co.country_name = 'Deutschland'
    ORDER BY
      co.country_name,
      st.state_name,
      ci.city_name,
      ci.city_postalcode
  ) LOOP

    DBMS_OUTPUT.PUT_LINE('- ' || rec.country_name || '; ' || rec.state_name || '; ' || rec.city_name || '; ' || rec.city_postalcode);

    FOR rec2 IN (
      SELECT
        supplier_id,
        supplier_name
      FROM suppliers
      WHERE city_id = rec.city_id
    ) LOOP

      DBMS_OUTPUT.PUT_LINE(CHR(9) || rec2.supplier_name);

      FOR rec3 IN (
        SELECT
          contact_firstname,
          contact_lastname
        FROM contacts
        WHERE supplier_id = rec2.supplier_id
      ) LOOP

        DBMS_OUTPUT.PUT_LINE(CHR(9) || CHR(9) || rec3.contact_firstname || ' ' || rec3.contact_lastname );

      END LOOP;

    END LOOP;

  END LOOP;
  DBMS_OUTPUT.PUT_LINE('+--------------------------------------+');

EXCEPTION
  WHEN NO_DATA_FOUND
    THEN RAISE_APPLICATION_ERROR(-20001, 'Es konnten keine Datensätze gefunden werden');
  WHEN OTHERS
    THEN DBMS_OUTPUT.PUT_LINE ('Folgender unerwarteter Fehler ist aufgetreten: ' || SQLERRM());
  RAISE;
END;
/