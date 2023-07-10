/* Database schema to keep the structure of entire database. */

my_app=# create database vet_clinic;

my_app=# create table animals(
my_app(# id INT GENERATED ALWAYS AS IDENTITY,
my_app(# name VARCHAR(250),
my_app(# date_of_birth DATE,
my_app(# escape_attempts INT,
my_app(# neutered  BOOLEAN,
my_app(# weoght_kg DECIMAL
my_app(# );

