-- Data cleaning project


DROP TABLE IF EXISTS layoffs;
CREATE TABLE layoffs(
	company VARCHAR(100),
	location VARCHAR(100),
	industry VARCHAR(100),
	total_laid_off INT,
	percentage_laid_off NUMERIC(5,2),
	date VARCHAR(20),
	stage VARCHAR(50),
	country VARCHAR(100),
	funds_raised_millions NUMERIC(10,2)
);

SELECT * FROM layoffs;


-- 1. Remove Duplicates
-- 2. Standardize the data
-- 3. Null values or Blank values
-- 4. Remove unwanted column/records


-- create a working copy
CREATE TABLE layoffs_staging AS
SELECT * FROM layoffs;



SELECT *,
ROW_NUMBER() OVER(PARTITION BY country,company,industry, total_laid_off, "date") AS row_num
FROM layoffs_staging;

-- Identifying duplicates
WITH duplicate_rows
AS
(
SELECT *,
	ROW_NUMBER() OVER(
		PARTITION BY 
			country,
			location,
			stage,
			percentage_laid_off,
			industry,
			company,
			industry, 
			total_laid_off,
			funds_raised_millions, 
			"date") 
		AS row_num
FROM layoffs_staging
)
SELECT * 
FROM duplicate_rows
WHERE row_num > 1;

SELECT * FROM layoffs_staging
WHERE company='Casper'

SELECT 
	ctid,
	country,
	ROW_NUMBER() OVER(PARTITION BY company ORDER BY ctid) AS row_num
FROM layoffs_staging

	
-- Removing copy of duplicates
DELETE FROM layoffs_staging
WHERE ctid IN (
    SELECT ctid
    FROM (
        SELECT
            ctid,
            ROW_NUMBER() OVER (
                PARTITION BY
                    company,
                    location,
                    industry,
                    total_laid_off,
                    percentage_laid_off,
                    "date",
                    stage,
                    country,
                    funds_raised_millions
                ORDER BY ctid
            ) AS row_num
        FROM layoffs_staging
    ) t
    WHERE row_num > 1
);

-- Standrdizing data
SELECT DISTINCT company
FROM layoffs_staging
	ORDER BY company;
	
--removing white space	-- 
SELECT company, TRIM(company)
FROM layoffs_staging

-- update after removing white space
UPDATE layoffs_staging
SET company=TRIM(company);

SELECT *
FROM layoffs_staging
WHERE industry LIKE 'Crypto%';

UPDATE layoffs_staging
SET industry='Crypto'
WHERE industry LIKE 'Crypto%';

SELECT DISTINCT country 
FROM layoffs_staging
ORDER BY 1; 

UPDATE layoffs_staging
SET country='United States'
WHERE country LIKE 'United States%';

-- date
SELECT *
FROM layoffs_staging;

-- change date format
UPDATE layoffs_staging
SET date=TO_DATE(date, 'MM-DD-YYYY');


-- change the date column to DATE
ALTER TABLE layoffs_staging
ALTER COLUMN date TYPE DATE
USING date::DATE;

-- Handling NULL values
SELECT *
FROM layoffs_staging
 WHERE total_laid_off IS NULL
 	AND percentage_laid_off IS NULL;

SELECT * 
FROM layoffs_staging
	WHERE industry ISNULL
	OR industry = ''

SELECT * FROM layoffs_staging
WHERE company LIKE 'Ball%'


UPDATE layoffs_staging
SET industry='Travel'
	WHERE company='Airbnb'

UPDATE layoffs_staging
SET industry='Transportation'
	WHERE company='Carvana'

UPDATE layoffs_staging
SET industry='Consumer'
	WHERE company='Juul'

DELETE 
FROM layoffs_staging
 WHERE total_laid_off IS NULL
 	AND percentage_laid_off IS NULL;
