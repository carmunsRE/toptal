CREATE PROCEDURE [dbo].[Build_FactSales]
AS
BEGIN
	SET NOCOUNT ON;		

	


	IF OBJECT_ID('FactSales') IS NOT NULL
		DROP TABLE FactSales

	CREATE TABLE FactSales (
		 ID [int] identity(1, 1) PRIMARY KEY
		,ResellerID INT REFERENCES [dbo].[DimReseller](ResellerID)
		,ChannelID INT REFERENCES [dbo].[DimChannel](ChannelID)
		,CategoryID INT REFERENCES [dbo].[DimCategory](CategoryID)
		,GeographyID INT REFERENCES [dbo].[DimGeography](GeographyID)
		,PurchasedDate INT REFERENCES [dbo].[DimDate](DateKey)
		,PurchasedTickets INT
		,TotalAmount MONEY
		)

	INSERT INTO FactSales
	SELECT ResellerID
		  ,ChannelID
		  ,CategoryID
		  ,GeographyID
		  ,PurchasedDate = CAST(REPLACE(fs.PurchasedDate,'-','') AS INT) 
		  ,PurchasedTickets
		  ,TotalAmount
	FROM [staging].[Source_FactSales] fs 
		JOIN [dbo].[DimReseller] r on fs.Reseller = r.Reseller
		JOIN [dbo].[DimChannel] ch on fs.SalesChannel = ch.Channel
		JOIN [dbo].[DimCategory] c on fs.Category = c.Category and fs.SubCategory = c.SubCategory
		JOIN [dbo].[DimGeography] g on fs.Region = g.Region

	
	SET NOCOUNT OFF;
END