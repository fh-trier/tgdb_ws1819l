#!/bin/bash
source "$( cd "$( dirname "${BASH_SOURCE[0]}" )" >/dev/null && pwd )/sources.sh"

# SQL-PLUS settings
STMTS=""
STMTS="${STMTS}\n SET SERVEROUTPUT ON;"

# --------------------------------------
# STYLING
# --------------------------------------
STMTS="${STMTS}\n start ./sql/sqlplus-settings.sql"

# --------------------------------------
# IMPORT SCHEMA
# --------------------------------------
STMTS="${STMTS}\n start ./sql/schema_01.sql"
STMTS="${STMTS}\n start ./sql/patch_01.sql"
STMTS="${STMTS}\n start ./sql/permissions.sql"

STMTS="${STMTS}\n EXIT;"


################## !DO NOT CHANGE ANYTHING BELOW THIS LINE! ##################
sleep 1

echo -e "+----------------------------------------------------------+"
echo -e "| IMPORT SCHEMA                                            |"
echo -e "+----------------------------------------------------------+"

echo -e ${STMTS}


# Execute SQL-STMTS
${SQLPLUS} -S ${TGDB_USER}/${TGDB_PASSWD}@${TGDB_HOST} << HERE
  $(echo -e ${STMTS})
HERE
