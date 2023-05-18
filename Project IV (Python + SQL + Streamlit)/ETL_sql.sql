-- creamos la base de datos
CREATE DATABASE happiness;
USE happiness;

-- Creamos las tablas y le ingestamos los datos
DROP TABLE IF EXISTS `population`;
CREATE TABLE IF NOT EXISTS `population` (
    `country` VARCHAR (60),
    `year` VARCHAR(20),
    `population` VARCHAR(20)
    ) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_spanish_ci;
    
LOAD DATA INFILE 'C:\\ProgramData\\MySQL\\MySQL Server 8.0\\Uploads\\Population (2015 - 2022).csv'
INTO TABLE `population` 
FIELDS TERMINATED BY '|' ENCLOSED BY '' ESCAPED BY '' 
LINES TERMINATED BY '\n' IGNORE 1 lines ;

DROP TABLE IF EXISTS `income`;
CREATE TABLE IF NOT EXISTS `income` (
    `id` VARCHAR (60),
    `name` VARCHAR(100),
    `capitalCity` VARCHAR(60),
    `longitude` VARCHAR(60),
    `latitude` VARCHAR(60),
    `regionValue` VARCHAR(60),
    `incomeValue` VARCHAR(60)
    ) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_spanish_ci;

LOAD DATA INFILE 'C:\\ProgramData\\MySQL\\MySQL Server 8.0\\Uploads\\Income.csv'
INTO TABLE `income` 
FIELDS TERMINATED BY '|' ENCLOSED BY '' ESCAPED BY '' 
LINES TERMINATED BY '\n' IGNORE 1 lines ;

DROP TABLE IF EXISTS `happiness`;
CREATE TABLE IF NOT EXISTS `happiness` (
    `country` VARCHAR (60),
    `happinessScore` VARCHAR(100),
    `economy(gdpPerCapita)` VARCHAR(60),
    `health(lifeExpectancy)` VARCHAR(60),
    `freedom` VARCHAR(60),
    `trust(governmentCorruption)` VARCHAR(60),
    `generosity` VARCHAR(60),
    `year` VARCHAR(60)
    ) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_spanish_ci;

LOAD DATA INFILE 'C:\\ProgramData\\MySQL\\MySQL Server 8.0\\Uploads\\Happiness (2015 - 2022).csv'
INTO TABLE `happiness` 
FIELDS TERMINATED BY '|' ENCLOSED BY '' ESCAPED BY '' 
LINES TERMINATED BY '\n' IGNORE 1 lines ;
    
-- ETL

-- tabla population
UPDATE population SET population = (REPLACE(population, ',', ''));

ALTER TABLE population MODIFY COLUMN population INT;
ALTER TABLE population MODIFY COLUMN `year` year;

ALTER TABLE population ADD idPopulation INT NOT NULL PRIMARY KEY AUTO_INCREMENT;

-- tabla income
DELETE FROM income WHERE regionValue = 'Aggregates'; 

UPDATE `income` SET capitalCity = 'Sin Dato' WHERE TRIM(capitalCity) = "" OR ISNULL(capitalCity);
UPDATE `income` SET longitude = '0' WHERE TRIM(longitude) = "" OR ISNULL(longitude);
UPDATE `income` SET latitude = '0' WHERE TRIM(latitude) = "" OR ISNULL(latitude);

ALTER TABLE INCOME CHANGE latitude latitude DECIMAL(10,7);
ALTER TABLE INCOME CHANGE longitude longitude DECIMAL(10,6);

ALTER TABLE income ADD idIncome INT NOT NULL PRIMARY KEY AUTO_INCREMENT;

ALTER TABLE income DROP COLUMN id ;

ALTER TABLE income CHANGE `name` country VARCHAR(60);

UPDATE income 
SET incomeValue = "Low income"
WHERE incomeValue = 'Not classified\r';

-- tabla happiness
DELETE FROM happiness
WHERE country = "xx";

UPDATE happiness
set `trust(governmentCorruption)` = 0
WHERE TRIM(`trust(governmentCorruption)`) = "" OR ISNULL(`trust(governmentCorruption)`);

ALTER TABLE happiness
ADD COLUMN idHappiness INT PRIMARY KEY NOT NULL AUTO_INCREMENT AFTER `year`,
MODIFY COLUMN happinessScore DECIMAL(3,2),
MODIFY COLUMN `economy(gdpPerCapita)` DECIMAL(3,2),
MODIFY COLUMN `health(lifeExpectancy)` DECIMAL(3,2),
MODIFY COLUMN freedom DECIMAL(3,2),
MODIFY COLUMN `trust(governmentCorruption)` DECIMAL(3,2),
MODIFY COLUMN generosity DECIMAL(3,2),
MODIFY COLUMN `year` year;

