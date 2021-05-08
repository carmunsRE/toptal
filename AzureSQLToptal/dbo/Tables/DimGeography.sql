CREATE TABLE [dbo].[DimGeography] (
    [GeographyID] INT            IDENTITY (1, 1) NOT NULL,
    [Country]     NVARCHAR (100) NULL,
    [Region]      NVARCHAR (100) NULL,
    PRIMARY KEY CLUSTERED ([GeographyID] ASC)
);

