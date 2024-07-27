#!/bin/bash

juju run postgresql-k8s/leader get-password


juju ssh --container postgresql postgresql-k8s/leader bash


psql -U your_username -d your_database -f sql/create_person.sql
psql --host=10.1.188.213 --username=operator --password --list
psql --host=10.1.188.213 --username=operator --password postgres



CREATE DATABASE fullstack;  

## example
CREATE TABLE mytable (
	id SERIAL PRIMARY KEY,
	name VARCHAR(50),
	age INT
);

CREATE TABLE person (
    id SERIAL PRIMARY KEY,
    first_name VARCHAR(50) NOT NULL
);

## temp password: qIohj3q5D5BQksrf

## add mock data
INSERT INTO person (first_name) VALUES ('John');
INSERT INTO person (first_name) VALUES ('Jane');