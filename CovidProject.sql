select * 
from project..CovidDeaths$
order by 3,4

select location,date, total_cases, new_cases, total_deaths, population
from project..CovidDeaths$
order by 1,2

--looking at total_cases VS total_deaths
--Shows likelyhood of dying if you contract covid in your country
select location,date, total_cases, total_deaths, (total_deaths/total_cases)*100 as Death_Precentage
from project..CovidDeaths$
where location like '%states%'
order by 1,2

--looking at total cases VS population
-- show what precentage of population got covid
select location, date, total_cases,population, (total_cases/population)*100 as Infection_Rate
from project..CovidDeaths$
where location like '%states%'
order by 1,2

--Looking for countries with high infection Rate compared to Population
select location, max(total_cases) as HighestInfectionCount, population, (max(total_cases)/population)*100 as PrecentagePopulationInfected
from project..CovidDeaths$
--where location like '%Egypt%'
Group by population,location
order by PrecentagePopulationInfected desc

--looking for countries with highest Death count to population
select location, max(cast(total_deaths as int))as HighestDeathCount
from project..CovidDeaths$
where continent is not null
Group by location
order by HighestDeathCount desc

--Lets breaking Things down into continent 
select continent,  max(cast(total_deaths as int))as HighestDeathCount
from project..CovidDeaths$
where continent is not null
Group by continent
order by HighestDeathCount desc

--Lets breaking Things down into continent 
-- showing continent with highest death count
select location,  max(cast(total_deaths as int))as HighestDeathCount
from project..CovidDeaths$
where continent is  null
Group by location
order by HighestDeathCount desc

-- Global Numbers
select date,sum(new_cases)  as total_cases, sum(cast(new_deaths as int)) as total_deaths, sum(cast(new_deaths as int))/sum(new_cases)*100 as DeathPrecentage
from project..CovidDeaths$
--where location like '%states%'
where continent is not null
group by date
order by 1,2

-- total numbers 
select  sum(new_cases)  as total_cases, sum(cast(new_deaths as int)) as total_deaths, sum(cast(new_deaths as int))/sum(new_cases)*100 as DeathPrecentage
from project..CovidDeaths$
--where location like '%states%'
where continent is not null
order by 1,2

--Looking at total population VS vaccinations
select dea.continent, dea.location, dea.date, dea.population, vac.new_vaccinations
,sum(convert(int,vac.new_vaccinations)) OVER  (partition by dea.location order by dea.location,
dea.date)
from project..CovidDeaths$ dea
join project..CovidVaccinations vac
on dea.location=vac.location
and dea.date=vac.date
where dea.continent is not null
order by 2,3

-- USE CTE
with PopVsVac(continent, location,date,population,new_vaccinations, RollingPeopleVaccinated)
as
(
select dea.continent, dea.location, dea.date, dea.population, vac.new_vaccinations
,sum(convert(int,vac.new_vaccinations)) OVER  (partition by dea.location order by dea.location,
dea.date) as RollingPeopleVaccinated
from project..CovidDeaths$ dea
join project..CovidVaccinations vac
on dea.location=vac.location
and dea.date=vac.date
where dea.continent is not null
)
select *,(RollingPeopleVaccinated/population)*100 
from PopVsVac
