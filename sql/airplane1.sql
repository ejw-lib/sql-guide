WITH RECURSIVE p(last_arrival, destination, hops, flights, found) AS (
  SELECT a_from.airport_code,
         a_to.airport_code,
         ARRAY[a_from.airport_code],
         ARRAY[]::char(6)[],
         a_from.airport_code = a_to.airport_code
  FROM   airports a_from, airports a_to
  WHERE  a_from.airport_code = 'UKX'
  AND    a_to.airport_code = 'CNN'
  UNION ALL
  SELECT r.arrival_airport,
         p.destination,
         (p.hops || r.arrival_airport)::char(3)[],
         (p.flights || r.flight_no)::char(6)[],
         bool_or(r.arrival_airport = p.destination) OVER ()
  FROM   routes r, p
  WHERE  r.departure_airport = p.last_arrival
  AND    NOT r.arrival_airport = ANY(p.hops)
  AND    NOT p.found
)
SELECT hops,
       flights
FROM   p
WHERE  p.last_arrival = p.destination;