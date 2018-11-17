SELECT contact_firstname, contact_lastname
FROM contacts
WHERE REGEXP_LIKE(contact_firstname, '^[a-zA-Z]{3}[ah]([a].[l])?$');