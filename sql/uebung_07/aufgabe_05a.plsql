CREATE OR REPLACE PROCEDURE list_suppliers(
  in_state_name IN VARCHAR2
) AS

BEGIN

  DBMS_OUTPUT.PUT_LINE('Liste alle Bundesländer/Städte mit');
  DBMS_OUTPUT.PUT_LINE('Lieferanten, deren Anzahl an Mitarbeitern');
  DBMS_OUTPUT.PUT_LINE('und das letzte Datum andem Ware bezogen');
  DBMS_OUTPUT.PUT_LINE('in Bezug auf Deutschland.');
  DBMS_OUTPUT.PUT_LINE('+--------------------------------------+');

  FOR rec IN (
    SELECT
      co.country_name,
      st.state_name,
      ci.city_name,
      ci.city_postalcode,
      su.supplier_name,
      (
        SELECT COUNT(*)
        FROM contacts
        WHERE supplier_id = su.supplier_id
      ) AS num_of_contacts,
      (
        SELECT MAX(st.creation_date)
        FROM storage st
          INNER JOIN contacts c ON (c.contact_id = st.contact_id)
          INNER JOIN suppliers s ON (s.supplier_id = c.supplier_id)
        WHERE s.supplier_id = su.supplier_id
      ) AS last_purchase
    FROM countries co
      INNER JOIN states st ON (st.country_id = co.country_id)
      INNER JOIN cities ci ON (ci.state_id = st.state_id)
      INNER JOIN suppliers su ON (ci.city_id = su.city_id)
    WHERE co.country_name = 'Deutschland'
    AND REGEXP_LIKE(st.state_name, in_state_name, 'i')
    ORDER BY
      co.country_name,
      st.state_name,
      ci.city_name,
      ci.city_postalcode
  ) LOOP
    DBMS_OUTPUT.PUT_LINE(
      rec.country_name || '; ' ||
      rec.state_name || '; ' ||
      rec.city_name || '; ' ||
      rec.city_postalcode || '; ' ||
      rec.supplier_name || '; ' ||
      rec.num_of_contacts || '; ' ||
      TO_CHAR(rec.last_purchase, 'YYYY-MM-DD')
    );
  END LOOP;

  DBMS_OUTPUT.PUT_LINE('+--------------------------------------+');

END;
/


EXEC list_suppliers('Rheinland-Pfalz');