#!/bin/bash
source "$( cd "$( dirname "${BASH_SOURCE[0]}" )" >/dev/null && pwd )/sources.sh"

# SQL-PLUS settings
STMTS=""
STMTS="${STMTS}\n SET SERVEROUTPUT ON;"

# --------------------------------------
# DESTROY SCHEMA
# --------------------------------------
STMTS="${STMTS}\n start ./sql/destroySchema.sql"

STMTS="${STMTS}\n EXIT;"


################## !DO NOT CHANGE ANYTHING BELOW THIS LINE! ##################
sleep 1

echo -e "+----------------------------------------------------------+"
echo -e "| DESTROY SCHEMA                                           |"
echo -e "+----------------------------------------------------------+"

echo -e ${STMTS}


# Execute SQL-Files
${SQLPLUS} -S ${TGDB_USER}/${TGDB_PASSWD}@${TGDB_HOST} << HERE
  $(echo -e ${STMTS})
HERE
