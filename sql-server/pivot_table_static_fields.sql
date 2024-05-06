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
	For EnglishCountryRegionName IN ('Australia', 'Canada', 'France', 'Germany', 'United States', 'United Kingdom'
		) as t



