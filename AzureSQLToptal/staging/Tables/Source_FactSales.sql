CREATE TABLE [staging].[Source_FactSales] (
    [Reseller]         NVARCHAR (100) NULL,
    [SalesChannel]     NVARCHAR (100) NULL,
    [Category]         NVARCHAR (100) NULL,
    [SubCategory]      NVARCHAR (100) NULL,
    [Country]          NVARCHAR (100) NULL,
    [Region]           NVARCHAR (100) NULL,
    [PurchasedDate]    DATE           NULL,
    [PurchasedTickets] INT            NULL,
    [TotalAmount]      MONEY          NULL
);

