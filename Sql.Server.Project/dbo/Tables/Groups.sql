CREATE TABLE [dbo].[Groups] (
    [Id]         INT            IDENTITY (1, 1) NOT NULL,
    [Name]       NVARCHAR (MAX) NOT NULL,
    [Creator_Id] NVARCHAR(128)            NOT NULL,
    [Photo] NVARCHAR(100) NULL, 
    [Suspended] BIT NOT NULL, 
    [About] NVARCHAR(MAX) NULL, 
    CONSTRAINT [PK_dbo.Groups] PRIMARY KEY CLUSTERED ([Id] ASC),
    CONSTRAINT [FK_dbo.Groups_dbo.Users_Creator_Id] FOREIGN KEY ([Creator_Id]) REFERENCES [dbo].[Users] ([Id])
);


GO
CREATE NONCLUSTERED INDEX [IX_Creator_Id]
    ON [dbo].[Groups]([Creator_Id] ASC);

