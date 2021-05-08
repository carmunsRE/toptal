CREATE PROCEDURE [dbo].[Build_DimReseller]
AS
BEGIN
	SET NOCOUNT ON;		

	


	IF OBJECT_ID('DimReseller') IS NOT NULL
		DROP TABLE DimReseller

	CREATE TABLE DimReseller (
		 ResellerID [int] identity(1, 1) PRIMARY KEY
		,Reseller NVARCHAR(100)
		,Comission float
		)

	--Get the data from Source table
	INSERT INTO DimReseller (Reseller, Comission)
	SELECT DISTINCT Reseller, Comission = cast((RAND(CHECKSUM(NEWID()))*(0.09-0.02)+0.02) as decimal(3,2))
	FROM [staging].[Source_Reseller]

	
	
	SET NOCOUNT OFF;
END