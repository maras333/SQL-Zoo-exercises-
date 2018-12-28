-- Structure of DB
-- table_name: world
-- table fields: name VARCHAR	continent VARCHAR	area INT	population INT	gdp INT

-- 1. Show the total population of the world.
SELECT SUM(population)
FROM world

-- 2. List all the continents - just once each.
SELECT continent
FROM world
GROUP BY continent

-- 3. Give the total GDP of Africa.
SELECT SUM(gdp) as gdp
FROM world
WHERE continent = 'Africa'

-- 4. How many countries have an area of at least 1000000.
SELECT COUNT(area)
FROM world
WHERE area > 1000000

-- 5. What is the total population of ('Estonia', 'Latvia', 'Lithuania')
SELECT SUM(population) as population
FROM  world
WHERE name = 'Estonia' OR name = 'Latvia' OR name = 'Lithuania'

-- 6. For each continent show the continent and number of countries.
SELECT w.continent, COUNT(*) as Nr_countries
FROM world w
GROUP BY w.continent

-- 7. For each continent show the continent and number of countries with populations of at least 10 million.
SELECT w.continent, COUNT(*) as Nr_countries
FROM world w
WHERE w.population >= 10000000
GROUP BY w.continent

-- 8. List the continents that have a total population of at least 100 million.
SELECT w.continent
FROM world w
GROUP BY w.continent
HAVING SUM(w.population) >= 100000000
