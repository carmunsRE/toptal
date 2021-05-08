CREATE TABLE [dbo].[FactSales] (
    [ID]               INT   IDENTITY (1, 1) NOT NULL,
    [ResellerID]       INT   NULL,
    [ChannelID]        INT   NULL,
    [CategoryID]       INT   NULL,
    [GeographyID]      INT   NULL,
    [PurchasedDate]    INT   NULL,
    [PurchasedTickets] INT   NULL,
    [TotalAmount]      MONEY NULL,
    PRIMARY KEY CLUSTERED ([ID] ASC),
    FOREIGN KEY ([CategoryID]) REFERENCES [dbo].[DimCategory] ([CategoryID]),
    FOREIGN KEY ([ChannelID]) REFERENCES [dbo].[DimChannel] ([ChannelID]),
    FOREIGN KEY ([GeographyID]) REFERENCES [dbo].[DimGeography] ([GeographyID]),
    FOREIGN KEY ([PurchasedDate]) REFERENCES [dbo].[DimDate] ([DateKey]),
    FOREIGN KEY ([ResellerID]) REFERENCES [dbo].[DimReseller] ([ResellerID])
);

