CREATE TABLE generic1(
	col1 varchar,
	col2 varchar,
	col3 varchar
);

CREATE TABLE generic2(
	col1 varchar,
	col2 varchar,
	col3 varchar
);

INSERT INTO generic1
VALUES ('t','s', 's'),
		('t','d', 's'),
		('t','d', 'd');

INSERT INTO generic2
VALUES ('t','s', 's'),
		('t','d', 's'),
		('t','d', 'd');

Select *
From generic1 g1
JOIN generic2 g2
ON g1.col1 = g1.col1;