UPDATE happiness
SET country = REPLACE(country,"*","")
WHERE country LIKE ("%*");

ALTER TABLE happiness
ADD COLUMN idPopulation INT default '0' not null,
ADD COLUMN idIncome INT default '0' not null;

-- Creamos una tabla auxiliar de country para poder normalizar dicho campo
DROP TABLE IF EXISTS aux_country;
CREATE TABLE IF NOT EXISTS aux_country (
		idCountry INT PRIMARY KEY NOT NULL AUTO_INCREMENT,
        country VARCHAR (60),
        country_normalizado VARCHAR(60)
         ) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_spanish_ci;

-- Le ingestamos los datos únicos de country de las tres tablas con el fin de normalizarlo
INSERT INTO aux_country (country,country_normalizado)
SELECT DISTINCT country, country FROM happiness
UNION
SELECT DISTINCT country, country  FROM income
UNION
SELECT DISTINCT country, country FROM population;

-- normalización country
UPDATE `happiness`.`aux_country` SET `country_normalizado` = 'Bahamas' WHERE (`idCountry` = '186');
UPDATE `happiness`.`aux_country` SET `country_normalizado` = 'Congo' WHERE (`idCountry` = '194');
UPDATE `happiness`.`aux_country` SET `country_normalizado` = 'Congo' WHERE (`idCountry` = '195');
UPDATE `happiness`.`aux_country` SET `country_normalizado` = 'Congo (Kinshasa)' WHERE (`idCountry` = '120');
UPDATE `happiness`.`aux_country` SET `country_normalizado` = 'Congo (Brazzaville)' WHERE (`idCountry` = '139');
UPDATE `happiness`.`aux_country` SET `country_normalizado` = 'Congo (Kinshasa)' WHERE (`idCountry` = '267');
UPDATE `happiness`.`aux_country` SET `country_normalizado` = 'South Korea' WHERE (`idCountry` = '250');
UPDATE `happiness`.`aux_country` SET `country_normalizado` = 'Dominican Republic' WHERE (`idCountry` = '205');
UPDATE `happiness`.`aux_country` SET `country_normalizado` = 'Egypt' WHERE (`idCountry` = '208');
UPDATE `happiness`.`aux_country` SET `country_normalizado` = 'Eswatini' WHERE (`idCountry` = '174');
UPDATE `happiness`.`aux_country` SET `country_normalizado` = 'Gambia' WHERE (`idCountry` = '217');
UPDATE `happiness`.`aux_country` SET `country_normalizado` = 'Guinea' WHERE (`idCountry` = '218');
UPDATE `happiness`.`aux_country` SET `country_normalizado` = 'Hong Kong' WHERE (`idCountry` = '170');
UPDATE `happiness`.`aux_country` SET `country_normalizado` = 'Hong Kong' WHERE (`idCountry` = '165');
UPDATE `happiness`.`aux_country` SET `country_normalizado` = 'Hong Kong' WHERE (`idCountry` = '181');
UPDATE `happiness`.`aux_country` SET `country_normalizado` = 'Iran' WHERE (`idCountry` = '185');
UPDATE `happiness`.`aux_country` SET `country_normalizado` = 'South Korea' WHERE (`idCountry` = '224');
UPDATE `happiness`.`aux_country` SET `country_normalizado` = 'South Korea' WHERE (`idCountry` = '197');
UPDATE `happiness`.`aux_country` SET `country_normalizado` = 'Kyrgyzstan' WHERE (`idCountry` = '192');
UPDATE `happiness`.`aux_country` SET `country_normalizado` = 'Mónaco' WHERE (`idCountry` = '209');
UPDATE `happiness`.`aux_country` SET `country_normalizado` = 'North Cyprus' WHERE (`idCountry` = '167');
UPDATE `happiness`.`aux_country` SET `country_normalizado` = 'Sur Korea' WHERE (`idCountry` = '268');
UPDATE `happiness`.`aux_country` SET `country_normalizado` = 'Russia' WHERE (`idCountry` = '227');
UPDATE `happiness`.`aux_country` SET `country_normalizado` = 'Slovakia' WHERE (`idCountry` = '231');
UPDATE `happiness`.`aux_country` SET `country_normalizado` = 'Somalila' WHERE (`idCountry` = '91');
UPDATE `happiness`.`aux_country` SET `country_normalizado` = 'Syria' WHERE (`idCountry` = '235');
UPDATE `happiness`.`aux_country` SET `country_normalizado` = 'Taiwan' WHERE (`idCountry` = '164');
UPDATE `happiness`.`aux_country` SET `country_normalizado` = 'Taiwan' WHERE (`idCountry` = '241');
UPDATE `happiness`.`aux_country` SET `country_normalizado` = 'Trinidad and Tobago' WHERE (`idCountry` = '166');
UPDATE `happiness`.`aux_country` SET `country_normalizado` = 'Turkey' WHERE (`idCountry` = '239');
UPDATE `happiness`.`aux_country` SET `country_normalizado` = 'Turkey' WHERE (`idCountry` = '70');
UPDATE `happiness`.`aux_country` SET `country_normalizado` = 'United States' WHERE (`idCountry` = '265');
UPDATE `happiness`.`aux_country` SET `country_normalizado` = 'Venezuela' WHERE (`idCountry` = '243');
UPDATE `happiness`.`aux_country` SET `country_normalizado` = 'Vietnam' WHERE (`idCountry` = '266');
UPDATE `happiness`.`aux_country` SET `country_normalizado` = 'Yemen' WHERE (`idCountry` = '248');
UPDATE `happiness`.`aux_country` SET `country_normalizado` = 'Hong Kong' WHERE (`idCountry` = '269');
UPDATE `happiness`.`aux_country` SET `country_normalizado` = 'South Korea' WHERE (`idCountry` = '268');
UPDATE `happiness`.`aux_country` SET `country_normalizado` = 'Czechia' WHERE (`idCountry` = '31');
UPDATE `happiness`.`aux_country` SET `country_normalizado` = 'Hong Kong' WHERE (`idCountry` = '254');
UPDATE `happiness`.`aux_country` SET `country_normalizado` = 'Hong Kong' WHERE (`idCountry` = '206');
UPDATE `happiness`.`aux_country` SET `country_normalizado` = 'Macedonia' WHERE (`idCountry` = '252');
UPDATE `happiness`.`aux_country` SET `country_normalizado` = 'Ivory Coast' WHERE (`idCountry` = '191');
UPDATE `happiness`.`aux_country` SET `country_normalizado` = 'Macedonia' WHERE (`idCountry` = '168');
UPDATE `happiness`.`aux_country` SET `country_normalizado` = 'Moldova' WHERE (`idCountry` = '251');
UPDATE `happiness`.`aux_country` SET `country_normalizado` = 'Somalia' WHERE (`idCountry` = '91');
UPDATE `happiness`.`income` SET `country` = 'Congo (Kinshasa)' WHERE (`idIncome` = '67');
UPDATE `happiness`.`income` SET `country` = 'Congo (Brazzaville)' WHERE (`idIncome` = '68');
UPDATE `happiness`.`income` SET `country` = 'Swaziland' WHERE (`idIncome` = '184');
UPDATE `happiness`.`happiness` SET `country` = 'Cyprus' WHERE (`idHappiness` = '66');
UPDATE `happiness`.`happiness` SET `country` = 'Cyprus' WHERE (`idHappiness` = '220');
UPDATE `happiness`.`happiness` SET `country` = 'Cyprus' WHERE (`idHappiness` = '376');
UPDATE `happiness`.`happiness` SET `country` = 'Cyprus' WHERE (`idHappiness` = '528');
UPDATE `happiness`.`happiness` SET `country` = 'Cyprus' WHERE (`idHappiness` = '690');
UPDATE `happiness`.`happiness` SET `country` = 'Cyprus' WHERE (`idHappiness` = '858');
UPDATE `happiness`.`happiness` SET `country` = 'Cyprus' WHERE (`idHappiness` = '1009');
UPDATE `happiness`.`happiness` SET `country` = 'Cyprus' WHERE (`idHappiness` = '1163');

