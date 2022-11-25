WITH RECURSIVE p(last_arrival, hops, level) AS (
  SELECT airport_code,
         ARRAY[airport_code],
         1
  FROM   airports
  WHERE airport_code = 'UKX'
  UNION ALL
  SELECT r.arrival_airport,
         (p.hops || r.arrival_airport)::char(3)[],
         p.level + 1
  FROM   routes r, p
  WHERE  r.departure_airport = p.last_arrival
  AND    p.level < 3
)
SELECT * FROM p;