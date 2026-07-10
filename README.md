# SQL Data Cleaning Project – Employee Layoffs Dataset

## Project Overview

This project demonstrates the data cleaning process using PostgreSQL on a real-world employee layoffs dataset. The objective is to transform raw, inconsistent data into a clean and reliable dataset ready for exploratory data analysis (EDA) and reporting.

## Dataset

The dataset contains information about employee layoffs from various companies around the world, including:

- Company
- Location
- Industry
- Total Employees Laid Off
- Percentage Laid Off
- Date
- Company Stage
- Country
- Funds Raised (Millions)

## Data Cleaning Process

The following data cleaning tasks were performed:

### 1. Removing Duplicate Records

- Identified duplicate records using `ROW_NUMBER()` and window functions.
- Removed duplicate rows while preserving one valid record for each duplicate group.

### 2. Trimming Extra Spaces

- Removed leading and trailing whitespace using the `TRIM()` function.
- Standardized text values to eliminate inconsistencies caused by accidental spaces.

### 3. Standardizing Data

- Standardized company names, industries, countries, and other text fields to ensure consistency.
- Corrected inconsistent formatting and naming conventions across the dataset.

### 4. Handling Missing Values

- Identified `NULL` values across relevant columns.
- Cleaned or updated missing values where appropriate while preserving data integrity.

### 5. Converting Data Types

- Converted columns to appropriate PostgreSQL data types.
- Transformed date values into the `DATE` data type for easier filtering and analysis.
- Ensured numeric columns used suitable numeric data types.

## SQL Concepts Practiced

Throughout this project, the following PostgreSQL concepts were applied:

- Window Functions (`ROW_NUMBER()`)
- `TRIM()`
- `UPDATE`
- `ALTER TABLE`
- `DELETE`
- `WHERE`
- `GROUP BY`
- `ORDER BY`
- Data Type Conversion
- Duplicate Detection
- NULL Handling

## Outcome

The final dataset is clean, standardized, and analysis-ready, providing a reliable foundation for exploratory data analysis (EDA), reporting, and visualization.

---

**Tools Used**

- PostgreSQL
- pgAdmin 4
- SQL
- Git & GitHub
