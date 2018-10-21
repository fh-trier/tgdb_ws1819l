#!/usr/bin/env bash

if [ -z ${ADBS_USER+x} ]; then
  echo "TGDB_USER is unset!";
  exit 1
fi

if [ -z ${ADBS_PASSWD+x} ]; then
  echo "TGDB_PASSWD is unset!";
  exit 1
fi

if [ -z ${TGDB_HOST+x} ]; then
  echo "TGDB_HOST is unset!";
  exit 1
fi

# Path to sqlplus
SQLPLUS="$(which sqlplus)"
# SQLPLUS="/opt/oracle/instantclient/sqlplus"