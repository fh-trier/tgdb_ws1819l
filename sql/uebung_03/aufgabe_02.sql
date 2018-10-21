-- Styling für sqlplus
COLUMN SCHEMA FORMAT a15
COLUMN TABLE_NAME FORMAT a15
COLUMN PRIVILEGE FORMAT a15
COLUMN GRANTEE FORMAT a15
COLUMN GRANTED_ROLE FORMAT a15

-- Wurden die Tabellen-Rechte direkt an dich
-- oder an PUBLIC vergeben?
SELECT
  atp.table_schema AS "SCHEMA",
  atp.table_name AS "TABLE_NAME",
  atp.privilege AS "PRIVILEGE",
  atp.grantee AS "GRANTEE"
FROM all_tab_privs atp
WHERE atp.table_name IN ('CONTACTS','STORAGE')
AND atp.table_schema LIKE 'PESCHM'
AND atp.grantee IN (
  (SELECT USER FROM DUAL),
  'PUBLIC'
);

-- Welche Rollen besitzt du direkt?
SELECT urp.granted_role
FROM user_role_privs urp

-- Welche Rollen sind anderen Rollen zugeordnet?
SELECT
  rrp.role AS "ROLE",
  rrp.granted_role AS "GRANTED_ROLE"
FROM role_role_privs rrp
WHERE rrp.role IN ('BW_STUDENT', 'FH_TRIER');

-- Haben Rollen Rechte an PESCHM.CONTACTS oder PESCHM.STORAGE?
SELECT
  atp.table_schema AS "SCHEMA",
  atp.table_name AS "TABLE_NAME",
  atp.privilege AS "PRIVILEGE",
  atp.grantee AS "GRANTEE"
FROM all_tab_privs atp
WHERE atp.table_name IN ('CONTACTS','STORAGE')
AND atp.table_schema LIKE 'PESCHM'
AND atp.grantee IN (
  (SELECT USER FROM DUAL),
  (SELECT granted_role FROM user_role_privs),
  'PUBLIC'
);