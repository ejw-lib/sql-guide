   
/* 
Traditional way with manual input
*/
WITH keyData AS
	(
	Select g.EnglishCountryRegionName, c.CustomerKey, c.CommuteDistance
	From dbo.DimCustomer c
	Inner Join dbo.DimGeography g
	On c.GeographyKey = g.GeographyKey
)
SELECT *
FROM (
Select k.EnglishCountryRegionName, k.CommuteDistance, k.CustomerKey  
From keyData k
) as temp
PIVOT
(
	count(CustomerKey)
	For EnglishCountryRegionName IN 
		("Australia", 
		"Canada", 
		"France", 
		"Germany",  
		"United Kingdom",
		"United States")
) as t
Order by Canada DESC;


/* 
Traditional way with dynamic input
*/
IF OBJECT_ID('tempdb..#keyData') IS NOT NULL
DROP TABLE #keyData

Select EnglishCountryRegionName, CommuteDistance, CustomerKey
INTO #keyData
From dbo.DimCustomer c
	Inner Join dbo.DimGeography g
	On c.GeographyKey = g.GeographyKey;

-- Select * From #keyData




DECLARE @cols AS NVARCHAR(MAX),
    @query  AS NVARCHAR(MAX)

select @cols = STUFF(
						(
							SELECT ',' + QUOTENAME(EnglishCountryRegionName) 
							from #keyData
							group by EnglishCountryRegionName
							order by EnglishCountryRegionName
							FOR XML PATH(''), TYPE
						).value('.', 'NVARCHAR(MAX)') 
					,1,1,'')

set @query = 'SELECT CommuteDistance,' + @cols + ' FROM 
             (
                SELECT EnglishCountryRegionName, CommuteDistance, CustomerKey
                FROM #keyData
            ) x
            PIVOT 
            (
                count(CustomerKey)
                FOR EnglishCountryRegionName IN (' + @cols + ')
            ) p '

execute(@query);


-- Combined Method
DECLARE @DynamicPivotQuery AS NVARCHAR(MAX)
DECLARE @ColumnName AS NVARCHAR(MAX)

--Get distinct values of the PIVOT Column 
SELECT @ColumnName= ISNULL(@ColumnName + ',','') + QUOTENAME(EnglishCountryRegionName)
FROM (SELECT DISTINCT EnglishCountryRegionName FROM #keyData) AS Countries

--Prepare the PIVOT query using the dynamic 
SET @DynamicPivotQuery = 
  N'SELECT CommuteDistance, ' + @ColumnName + ' 
    FROM #keyData
    PIVOT(Count(CustomerKey) 
          FOR EnglishCountryRegionName IN (' + @ColumnName + ')) AS PVTTable'
--Execute the Dynamic Pivot Query
EXEC sp_executesql @DynamicPivotQuery


--Other
SELECT CommuteDistance, 
    Count(CASE when EnglishCountryRegionName = 'Germany' then CommuteDistance end) [Germany],
	Count(CASE when EnglishCountryRegionName = 'United States' then CommuteDistance end) [United States],
	Count(CASE when EnglishCountryRegionName = 'Australia' then CommuteDistance end) [Australia],
	Count(CASE when EnglishCountryRegionName = 'United Kingdom' then CommuteDistance end) [United Kingdom],
	Count(CASE when EnglishCountryRegionName = 'Canada' then CommuteDistance end) [Canada],
	Count(CASE when EnglishCountryRegionName = 'France' then CommuteDistance end) [France]
FROM #keyData
GROUP BY CommuteDistance
ORDER BY CommuteDistance;



