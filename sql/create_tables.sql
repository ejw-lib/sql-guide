CREATE TABLE employees (
id serial primary key,
first_name varchar(32),
last_name varchar(32),
boss_id integer
)

CREATE TABLE investments (
id serial primary key,
investment_amount real
)

CREATE TABLE city_route(
city_from varchar(32),
city_to varchar(32),
distance real
)