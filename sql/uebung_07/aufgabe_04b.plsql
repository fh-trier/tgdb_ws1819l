CREATE OR REPLACE PROCEDURE list_suppliers AS

BEGIN
  DBMS_OUTPUT.PUT_LINE('Liste alle Bundesländer/Städte mit');
  DBMS_OUTPUT.PUT_LINE('Lieferanten, deren Anzahl an Mitarbeitern')
  DBMS_OUTPUT.PUT_LINE('und das letzte Datum andem Ware bezogen');
  DBMS_OUTPUT.PUT_LINE('in Bezug auf Deutschland.');
  DBMS_OUTPUT.PUT_LINE('+--------------------------------------+');

  -- Durchlaufe die Schleife so oft wie die SELECT-Abfrage
  -- Datensätze zurück gibt. Über rec ("record") kann interativ
  -- auf die Datensätze zugegriffen werden, die im SELECT-Statement
  -- genannt sind.
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

    -- Gebe Land/Bundesland/Stadt/PLZ aus
    DBMS_OUTPUT.PUT_LINE('- ' || rec.country_name || '; ' || rec.state_name || '; ' || rec.city_name || '; ' || rec.city_postalcode);

    -- Suche nach alle Lieferanten in dem aktuellen Standort
    -- von rec ("record"). Summiere die Anzahl der Mitarbeiter
    -- auf und suche nach dem letzten Eintrag in Storage
    -- um zu ermitteln, wann das letzte mal einen Eintrag im Lager
    -- vorgenommen wurde. Interpretiere dies als letzten Einkauf.
    FOR rec2 IN (
      SELECT
        supplier_id,
        supplier_name,
        (
          SELECT COUNT(*)
          FROM contacts
          WHERE supplier_id = s.supplier_id
        ) AS num_of_contacts,
        (
          SELECT MAX(st.creation_date)
          FROM storage st
            INNER JOIN contacts c ON (c.contact_id = st.contact_id)
            INNER JOIN suppliers s ON (s.supplier_id = c.supplier_id)
          WHERE s.supplier_id = s.supplier_id
        ) AS last_purchase
      FROM suppliers s
      WHERE city_id = rec.city_id
    ) LOOP

      -- Gebe den Lieferanten mit Anzahl der Mitarbeiter
      -- und dem letzten EInkaufsdatum aus.
      DBMS_OUTPUT.PUT_LINE(
        CHR(9) ||
        rec2.supplier_name || '; ' ||
        rec2.num_of_contacts || '; ' ||
        rec2.last_purchase
      );

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


-- Test
-- Führe die Prozedur aus.
EXEC list_suppliers();
