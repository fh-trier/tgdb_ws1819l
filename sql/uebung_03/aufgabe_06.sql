CREATE VIEW "ALL_CONTACTS" AS
SELECT
  c.contact_firstname,
  c.contact_lastname,
  c.contact_phone,
  c.contact_mobile,
  c.contact_mail
FROM contacts c
UNION
SELECT
  pc.contact_firstname,
  pc.contact_lastname,
  pc.contact_phone,
  pc.contact_mobile,
  pc.contact_mail
FROM pcontacts pc;