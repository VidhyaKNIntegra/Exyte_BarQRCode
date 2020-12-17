USE [ToolCostingDB]
GO

/****** Object:  Table [dbo].[Category]    Script Date: 12/16/20 22:25:32 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE TABLE [dbo].[Category](
	[CategoryID] [int] IDENTITY(1,1) NOT NULL,
	[CategoryName] [varchar](50) NOT NULL,
	[SPName] [varchar](250) NOT NULL,
	[Description] [nvarchar](500) NULL,
	[CreatedBy] [int] NOT NULL,
	[CreatedOn] [datetime] NOT NULL,
	[ModifiedBy] [int] NULL,
	[ModifiedOn] [datetime] NULL,
 CONSTRAINT [PK_Category] PRIMARY KEY CLUSTERED 
(
	[CategoryID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO

ALTER TABLE [dbo].[Category] ADD  CONSTRAINT [DF_Category_CreatedOn]  DEFAULT (getdate()) FOR [CreatedOn]
GO


