
CREATE PROCEDURE [staging].[Build_SourceTables]
AS
BEGIN
	SET NOCOUNT ON;		


	IF OBJECT_ID('staging.Source_Geography') IS NOT NULL
		DROP TABLE staging.Source_Geography

	CREATE TABLE staging.Source_Geography (
		Country NVARCHAR(100)
		,Region NVARCHAR(100)
		)

	IF OBJECT_ID('staging.Source_EventCategory') IS NOT NULL
		DROP TABLE staging.Source_EventCategory

	CREATE TABLE staging.Source_EventCategory (
		 Category NVARCHAR(100)
		,SubCategory NVARCHAR(100)
		)

	IF OBJECT_ID('staging.Source_Reseller') IS NOT NULL
		DROP TABLE staging.Source_Reseller

	CREATE TABLE staging.Source_Reseller (
		 Reseller NVARCHAR(100)
		)

	IF OBJECT_ID('staging.Source_SalesChannel') IS NOT NULL
		DROP TABLE staging.Source_SalesChannel

	CREATE TABLE staging.Source_SalesChannel (
		 SalesChannel NVARCHAR(100)
		)

	INSERT INTO staging.Source_SalesChannel (
		 SalesChannel
		)
	VALUES ('Office'),('Web'),('Mobile')  

	IF OBJECT_ID('staging.Source_FactSales') IS NOT NULL
		DROP TABLE staging.Source_FactSales

	CREATE TABLE staging.Source_FactSales (
		 Reseller NVARCHAR(100)
		,SalesChannel NVARCHAR(100)
		,Category NVARCHAR(100)
		,SubCategory NVARCHAR(100)
		,Country NVARCHAR(100)
		,Region NVARCHAR(100)
		,PurchasedDate [date]
		,PurchasedTickets [int]
		,TotalAmount [money]
		)

	
	SET NOCOUNT OFF;
END
GO
GRANT EXECUTE
    ON OBJECT::[staging].[Build_SourceTables] TO [adf_user]
    AS [dbo];

