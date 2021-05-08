

-- Build_Taxonomy
CREATE PROCEDURE [dbo].[Build_Taxonomy]
AS
BEGIN
	SET NOCOUNT ON;

	BEGIN TRY -- Delete Facts and Dims.
		BEGIN TRAN

		BEGIN -- RECREATE LOG TABLE 
			IF OBJECT_ID('dbo.Log_Taxonomy') IS NOT NULL
				DROP TABLE Log_Taxonomy

			CREATE TABLE Log_Taxonomy (
				[ID] INT identity(1, 1)
				,[Status] [varchar](1000)
				,[Time] [varchar](50)
				,[Running Date] [date]
				,[Store Procedure] [varchar](100)
				)
		END

		BEGIN -- VARIABLES 
			DECLARE @TimeStamp VARCHAR(50)
			DECLARE @Message VARCHAR(500)
			DECLARE @Flag VARCHAR(5)
			DECLARE @Error INT
			DECLARE @Table VARCHAR(100)

			SET @Flag = 1;
		END

		--Drop old tables
		BEGIN --Facts
			SELECT @TimeStamp = CONVERT(VARCHAR(24), GETDATE(), 114)

			SELECT @Message = 'Starting to drop Facts ... %s'

			RAISERROR (
					@Message
					,10
					,1
					,@TimeStamp
					)
			WITH NOWAIT

			INSERT INTO Log_Taxonomy
			SELECT @Message
				,@TimeStamp
				,cast(getdate() AS DATE)
				,'[dbo].[Build_Taxonomy]'


			SET @Table = '... Deleting Table [FactSales]';

			IF EXISTS (
					SELECT 1
					FROM sys.objects
					WHERE object_id = OBJECT_ID(N'[dbo].[FactSales]')
						AND TYPE IN (N'U')
					)
				DROP TABLE [dbo].[FactSales]


			SELECT @TimeStamp = CONVERT(VARCHAR(24), GETDATE(), 114)

			SELECT @Message = 'All Facts dropped, dropping Dims ... %s'

			RAISERROR (
					@Message
					,10
					,1
					,@TimeStamp
					)
			WITH NOWAIT

			INSERT INTO Log_Taxonomy
			SELECT @Message
				,@TimeStamp
				,CAST(GETDATE() AS DATE)
				,'[dbo].[Build_Taxonomy]'
		END

		BEGIN --Dims

			SET @Table = '... Deleting Table [DimCategory]';

			IF EXISTS (
					SELECT 1
					FROM sys.objects
					WHERE object_id = OBJECT_ID(N'[dbo].[DimCategory]')
						AND TYPE IN (N'U')
					)
				DROP TABLE [dbo].[DimCategory]


			SET @Table = '... Deleting Table [DimGeography]';

			IF EXISTS (
					SELECT 1
					FROM sys.objects
					WHERE object_id = OBJECT_ID(N'[dbo].[DimGeography]')
						AND TYPE IN (N'U')
					)
				DROP TABLE [dbo].[DimGeography]

			SET @Table = '... Deleting Table [DimReseller]';

			IF EXISTS (
					SELECT 1
					FROM sys.objects
					WHERE object_id = OBJECT_ID(N'[dbo].[DimReseller]')
						AND TYPE IN (N'U')
					)
				DROP TABLE [dbo].[DimReseller]

			SET @Table = '... Deleting Table [DimChannel]';

			IF EXISTS (
					SELECT 1
					FROM sys.objects
					WHERE object_id = OBJECT_ID(N'[dbo].[DimChannel]')
						AND TYPE IN (N'U')
					)
				DROP TABLE [dbo].[DimChannel]
			

			-------------******* All Dims Dropped ************

			SELECT @Message = 'All Dims dropped ... %s'

			RAISERROR (
					@Message
					,10
					,1
					,@TimeStamp
					)
			WITH NOWAIT

			INSERT INTO Log_Taxonomy
			SELECT @Message
				,@TimeStamp
				,CAST(GETDATE() AS DATE)
				,'[dbo].[Build_Taxonomy]'
		END

		COMMIT TRAN
	END TRY

	BEGIN CATCH
		SET @Flag = 0;

		ROLLBACK TRAN

		SELECT @TimeStamp = CONVERT(VARCHAR(24), GETDATE(), 114)

		SELECT @Message = ' Taxonomy has finished whit errors (Roll Back Done)... Error at' + @Table

		RAISERROR (
				@Message
				,10
				,1
				,@TimeStamp
				)
		WITH NOWAIT

		INSERT INTO Log_Taxonomy
		SELECT @Message
			,@TimeStamp
			,CAST(GETDATE() AS DATE)
			,'[dbo].[Build_Taxonomy]'
	END CATCH

	IF @Flag = 1 -- Execute the Sprocs that build the taxonomy Dims and Facts 
	BEGIN
		BEGIN -- FIRST BUILD DIMS
			
			--DimCategory
			BEGIN TRY
				EXEC [Build_DimCategory]

				SET @Error = @@ERROR;

				IF @Error = 0
					EXEC Insert_LogTaxonomy @Error
						,'Build_DimCategory'
						,'DimCategory'
						,'[dbo].[Build_Taxonomy]'
						,1
			END TRY

			BEGIN CATCH
				SELECT @Message = ERROR_MESSAGE();

				EXEC Insert_LogTaxonomy @Error
					,'Build_DimCategory'
					,'DimCategory'
					,'[dbo].[Build_Taxonomy]'
					,1
					,@Message;
			END CATCH


			--DimGeography
			BEGIN TRY
				EXEC [Build_DimGeography]

				SET @Error = @@ERROR;

				IF @Error = 0
					EXEC Insert_LogTaxonomy @Error
						,'Build_DimGeography'
						,'DimGeography'
						,'[dbo].[Build_Taxonomy]'
						,1
			END TRY

			BEGIN CATCH
				SELECT @Message = ERROR_MESSAGE();

				EXEC Insert_LogTaxonomy @Error
					,'Build_DimGeography'
					,'DimGeography'
					,'[dbo].[Build_Taxonomy]'
					,1
					,@Message;
			END CATCH


			--DimReseller
			BEGIN TRY
				EXEC [Build_DimReseller]

				SET @Error = @@ERROR;

				IF @Error = 0
					EXEC Insert_LogTaxonomy @Error
						,'Build_DimReseller'
						,'DimReseller'
						,'[dbo].[Build_Taxonomy]'
						,1
			END TRY

			BEGIN CATCH
				SELECT @Message = ERROR_MESSAGE();

				EXEC Insert_LogTaxonomy @Error
					,'Build_DimReseller'
					,'DimReseller'
					,'[dbo].[Build_Taxonomy]'
					,1
					,@Message;
			END CATCH

			--DimChannel
			BEGIN TRY
				EXEC [Build_DimChannel]

				SET @Error = @@ERROR;

				IF @Error = 0
					EXEC Insert_LogTaxonomy @Error
						,'Build_DimChannel'
						,'DimChannel'
						,'[dbo].[Build_Taxonomy]'
						,1
			END TRY

			BEGIN CATCH
				SELECT @Message = ERROR_MESSAGE();

				EXEC Insert_LogTaxonomy @Error
					,'Build_DimChannel'
					,'DimChannel'
					,'[dbo].[Build_Taxonomy]'
					,1
					,@Message;
			END CATCH

			
		END

		BEGIN -- NOW BUILD FACTS
			SELECT @TimeStamp = CONVERT(VARCHAR(24), GETDATE(), 114)

			SELECT @Message = 'All Dims created, Starting to re build Fact tables ... %s'

			RAISERROR (
					@Message
					,10
					,1
					,@TimeStamp
					)
			WITH NOWAIT

			INSERT INTO Log_Taxonomy
			SELECT @Message
				,@TimeStamp
				,CAST(GETDATE() AS DATE)
				,'[dbo].[Build_Taxonomy]'



			BEGIN TRY
				EXEC [Build_FactSales]

				SET @Error = @@ERROR

				IF @Error = 0
					EXEC Insert_LogTaxonomy @Error
						,'Build_FactSales'
						,'FactSales'
						,'[dbo].[Build_Taxonomy]'
						,1
			END TRY

			BEGIN CATCH
				SELECT @Message = ERROR_MESSAGE();

				EXEC Insert_LogTaxonomy @Error
					,'Build_FactSales'
					,'FactSales'
					,'[dbo].[Build_Taxonomy]'
					,1
					,@Message
			END CATCH
		END

		--  ********************************************************************************************************
		--	**       Do whatever change before this line, the next code shows that the procedure has finished.    **
		--  ********************************************************************************************************


		SELECT @TimeStamp = CONVERT(VARCHAR(24), GETDATE(), 114)

		SELECT @Message = 'Taxonmy process finished... '

		RAISERROR (
				@Message
				,10
				,1
				,@TimeStamp
				)
		WITH NOWAIT

		INSERT INTO Log_Taxonomy
		SELECT @Message
			,@TimeStamp
			,CAST(GETDATE() AS DATE)
			,'[dbo].[Build_Taxonomy]'
	END

	SET NOCOUNT OFF
END