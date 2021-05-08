CREATE TABLE [dbo].[DimCategory] (
    [CategoryID]  INT            IDENTITY (1, 1) NOT NULL,
    [Category]    NVARCHAR (100) NULL,
    [SubCategory] NVARCHAR (100) NULL,
    PRIMARY KEY CLUSTERED ([CategoryID] ASC)
);

