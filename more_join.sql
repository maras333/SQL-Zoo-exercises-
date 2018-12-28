-- HARDER QUESTIONS --

-- 11. Which were the busiest years for 'John Travolta', show the year and the number of
-- movies he made each year for any year in which he made more than 2 movies.
SELECT yr,COUNT(title)
FROM movie
JOIN casting ON movie.id=movieid
JOIN actor ON actorid=actor.id
WHERE name='John Travolta'
GROUP BY yr
HAVING COUNT(title)=(SELECT MAX(c) FROM
  (SELECT yr,COUNT(title) AS c
  FROM movie
  JOIN casting ON movie.id=movieid
  JOIN actor ON actorid=actor.id
  WHERE name='John Travolta'
  GROUP BY yr) AS t
  )

-- 12. List the film title and the leading actor for all of the films 'Julie Andrews' played in.
SELECT m.title as title, a.name as name FROM movie m
JOIN casting c ON m.id = c.movieid
JOIN actor a ON c.actorid = a.id
WHERE m.id IN
  (SELECT m.id as movie_id FROM movie m
  JOIN casting c ON m.id = c.movieid
  JOIN actor a ON c.actorid = a.id
  WHERE a.name = 'Julie Andrews')
AND c.ord = 1;

-- 13. Obtain a list, in alphabetical order, of actors who've had at least 30 starring roles.
SELECT a.name as name FROM actor a
               JOIN casting c ON a.id = c.actorid
               WHERE c.ord = 1
               GROUP BY a.name
               HAVING SUM(c.ord) >= 30
ORDER BY a.name ASC;

-- 14. List the films released in the year 1978 ordered by the number of actors in the cast, then by title.
SELECT t.title as title, cast FROM (
  SELECT m.title, COUNT(c.actorid) as cast FROM movie m
  JOIN casting c ON m.id = c.movieid
  WHERE m.yr = 1978
  GROUP BY m.title
) as t
ORDER BY cast DESC, title ASC;

-- 15. List all the people who have worked with 'Art Garfunkel'.
SELECT a.name FROM actor a
JOIN casting c ON a.id = c.actorid
WHERE c.movieid IN (
  SELECT c.movieid FROM movie m
  JOIN casting c ON m.id = c.movieid
  JOIN actor a ON c.actorid = a.id
  WHERE a.name = 'Art Garfunkel'
)
AND a.name != 'Art Garfunkel';
