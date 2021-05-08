CREATE PROCEDURE [dbo].[Insert_LogTaxonomy]
(
@Error int,
@Procedure varchar(100),
@Table varchar(100),
@MainSP varchar(50),
@IsMain smallint,
@ErrMess varchar(max) = ''
)
AS
BEGIN
		DECLARE @TimeStamp VARCHAR(50)
		DECLARE @Message VARCHAR(100)
		DECLARE @Flag VARCHAR(5)
		
		SELECT @TimeStamp = CONVERT(VARCHAR(24), GETDATE(), 114)
		IF @Error<>0 
			BEGIN
				SELECT @Message = '!!! ATENTION  ERROR !!! Executing Store Procedure: '+ @Procedure +', ' + REPLACE(REPLACE(REPLACE([text],'''',''),'*ls.',''),'%.','')
				FROM sys.messages 
				WHERE message_ID = @Error
			END
		ELSE IF @IsMain = 1
		SELECT @Message = @Table +' done ... %s'

		IF @ErrMess <> ''
			SET @Message = '!!! ATENTION  ERROR !!! Executing Store Procedure: '+ @Procedure +', ' +  REPLACE(REPLACE(REPLACE(@ErrMess,'''',''),'*ls.',''),'%.','');

		IF @Error<>0 or @IsMain = 1
		BEGIN
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
				,@MainSP
		END
END