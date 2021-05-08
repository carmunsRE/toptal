
CREATE PROCEDURE [staging].[Build_SourceTables_withID]
AS
BEGIN
	SET NOCOUNT ON;		


	IF OBJECT_ID('staging.Source_Geography') IS NOT NULL
		DROP TABLE staging.Source_Geography

	CREATE TABLE staging.Source_Geography (
		 GeographyID [int]
		,Country NVARCHAR(100)
		,Region NVARCHAR(100)
		)

	IF OBJECT_ID('staging.Source_EventCategory') IS NOT NULL
		DROP TABLE staging.Source_EventCategory

	CREATE TABLE staging.Source_EventCategory (
		 EventCategoryID [int]
		,Category NVARCHAR(100)
		,SubCategory NVARCHAR(100)
		)

	IF OBJECT_ID('staging.Source_Reseller') IS NOT NULL
		DROP TABLE staging.Source_Reseller

	CREATE TABLE staging.Source_Reseller (
		 ResellerID [int]
		,Reseller NVARCHAR(100)
		)

	IF OBJECT_ID('staging.Source_SalesChannel') IS NOT NULL
		DROP TABLE staging.Source_SalesChannel

	CREATE TABLE staging.Source_SalesChannel (
		 SalesChannelID [int]
		,SalesChannel NVARCHAR(100)
		)

	INSERT INTO staging.Source_SalesChannel (
		 SalesChannelID
		,SalesChannel
		)
	VALUES (1,'Office'),(2,'Web'),(3,'Mobile')  

	IF OBJECT_ID('staging.Source_FactSales') IS NOT NULL
		DROP TABLE staging.Source_FactSales

	CREATE TABLE staging.Source_FactSales (
		 ResellerID [int]
		,SalesChannelID NVARCHAR(100)
		,EventCategoryID [int]
		,GeographyID [int]
		,PurchasedDate [date]
		,PurchasedTickets [int]
		,TotalAmount [money]
		)

	
	SET NOCOUNT OFF;
END