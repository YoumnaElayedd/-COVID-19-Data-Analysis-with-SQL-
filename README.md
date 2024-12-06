# COVID-19 Data Analysis with SQL

## Description
This project analyzes global COVID-19 data to uncover insights about infection rates, death percentages, and vaccination progress. Using SQL, the dataset is explored to answer key questions about the impact of COVID-19 across countries and continents. The analysis also includes global and regional trends.

## Key Objectives
- Calculate infection and death rates to understand the impact of COVID-19.
- Identify countries with the highest infection and death counts relative to their population.
- Compare vaccination progress across countries and continents.
- Use SQL techniques such as aggregation, window functions, and CTEs for advanced analysis.

## Tools Used
- **SQL Server**
- **COVID-19 Datasets**: 
  - `CovidDeaths$`
  - `CovidVaccinations`

## Key Queries and Insights
1. **Total Cases and Deaths Overview**
   - Analyzes total cases, deaths, and infection rates by location and date.

2. **Death Percentage Analysis**
   - Shows the likelihood of dying if infected with COVID-19 in different countries.

3. **Population vs. Infection Rate**
   - Calculates the percentage of the population infected in each country.

4. **Countries with High Infection and Death Counts**
   - Highlights countries and continents with the highest infection and death rates.

5. **Vaccination Progress**
   - Compares total population to vaccination counts using cumulative sums and rolling metrics.

6. **Global Trends**
   - Summarizes global trends in new cases, deaths, and death percentages over time.

## Advanced Techniques
- **Joins**: Combined COVID deaths and vaccination datasets.
- **Window Functions**: Used for rolling sums and cumulative calculations.
- **CTEs (Common Table Expressions)**: Simplified queries for population and vaccination analysis.
- **Aggregation Functions**: Summarized data by country, continent, and globally.

## Example Queries
### Infection Rate Calculation
```sql
select location, date, total_cases, population, 
       (total_cases / population) * 100 as Infection_Rate
from project..CovidDeaths$
where location like '%states%'
order by 1, 2;

How to Use
Clone the repository.
Import the dataset into your SQL Server.
Run the SQL scripts provided to generate insights.
Dataset
The project uses publicly available COVID-19 datasets:

CovidDeaths$: Contains data on COVID-19 cases, deaths, and population.
CovidVaccinations: Tracks vaccination data globally.
Future Improvements
Add visualizations using Power BI or Tableau for better interpretation.
Include predictive analysis using machine learning.
