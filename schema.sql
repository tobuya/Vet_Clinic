/* Database schema to keep the structure of entire database. */
CREATE DATABASE vet_clinic;

CREATE TABLE animals (
  id INT GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
  name  VARCHAR(100),
  date_of_birth DATE,
  escape_attempts INT,
  neutered  BOOLEAN,
  weight_kg DECIMAL
);

ALTER TABLE animalS ADD COLUMN species VARCHAR(100);


CREATE TABLE owners (
  id INT GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
  full_name VARCHAR(100),
  age INT
);


CREATE TABLE species (
  id INT GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
  name VARCHAR(100)
);

ALTER TABLE animals DROP COLUMN species;

ALTER TABLE animals ADD COLUMN species_id INT;

ALTER TABLE animals
ADD CONSTRAINT fk_species
FOREIGN KEY (species_id)
REFERENCES species (id)
ON DELETE CASCADE;

ALTER TABLE animals ADD COLUMN owner_id INT;

ALTER TABLE animals
ADD CONSTRAINT fk_owner
FOREIGN KEY (owner_id)
REFERENCES owners (id)
ON DELETE CASCADE;
