-- SITE: https://sqlzoo.net/wiki/More_JOIN_operations

-- 1. List the films where the yr is 1962 [Show id, title]
SELECT id, title
FROM movie
WHERE yr=1962

-- 2. Give year of 'Citizen Kane'.
SELECT yr
FROM movie
WHERE title = 'Citizen Kane'

-- 3. List all of the Star Trek movies, include the id, title and yr. Order results by year.
SELECT id, title, yr
FROM movie
WHERE title LIKE '%Star Trek%'
ORDER BY yr

-- 4. What id number does the actor 'Glenn Close' have?
SELECT id
FROM actor
WHERE name = 'Glenn Close'

-- 5. What is the id of the film 'Casablanca'
SELECT id
FROM movie
WHERE title = 'Casablanca'

-- 6. Obtain the cast list for 'Casablanca'.
SELECT name
FROM actor JOIN casting ON id = actorid
WHERE movieid = (
  SELECT id
  FROM movie
  WHERE title = 'Casablanca'
)

-- 7. Obtain the cast list for the film 'Alien'
SELECT name
FROM actor JOIN casting ON id = actorid
WHERE movieid = (
  SELECT id
  FROM movie
  WHERE title = 'Alien'
)

-- 8. List the films in which 'Harrison Ford' has appeared
SELECT title
FROM casting JOIN movie ON id = movieid
WHERE actorid = (
  SELECT id
  FROM actor
  WHERE name = 'Harrison Ford'
)

-- 9. List the films where 'Harrison Ford' has appeared - but not in the starring role.
SELECT title
FROM casting JOIN movie ON id = movieid
WHERE ord > 1
AND actorid = (
  SELECT id
  FROM actor
  WHERE name = 'Harrison Ford'
)

-- 10. List the films together with the leading star for all 1962 films.
SELECT title, name
FROM casting
  JOIN actor ON actor.id = actorid
  JOIN movie ON movie.id = movieid 
AND (movie.yr = 1962 && ord = 1)

/* HARDER QUESTIONS */
-- 11. Which were the busiest years for 'Rock Hudson', show the year and the number of movies he made each year for any year in which he made more than 2 movies.
SELECT yr,COUNT(title) FROM movie 
  JOIN casting ON movie.id=movieid
  JOIN actor   ON actorid=actor.id
WHERE name='Rock Hudson'
GROUP BY yr
HAVING COUNT(title) > 2

-- 12. List the film title and the leading actor for all of the films 'Julie Andrews' played in.
SELECT title, name
FROM movie 
  JOIN casting ON (movie.id = movieid AND ord = 1)
  JOIN actor ON actor.id = actorid
WHERE movie.id IN (
  SELECT movieid
  FROM casting
  WHERE actorid IN (
    SELECT id
    FROM actor
    WHERE name = 'Julie Andrews'
  )
)

-- 13. Obtain a list, in alphabetical order, of actors who've had at least 15 starring roles.
SELECT name
FROM actor JOIN casting ON actor.id = actorid
WHERE ord = 1
GROUP BY id
HAVING COUNT(actorid) >= 15
ORDER BY name

-- 14. List the films released in the year 1978 ordered by the number of actors in the cast, then by title.
SELECT title, COUNT(actorid)
FROM movie JOIN casting ON movie.id = movieid
WHERE yr = 1978
GROUP BY movieid
ORDER BY COUNT(actorid) DESC, title

-- 15. List all the people who have worked with 'Art Garfunkel'.
SELECT name
FROM casting JOIN actor ON actorid = actor.id
WHERE movieid IN (
  SELECT movieid
  FROM casting 
  WHERE name <> 'Art Garfunkel'
  AND actorid = 
  (
    SELECT id
    FROM actor
    WHERE name = 'Art Garfunkel'
  )
)

-- QUIZ: https://sqlzoo.net/wiki/JOIN_Quiz_2