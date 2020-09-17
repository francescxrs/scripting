-- PostgreSQL

-- Creem base de dades proyecto_03_db
CREATE DATABASE proyecto_03_db;
-- Connect a base de dades proyecto_03_db
\c proyecto_03_db;

-- Creació d'usuari i contrasenya 
CREATE USER proyecto_03_user WITH PASSWORD 'proyecto_03_user';
-- Configuració per a encodificació de la db
ALTER ROLE proyecto_03_user SET client_encoding TO 'utf8';
-- Configuració per a fer lectures de forma mes robusta/àgil, entre d'altres.
ALTER ROLE proyecto_03_user SET default_transaction_isolation TO 'read committed';
-- Configuració horaria
ALTER ROLE proyecto_03_user SET timezone TO 'UTC';
-- Assignació de permisos a usuari tipus 'Déu'
GRANT ALL PRIVILEGES ON proyecto_03_db TO proyecto_03_user;

-- Creem carpeta (schema) per a Tables principals, prescindint de l'schema default 'public'.
CREATE SCHEMA appbasics;

-- Creem taula entitat
CREATE TABLE entitat(
    id NUMBER(6) PRIMARY KEY,
    nom VARCHAR2(60) NOT NULL
);

-- Creem seqüència i registres
CREATE SEQUENCE enum_enters_seq START WITH 1 INCREMENT BY 1;

-- L'insert de torn seria tal que:
-- INSERT INTO entitat VALUES(enum_enters_seq.NEXTVAL,'Nomdetorn Cognomdetorn Cognomdetorndos');


