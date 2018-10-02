SELECT
  c.contact_firstname,
  c.contact_lastname,
  c.contact_phone,
  c.contact_mobile,
  c.contact_mail
FROM contacts c
WHERE c.contact_mail IS NULL;