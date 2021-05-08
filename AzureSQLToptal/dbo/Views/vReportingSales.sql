

CREATE VIEW [dbo].[vReportingSales] AS 
  SELECT Reseller
	,Channel
	,Category
	,SubCategory
	,Country
	,Region
	,[PurchasedDate]
	,PurchasedTickets
	,TotalAmount
  from [dbo].[FactSales] fs 
		JOIN [dbo].[DimReseller] r on fs.ResellerID = r.ResellerID
		JOIN [dbo].[DimChannel] ch on fs.ChannelID = ch.ChannelID
		JOIN [dbo].[DimCategory] c on fs.CategoryID = c.CategoryID
		JOIN [dbo].[DimGeography] g on fs.GeographyID = g.GeographyID