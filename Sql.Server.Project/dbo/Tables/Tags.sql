CREATE TABLE [dbo].[Tags] (
    [Id]   INT           IDENTITY (1, 1) NOT NULL,
    [Name] NVARCHAR (30) NOT NULL,
    CONSTRAINT [PK_dbo.Tags] PRIMARY KEY CLUSTERED ([Id] ASC) 
);