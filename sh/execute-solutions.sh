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
# EXEXUTE SOLUTIONS
# --------------------------------------
if [ -z ${FOLDER+x} ]; then
  for FILE in `ls ./sql/uebung_*/*`; do
    STMTS="${STMTS}\n start ${FILE}"
  done
else
  for FILE in `ls ./sql/${FOLDER}/*`; do
    STMTS="${STMTS}\n start ${FILE}"
  done
fi


STMTS="${STMTS}\n EXIT;"


################## !DO NOT CHANGE ANYTHING BELOW THIS LINE! ##################
sleep 1

echo -e "+----------------------------------------------------------+"
echo -e "| EXECUTE SOLUTIONS                                        |"
echo -e "+----------------------------------------------------------+"

echo -e ${STMTS}


# Execute SQL-STMTS
${SQLPLUS} -S ${TGDB_USER}/${TGDB_PASSWD}@${TGDB_HOST} << HERE
  $(echo -e ${STMTS})
HERE