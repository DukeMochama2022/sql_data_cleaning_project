-- Exploratory Data analysis
SELECT * FROM layoffs_staging;

-- Total layoffs
SELECT MAX(total_laid_off), MAX(percentage_laid_off)
FROM layoffs_staging;


SELECT * 
FROM layoffs_staging
	WHERE percentage_laid_off=1
	ORDER BY total_laid_off DESC;

-- total layoffs per company
SELECT company, SUM(total_laid_off)
FROM layoffs_staging
	GROUP BY company
	ORDER BY 2 DESC;

-- industry hit of by the layoffs
SELECT industry, SUM(total_laid_off)
FROM layoffs_staging
	GROUP BY industry
	ORDER BY 2 DESC;

-- layoffs per date / year
SELECT MIN(date), MAX(date)
FROM layoffs_staging;

SELECT EXTRACT(YEAR FROM date), SUM(total_laid_off)
FROM layoffs_staging
	GROUP BY EXTRACT(YEAR FROM date)
	ORDER BY 1 DESC;


-- total layoffs per country
SELECT country, SUM(total_laid_off)
FROM layoffs_staging
	GROUP BY country
	ORDER BY 2 DESC;


SELECT TO_CHAR(date,'YYYY_MM') AS month, SUM(total_laid_off)
FROM layoffs_staging
	WHERE TO_CHAR(date,'YYYY_MM') IS NOT NULL
	GROUP BY TO_CHAR(date,'YYYY_MM')
	ORDER BY 1 DESC;


-- Rolling total

WITH monthly_layoffs AS
(
	SELECT TO_CHAR(date,'YYYY-MM') AS month, SUM(total_laid_off) AS total_layoffs
	FROM layoffs_staging
		WHERE date IS NOT NULL
		GROUP BY TO_CHAR(date,'YYYY-MM') 
		ORDER BY month
)
SELECT month, total_layoffs,
	SUM(total_layoffs) OVER (ORDER BY month) AS cumulative_layoffs
FROM monthly_layoffs;


SELECT 
	company,
	EXTRACT(YEAR FROM date)AS year, 
	SUM(total_laid_off)
FROM layoffs_staging
	GROUP BY company, year
	ORDER BY 3 DESC;


WITH company_year(company, year, total_laid_off) AS
(
	SELECT 
		company,
		EXTRACT(YEAR FROM date)AS year, 
		SUM(total_laid_off)
	FROM layoffs_staging
		GROUP BY company, year
), company_ranks AS
(
SELECT *,
	DENSE_RANK() OVER(PARTITION BY year ORDER BY total_laid_off DESC NULLS LAST) AS Ranking
FROM company_year
WHERE year IS NOT NULL
)
SELECT *
FROM company_ranks
WHERE ranking <=5;






	
