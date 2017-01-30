CREATE TABLE [dbo].[EventTypes] (
    [Id]   INT           IDENTITY (1, 1) NOT NULL,
    [Name] NVARCHAR (30) NOT NULL,
    CONSTRAINT [PK_dbo.EventTypes] PRIMARY KEY CLUSTERED ([Id] ASC)
);

