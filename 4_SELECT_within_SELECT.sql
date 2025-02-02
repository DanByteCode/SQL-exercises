-- SITE: https://sqlzoo.net/wiki/SELECT_within_SELECT_Tutorial

-- 1. List each country name where the population is larger than that of 'Russia'.
SELECT name FROM world
WHERE population > (
  SELECT population
  FROM world
  WHERE name='Russia'
)

-- 2. Show the countries in Europe with a per capita GDP greater than 'United Kingdom'.
SELECT name FROM world
WHERE continent = 'Europe'
AND gdp/population > (
  SELECT gdp/population
  FROM world
  WHERE name='United Kingdom'
)

-- 3. List the name and continent of countries in the continents containing either Argentina or Australia. Order by name of the country.
SELECT name, continent
FROM world
WHERE continent IN (
  SELECT continent
  FROM world
  WHERE name IN ('Argentina', 'Australia')
)

-- 4. Which country has a population that is more than United Kingdom but less than Germany? Show the name and the population.
SELECT name, population
FROM world
WHERE population > (
  SELECT population
  FROM world
  WHERE name = 'United Kingdom'
) and population < (
  SELECT population
  FROM world
  WHERE name = 'Germany'
)

-- 5. Show the name and the population of each country in Europe. Show the population as a percentage of the population of Germany.
SELECT name,
CONCAT(
ROUND(population/(
  SELECT population
  FROM world
  WHERE name = 'Germany'
) * 100), '%')
FROM world
WHERE continent = 'Europe'

-- 6. Which countries have a GDP greater than every country in Europe?
SELECT name
FROM world
WHERE gdp > (
  SELECT MAX(gdp)
  FROM world
  WHERE continent = 'Europe' AND gdp > 0
)

-- 7. Find the largest country (by area) in each continent, show the continent, the name and the area.
SELECT continent, name, area
FROM world x
WHERE area >= ALL(
  SELECT area
  FROM world y
  WHERE y.continent=x.continent
  AND area > 0
)

-- 8. Find the continents where all countries have a population <= 25000000. Then find the names of the countries associated with these continents. Show name, continent and population.
SELECT name, continent, population
FROM world x
WHERE 25000000 >= ALL (
  SELECT population FROM world y
  WHERE x.continent = y.continent AND y.population > 0
)

-- 9. Some countries have populations more than three times that of all of their neighbours (in the same continent). Give the countries and continents.
SELECT name, continent
FROM world x
WHERE population*3 > (
  SELECT MAX(population)
  FROM world y
  WHERE x.continent = y.continent
  AND x.name <> y.name
)

-- QUIZ: https://sqlzoo.net/wiki/Nested_SELECT_Quiz