SELECT
  c.contact_firstname,
  c.contact_lastname,
  c.contact_phone,
  c.contact_mobile,
  c.contact_mail
FROM contacts c
WHERE c.contact_mail LIKE '%thyssen.de'
AND ( c.contact_phone LIKE '%0211'
  OR c.contact_mobile LIKE '%0211'
);