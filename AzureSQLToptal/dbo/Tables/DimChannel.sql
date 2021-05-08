CREATE TABLE [dbo].[DimChannel] (
    [ChannelID] INT            IDENTITY (1, 1) NOT NULL,
    [Channel]   NVARCHAR (100) NULL,
    PRIMARY KEY CLUSTERED ([ChannelID] ASC)
);

