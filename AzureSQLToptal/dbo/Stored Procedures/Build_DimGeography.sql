CREATE PROCEDURE [dbo].[Build_DimGeography]
AS
BEGIN
	SET NOCOUNT ON;		

	


	IF OBJECT_ID('DimGeography') IS NOT NULL
		DROP TABLE DimGeography

	CREATE TABLE DimGeography (
		 GeographyID [int] identity(1, 1) PRIMARY KEY
		,Country NVARCHAR(100)
		,Region NVARCHAR(100)
		)

	--Get the data from Source table
	INSERT INTO DimGeography (Country, Region)
	SELECT DISTINCT Country, Region
	FROM [staging].[Source_Geography]

	
	
	SET NOCOUNT OFF;
END