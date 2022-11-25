WITH RECURSIVE possible_route AS (
    SELECT  cr.city_to,
            cr.city_from || '->' ||cr.city_to AS route,
            cr.distance
      FROM city_route cr
      WHERE cr.city_from = 'Groningen'
 
UNION ALL
 
SELECT  cr.city_to,
            pr.route || '->' || cr.city_to AS route,
                CAST((pr.distance + cr.distance) AS DECIMAL(10, 2))
      FROM possible_route pr
INNER JOIN city_route cr
            ON cr.city_from = pr.city_to
)
 
SELECT  pr.route,
        pr.distance
FROM possible_route pr
WHERE pr.city_to = 'Haarlem'
ORDER BY pr.distance;