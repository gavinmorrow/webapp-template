#!/bin/bash
echo "|----||> Initializing database..."
set -e
export PGPASSWORD=$POSTGRES_PASSWORD;
psql -v ON_ERROR_STOP=1 -U "$POSTGRES_USER" -d "$POSTGRES_DB" <<-EOSQL
  CREATE USER $APP_DB_USER WITH PASSWORD '$APP_DB_PASSWORD';
  CREATE DATABASE $APP_DB_NAME;
  GRANT ALL PRIVILEGES ON DATABASE $APP_DB_NAME TO $APP_DB_USER;
  \connect $APP_DB_NAME $APP_DB_USER
  BEGIN;
    CREATE TABLE IF NOT EXISTS universe (
	  the_answer INT NOT NULL DEFAULT 42,
	  the_question VARCHAR(255) NOT NULL DEFAULT 'What is the meaning of life, the universe, and everything?'
	);
  COMMIT;
EOSQL

echo "|----||> Finished initializing database..."