-- Normalizamos los campos country de todas las tablas con la tabla auxiliar
UPDATE happiness h
JOIN aux_country a ON (h.country = a.country)
SET h.country = a.country_normalizado;

UPDATE income i
JOIN aux_country a ON (i.country = a.country)
SET i.country = a.country_normalizado;

UPDATE population p
JOIN aux_country a ON (p.country = a.country)
SET p.country = a.country_normalizado;
	   

-- Igualamos los Ids de population y income (foreign key) en la tabla Happiness
UPDATE happiness h
JOIN population p ON (p.country = h.country)
JOIN año a ON (a.idAño = h.idAño)
SET h.idPopulation = p.idPopulation
WHERE h.idAño = p.idAño;

UPDATE happiness h
JOIN income i ON (i.country = h.country)
SET h.idIncome = i.idIncome;

-- Ver los que no tienen population
SELECT DISTINCT country
FROM happiness
WHERE idPopulation = '0';

-- Ver los que no tienen income
SELECT DISTINCT country
FROM happiness
WHERE idIncome = '0';

-- Elimino los que no tienen relación
DELETE FROM happiness WHERE idIncome = '0';
DELETE FROM happiness WHERE idPopulation = '0';

-- Creo las reestricciones
ALTER TABLE happiness
ADD CONSTRAINT idincome FOREIGN KEY (idIncome) REFERENCES income(idIncome);
ALTER TABLE happiness
ADD CONSTRAINT idpopulation FOREIGN KEY (idPopulation) REFERENCES population(idPopulation);

