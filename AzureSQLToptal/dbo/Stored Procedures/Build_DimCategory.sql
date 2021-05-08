CREATE PROCEDURE [dbo].[Build_DimCategory]
AS
BEGIN
	SET NOCOUNT ON;		

	


	IF OBJECT_ID('DimCategory') IS NOT NULL
		DROP TABLE DimCategory

	CREATE TABLE DimCategory (
		 CategoryID [int] identity(1, 1) PRIMARY KEY
		,Category NVARCHAR(100)
		,SubCategory NVARCHAR(100)
		)

	--Get the data from Source table
	INSERT INTO DimCategory (Category, SubCategory)
	SELECT DISTINCT Category, SubCategory
	FROM [staging].[Source_EventCategory]

	
	
	SET NOCOUNT OFF;
END