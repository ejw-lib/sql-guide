IF OBJECT_ID('tempdb..#temp') IS NOT NULL DROP TABLE #temp;


CREATE TABLE #temp (
name1 varchar(20),
school varchar(20),
class varchar(20),
sesssion1 varchar(20),
studentCount integer
);

INSERT INTO #temp
VALUES ('george','nhs', 'algebra1','001', 20),
('clarence', 'nhs', 'algebra1','001', 20),
('jennifer', 'nhs', 'english10','002', 35),
('joe', 'nhs', 'algebra1','003',35),
('mary', 'chs', 'english10','004', 33),
('james', 'chs', 'english10','004', 33);

Select * From #temp;

DECLARE @text NVARCHAR(60)


Select MIN(t1.name1 + '  -  ' + t2.name1) as Teacher1,
		--t2.name1 as Teacher2,
		MIN(t1.school),
		MIN(t1.class),
		MIN(t1.sesssion1),
		MIN(t1.studentCount)
From #temp t1
INNER JOIN #temp t2
ON t1.school = t2.school
AND t1.class = t2.class
AND t1.sesssion1 = t2.sesssion1
AND t1.name1 <> t2.name1
GROUP BY t1.school, t1.class, t1.sesssion1;
