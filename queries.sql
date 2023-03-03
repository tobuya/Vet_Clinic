/*Queries that provide answers to the questions from all projects.*/

SELECT * FROM animals WHERE name = 'Luna';
SELECT * FROM animals WHERE name LIKE '%mon';
SELECT name FROM animals WHERE date_of_birth BETWEEN '2016-01-01' AND '2019-12-31';
SELECT name FROM animals WHERE neutered = true AND escape_attempts < 3;
SELECT date_of_birth FROM animals WHERE name = 'Agumon' OR name = 'Pikachu';
SELECT name, escape_attempts FROM animals WHERE weight_kg > 10.5;
SELECT * FROM animals WHERE neutered = true;
SELECT * FROM animals WHERE name != 'Gabumon';
SELECT * FROM animals WHERE weight_kg >= 10.4 AND weight_kg <= 17.3;

BEGIN;
UPDATE animals SET species = 'unspecified';
SELECT * FROM animals;
ROLLBACK;
SELECT * FROM animals;

BEGIN;
UPDATE animals SET species = 'digimon' WHERE name LIKE '%mon';
UPDATE animals SET species = 'pokemon' WHERE species IS NULL;
COMMIT;
SELECT * FROM animals;

BEGIN;
DELETE FROM animals;
ROLLBACK;
SELECT * FROM animals;

BEGIN;
DELETE FROM animals WHERE date_of_birth > '2022-01-01';
SAVEPOINT my_savepoint;
UPDATE animals SET weight_kg = weight_kg * -1;
SELECT * FROM animals;
ROLLBACK TO my_savepoint;
UPDATE animals SET weight_kg = weight_kg * -1 WHERE weight_kg < 0;
COMMIT;
SELECT * FROM animals;

SELECT count(*) FROM animals;
SELECT count(*) FROM animals WHERE escape_attempts = 0;
SELECT AVG(weight_kg) FROM animals;
SELECT neutered, COUNT(escape_attempts) FROM animals GROUP BY neutered;
SELECT species, MIN(weight_kg), MAX(weight_kg) FROM animals GROUP BY species;
SELECT species, AVG(escape_attempts) FROM animals WHERE date_of_birth >= '1990-01-01' AND date_of_birth <= '2000-12-31' GROUP BY species;

-- Animals belonging to Melody Pond
SELECT a.name FROM animals a JOIN owners o ON a.owner_id = o.id WHERE o.id = 4;

-- List of all animals that are pokemon (their type is Pokemon)
SELECT a.name FROM animals a JOIN species s ON a.species_id = s.id WHERE s.id = 1;

-- List of all owners and their animals, including those that don't own any animal
SELECT o.full_name, a.name FROM owners o LEFT JOIN animals a ON o.id = a.owner_id;

-- Number of animals per species
SELECT s.name, COUNT(*) FROM animals a JOIN species s ON a.species_id = s.id GROUP BY s.name;

-- List of all Digimon owned by Jennifer Orwell
SELECT a.name, s.name AS species_name
FROM animals a
JOIN species s
ON a.species_id = s.id
JOIN owners o
ON a.owner_id = o.id 
WHERE o.full_name = 'Jennifer Orwell' AND s.name = 'Digimon';

-- List of all animals owned by Dean Winchester that haven't tried to escape
SELECT a.name, a.escape_attempts, o.full_name
FROM animals a
JOIN owners o ON a.owner_id = o.id 
JOIN species s ON a.species_id = s.id
WHERE a.escape_attempts = 0 AND o.full_name = 'Dean Winchester';

-- Find who owns the most animals
SELECT o.full_name, COUNT(a.name) 
FROM animals a
JOIN owners o ON a.owner_id = o.id GROUP BY o.full_name
ORDER BY COUNT(*) DESC
LIMIT 1;

-- Last animal seen by William Tatcher
SELECT a.name AS animal_name, v.date_of_visit 
FROM animals a
JOIN visits v
ON a.id = v.animal_id 
WHERE v.vet_id = 1 
GROUP BY a.name, v.date_of_visit 
ORDER BY v.date_of_visit
DESC LIMIT 1;

-- Number of different animals seen by Stephanie Mendez
SELECT ve.name, COUNT(vi.animal_id) AS animal_count 
FROM visits vi
JOIN vets ve
ON vi.vet_id = ve.id 
WHERE ve.name = 'Stephanie Mendez' 
GROUP BY ve.name;

-- List of all vets and their specialties, including vets with no specialties
SELECT ve.name AS vet_name, s.name AS species_name
FROM vets ve
LEFT JOIN specializations sp
ON ve.id = sp.vet_id 
LEFT JOIN species s
ON s.id = sp.species_id;

-- List of all animals that visited Stephanie Mendez between April 1st and August 30th, 2020
SELECT ve.name AS vet_name, a.name AS animal_name, vi.date_of_visit
FROM vets ve
INNER JOIN visits vi
ON ve.id = vi.vet_id  
JOIN animals a
ON a.id = vi.animal_id 
WHERE ve.name = 'Stephanie Mendez' 
AND vi.date_of_visit BETWEEN 'Apr 1, 2020' AND 'Aug 30, 2020' 
GROUP BY ve.name, a.name, vi.date_of_visit;

-- Animal with the most visits to vets
SELECT a.name, count(*) 
FROM animals a
JOIN visits vi
ON vi.animal_id = a.id
GROUP BY a.name
ORDER BY count
DESC LIMIT 1;

-- Animal that visited Maisy Smith first
SELECT a.name, ve.name, vi.date_of_visit 
FROM animals a
JOIN visits vi
ON a.id = vi.animal_id
JOIN vets ve
ON vi.vet_id = ve.id
WHERE ve.name = 'Maisy Smith'
ORDER BY vi.date_of_visit
ASC lIMIT 1;

-- Details for most recent visit: animal information, vet information, and date of visit
SELECT a.name AS animal_name, ve.name AS vet_name, vi.date_of_visit
FROM animals a
JOIN visits vi
ON a.id = vi.animal_id
JOIN vets ve
ON vi.vet_id = ve.id
ORDER BY vi.date_of_visit
DESC lIMIT 1;

-- Number of visits with a vet who did not specialize in that animal's species
SELECT COUNT(*) 
FROM vets ve 
JOIN visits vi 
ON vi.vet_id = ve.id
JOIN animals a
ON vi.animal_id = a.id
JOIN specializations sp 
ON ve.id = sp.vet_id
WHERE NOT sp.species_id = a.species_id;

-- Specialty that Maisy Smith should consider getting into based on the species she gets the most
SELECT ve.name AS vet_name, spe.name AS species_name, COUNT(spe.name)
FROM vets ve
JOIN visits vi
ON vi.vet_id = ve.id 
JOIN animals a
ON vi.animal_id = a.id 
JOIN species spe
ON a.species_id = spe.id 
WHERE ve.name = 'Maisy Smith' 
GROUP BY spe.name, ve.name 
ORDER BY COUNT 
DESC lIMIT 1;
