-- DIFFICULT QUESTIONS --

-- 9. Find the continents where all countries have a population <= 25000000. Then find the names
-- of the countries associated with these continents. Show name, continent and population.
SELECT name, continent, population
FROM world x
WHERE 25000000>=ALL (
  SELECT population FROM world y
  WHERE x.continent=y.continent
  AND population>0)

-- 10. Some countries have populations more than three times that of any of their
-- neighbours (in the same continent). Give the countries and continents.
SELECT name, continent FROM world x
WHERE population > ALL (
  SELECT population*3 FROM world y
  WHERE x.continent=y.continent AND population>0 AND x.name !=y.name)
