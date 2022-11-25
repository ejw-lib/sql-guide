WITH RECURSIVE p(last_arrival, destination, hops, flights, level) AS (
  SELECT a_from.airport_code,
         a_to.airport_code,
         ARRAY[a_from.airport_code],
         ARRAY[]::char(6)[],
         1
  FROM   airports a_from, airports a_to
  WHERE  a_from.airport_code = 'UKX'
  AND    a_to.airport_code = 'CNN'
  UNION ALL
  SELECT r.arrival_airport,
         p.destination,
         (p.hops || r.arrival_airport)::char(3)[],
         (p.flights || r.flight_no)::char(6)[],
         p.level + 1
  FROM   routes r, p
  WHERE  r.departure_airport = p.hops[cardinality(p.hops)]
  AND    NOT r.arrival_airport = ANY(p.hops)
  AND    p.level < 3
)
SELECT * FROM p;