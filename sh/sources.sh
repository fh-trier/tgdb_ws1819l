#!/usr/bin/env bash

if [ -z ${DB_USER+x} ]; then
  echo "DB_USER is unset!";
  exit 1
fi

if [ -z ${DB_PASS+x} ]; then
  echo "DB_PASS is unset!";
  exit 1
fi

if [ -z ${DB_HOST+x} ]; then
  echo "DB_HOST is unset!";
  exit 1
fi

# Path to sqlplus
SQLPLUS="$(which sqlplus)"
# SQLPLUS="/opt/oracle/instantclient/sqlplus"