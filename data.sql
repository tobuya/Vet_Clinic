/* Populate database with sample data. */

INSERT INTO animals(name, date_of_birth, weight_kg, neutered, escape_attempts)
VALUES
('Agumon', 'Feb 3, 2020', 10.23,'true', 0 ),
('Gabumon', 'Nov 15, 2018', 8, 'true', 2),
('Pikachu', 'Jan 7, 2021', 15.04, 'false', 1),
('Devimon', 'May 12, 2017', 11, 'true', 5);

INSERT INTO animals(name, date_of_birth, weight_kg, neutered, escape_attempts)
VALUES
('Charmander', 'Feb 8, 2020', -11,'false', 0 ),
('Plantmon', 'Nov 15, 2021', -5.7,'true', 2 ),
('Squirtle', 'Apr 2, 1993', -12.13, 'false', 3 ),
('Angemon',  'Jun 12, 2005', -45,  'true', 1),
('Boarmon', 'Jun 7, 2005', 20.4, 'true', 7),
('Blossom', 'Oct 13, 1998', 17, 'true', 3),
('Ditto', 'May 14, 2022', 22, 'true', 4);

INSERT INTO owners(full_name, age)
VALUES
('Sam Smith', 34),
('Jennifer Orwell', 19),
('Bob', 45),
('Melody Pond', 77),
('Dean Winchester', 14),
('Jodie Whittaker', 38);

INSERT INTO species(name)
VALUES
('Pokemon'),
('Digimon');

UPDATE animals SET species_id = 2 WHERE name LIKE '%mon';
UPDATE animals SET species_id = 1 WHERE species_id IS NULL;

UPDATE animals SET owner_id = 1 WHERE name = 'Agumon';
UPDATE animals SET owner_id = 2 WHERE name = 'Gabumon' OR name = 'Pikachu';
UPDATE animals SET owner_id = 3 WHERE name = 'Devimon' OR name = 'Plantmon';
UPDATE animals SET owner_id = 4 WHERE name = 'Charmander' OR name = 'Squirtle' OR name = 'Blossom';
UPDATE animals SET owner_id = 5 WHERE name = 'Angemon' OR name = 'Boarmon';


INSERT INTO vets(name, age, date_of_graduation)
VALUES
('William Tatcher', 45, 'Apr 23, 2000'),
('Maisy Smith', 26, 'Jan 17, 2019'),
('Stephanie Mendez', 64, 'May 4, 1981'),
('Jack Harkness', 38, 'Jun 8, 2008');

INSERT INTO specializations(species_id, vet_id)
VALUES
(1, 1),
(1, 3),
(2, 3),
(2, 4);

INSERT INTO visits(animal_id, vet_id, date_of_visit)
VALUES
(1, 1, 'May 24, 2020'),
(1, 3, 'Jul 22, 2020'),
(2, 4, 'Feb 2, 2021'),
(3, 2, 'Jan 5, 2020'),
(3, 2, 'Mar 8, 2020'),
(3, 2, 'May 14, 2020'),
(4, 3, 'May 4, 2021'),
(5, 4, 'Feb 24, 2021'),
(6, 2, 'Dec 21, 2019'),
(6, 1, 'Aug 10, 2020'),
(6, 2, 'Apr 7, 2021'),
(7, 3, 'Sep 29, 2019'),
(8, 4, 'Oct 3, 2020'),
(8, 4, 'Nov 4, 2020'),
(9, 2, 'Jan 24, 2019'),
(9, 2, 'May 15, 2019'),
(9, 2, 'Feb 27, 2020'),
(9, 2, 'Aug 3, 2020'),
(10, 3, 'May 24, 2020'),
(10, 1, 'Jan 11, 2021');