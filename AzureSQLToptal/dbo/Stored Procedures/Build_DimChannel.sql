CREATE PROCEDURE [dbo].[Build_DimChannel]
AS
BEGIN
	SET NOCOUNT ON;		

	


	IF OBJECT_ID('DimChannel') IS NOT NULL
		DROP TABLE DimChannel

	CREATE TABLE DimChannel (
		 ChannelID [int] identity(1, 1) PRIMARY KEY
		,Channel NVARCHAR(100)
		)

	--Get the data from Source table
	INSERT INTO DimChannel (Channel)
	SELECT DISTINCT SalesChannel
	FROM [staging].[Source_SalesChannel]

	
	
	SET NOCOUNT OFF;
END