UPDATE contacts
SET contact_mobile = REGEXP_REPLACE(contact_mobile, '^+49', '0049')
WHERE REGEXP_LIKE(contact_mobile, '+49.*');