-- indexo el campo `year`
CREATE INDEX año
ON happiness (`year`);
CREATE INDEX año2
ON population(`year`);

-- Voy a crear una tabla auxiliar para los años y le ingesto los años
drop table if exists año;
CREATE TABLE IF NOT EXISTS año (
	idAño INT PRIMARY KEY NOT NULL AUTO_INCREMENT,
    año year default '0'
    ) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_spanish_ci;
    
INSERT INTO año (año)
SELECT DISTINCT `year` FROM happiness;   

-- Agrego el id de la tabla de año 
ALTER TABLE happiness ADD idAño int not null default '0';
ALTER TABLE population ADD idAño int not null default '0';

-- Igualo el ID de la tabla de año que he agregado
UPDATE happiness h
JOIN año a ON (a.año = h.`year`)
SET h.idAño = a.idAño;

UPDATE population p 
JOIN año a ON (a.año = p.`year`)
SET p.idAño = a.idAño;

-- Dropeo la columna `year`
ALTER TABLE happiness DROP COLUMN `year`;
ALTER TABLE population DROP COLUMN `year`;

-- Realizo las consultas correspondientes a cada tabla 

-- tabla population
SELECT 	p.country,
		p.population,
        a.año as `year`
FROM population p
JOIN año a ON (a.idAño = p.idAño)
ORDER BY 1 ; 

-- tabla happiness
SELECT 	h.country,
		h.happinessScore as score,
        h.`economy(gdpPerCapita)` as gdpPerCapita ,
        h.`health(lifeExpectancy)` as lifeExpectancy ,
        h.freedom,
        h.`trust(governmentCorruption)` as trust,
        h.generosity,
		a.año as `year`
FROM happiness h
JOIN año a ON (a.idAño = h.idAño)
ORDER BY 1;  

-- tabla income
SELECT	country,
		regionValue,
        incomeValue
FROM income
ORDER BY 1;

-- happiness avg total   
SELECT 	h.country as country,
		AVG(h.happinessScore) as score,
        AVG(h.`economy(gdpPerCapita)`) as gdpPerCapita ,
        AVG(h.`health(lifeExpectancy)`) as lifeExpectancy ,
        AVG(h.freedom) as freedom,
        AVG(h.`trust(governmentCorruption)`) as trust,
        AVG(h.generosity) as generosity
FROM happiness h
GROUP BY country
ORDER BY 2 DESC;     

-- Integrar todas las tablas
-- Una vez que se integren todas las tablas en una, las exportaremos y continuaremos trabajando en Machine Learning y Visualización

SELECT 	ha.*, 
		ia.regionValue, 
		ia.incomeValue,
        pa.population
FROM
	(SELECT h.country,
			h.happinessScore as score,
			h.`economy(gdpPerCapita)` as gdpPerCapita ,
			h.`health(lifeExpectancy)` as lifeExpectancy ,
			h.freedom,
			h.`trust(governmentCorruption)` as trust,
			h.generosity,
			a.año as `year`,
            h.idIncome,
            h.idPopulation
	FROM happiness h
	JOIN año a ON (a.idAño = h.idAño)
	ORDER BY 1) ha
JOIN   
(SELECT	country,
		regionValue,
        incomeValue,
        idIncome
FROM income
ORDER BY 1) ia ON (ia.idIncome = ha.idIncome)
JOIN 
 (SELECT p.country,
		p.population,
        a.año as `year`,
        p.idPopulation
FROM population p
JOIN año a ON (a.idAño = p.idAño)
ORDER BY 1 ) pa ON (pa.idPopulation = ha.idPopulation);





