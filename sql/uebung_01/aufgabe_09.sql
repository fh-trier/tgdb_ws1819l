SELECT
  c.contact_firstname,
  c.contact_lastname,
  c.contact_phone,
  c.contact_mobile,
  c.contact_mail
FROM contacts c
WHERE ROWNUM < 10;

-- Bei Max Schnelllauf ist die E-Mail
-- von Ben Hammerschlag hinterlegt.