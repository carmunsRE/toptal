CREATE TABLE [dbo].[DimReseller] (
    [ResellerID] INT            IDENTITY (1, 1) NOT NULL,
    [Reseller]   NVARCHAR (100) NULL,
    [Comission]  FLOAT (53)     NULL,
    PRIMARY KEY CLUSTERED ([ResellerID] ASC)
);

