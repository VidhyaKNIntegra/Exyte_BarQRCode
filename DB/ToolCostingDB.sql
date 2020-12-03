USE [master]
GO
/****** Object:  Database [ToolCostingDB]    Script Date: 12/3/20 17:22:39 ******/
CREATE DATABASE [ToolCostingDB]
 CONTAINMENT = NONE
 ON  PRIMARY 
( NAME = N'ToolCostingDB', FILENAME = N'D:\ToolCostingDB.mdf' , SIZE = 6144KB , MAXSIZE = UNLIMITED, FILEGROWTH = 1024KB )
 LOG ON 
( NAME = N'ToolCostingDB_log', FILENAME = N'D:\ToolCostingDB_log.ldf' , SIZE = 6272KB , MAXSIZE = 2048GB , FILEGROWTH = 10%)
GO
ALTER DATABASE [ToolCostingDB] SET COMPATIBILITY_LEVEL = 110
GO
IF (1 = FULLTEXTSERVICEPROPERTY('IsFullTextInstalled'))
begin
EXEC [ToolCostingDB].[dbo].[sp_fulltext_database] @action = 'enable'
end
GO
ALTER DATABASE [ToolCostingDB] SET ANSI_NULL_DEFAULT OFF 
GO
ALTER DATABASE [ToolCostingDB] SET ANSI_NULLS OFF 
GO
ALTER DATABASE [ToolCostingDB] SET ANSI_PADDING OFF 
GO
ALTER DATABASE [ToolCostingDB] SET ANSI_WARNINGS OFF 
GO
ALTER DATABASE [ToolCostingDB] SET ARITHABORT OFF 
GO
ALTER DATABASE [ToolCostingDB] SET AUTO_CLOSE OFF 
GO
ALTER DATABASE [ToolCostingDB] SET AUTO_SHRINK OFF 
GO
ALTER DATABASE [ToolCostingDB] SET AUTO_UPDATE_STATISTICS ON 
GO
ALTER DATABASE [ToolCostingDB] SET CURSOR_CLOSE_ON_COMMIT OFF 
GO
ALTER DATABASE [ToolCostingDB] SET CURSOR_DEFAULT  GLOBAL 
GO
ALTER DATABASE [ToolCostingDB] SET CONCAT_NULL_YIELDS_NULL OFF 
GO
ALTER DATABASE [ToolCostingDB] SET NUMERIC_ROUNDABORT OFF 
GO
ALTER DATABASE [ToolCostingDB] SET QUOTED_IDENTIFIER OFF 
GO
ALTER DATABASE [ToolCostingDB] SET RECURSIVE_TRIGGERS OFF 
GO
ALTER DATABASE [ToolCostingDB] SET  DISABLE_BROKER 
GO
ALTER DATABASE [ToolCostingDB] SET AUTO_UPDATE_STATISTICS_ASYNC OFF 
GO
ALTER DATABASE [ToolCostingDB] SET DATE_CORRELATION_OPTIMIZATION OFF 
GO
ALTER DATABASE [ToolCostingDB] SET TRUSTWORTHY OFF 
GO
ALTER DATABASE [ToolCostingDB] SET ALLOW_SNAPSHOT_ISOLATION OFF 
GO
ALTER DATABASE [ToolCostingDB] SET PARAMETERIZATION SIMPLE 
GO
ALTER DATABASE [ToolCostingDB] SET READ_COMMITTED_SNAPSHOT OFF 
GO
ALTER DATABASE [ToolCostingDB] SET HONOR_BROKER_PRIORITY OFF 
GO
ALTER DATABASE [ToolCostingDB] SET RECOVERY SIMPLE 
GO
ALTER DATABASE [ToolCostingDB] SET  MULTI_USER 
GO
ALTER DATABASE [ToolCostingDB] SET PAGE_VERIFY CHECKSUM  
GO
ALTER DATABASE [ToolCostingDB] SET DB_CHAINING OFF 
GO
ALTER DATABASE [ToolCostingDB] SET FILESTREAM( NON_TRANSACTED_ACCESS = OFF ) 
GO
ALTER DATABASE [ToolCostingDB] SET TARGET_RECOVERY_TIME = 0 SECONDS 
GO
USE [ToolCostingDB]
GO
/****** Object:  Table [dbo].[MenuList]    Script Date: 12/3/20 17:22:40 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[MenuList](
	[Id] [bigint] IDENTITY(1,1) NOT NULL,
	[MenuName] [nvarchar](100) NOT NULL,
	[ParentMenu] [bigint] NULL,
	[Url] [nvarchar](250) NULL,
	[IsActive] [bit] NOT NULL,
	[CreatedOn] [datetime] NULL,
	[CreatedBy] [int] NULL,
	[ModifiedOn] [datetime] NULL,
	[ModifiedBy] [int] NULL,
	[MenuClass] [varchar](200) NULL,
 CONSTRAINT [PK_Menu_Master] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[MenuRole]    Script Date: 12/3/20 17:22:40 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[MenuRole](
	[Id] [bigint] IDENTITY(1,1) NOT NULL,
	[MenuId] [bigint] NOT NULL,
	[RoleId] [int] NOT NULL,
	[Created_On] [datetime] NULL,
	[Created_By] [int] NULL,
 CONSTRAINT [PK_MenuRole] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[OperationAudit]    Script Date: 12/3/20 17:22:40 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[OperationAudit](
	[Sno] [bigint] IDENTITY(1,1) NOT NULL,
	[AuditId] [bigint] NOT NULL,
	[Opertaion] [nvarchar](2000) NOT NULL,
	[CreatedOn] [datetime] NOT NULL,
 CONSTRAINT [PK_OperationAudit] PRIMARY KEY CLUSTERED 
(
	[Sno] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Roles]    Script Date: 12/3/20 17:22:40 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Roles](
	[RoleId] [int] IDENTITY(1,1) NOT NULL,
	[RoleName] [nvarchar](50) NOT NULL,
	[RoleDescription] [nvarchar](500) NULL,
	[Is_Active] [bit] NOT NULL,
	[Created_On] [datetime] NOT NULL,
	[Created_By] [int] NULL,
	[Modified_On] [datetime] NULL,
	[Modified_By] [int] NULL,
 CONSTRAINT [PK_Role_Master] PRIMARY KEY CLUSTERED 
(
	[RoleId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[UserAudit]    Script Date: 12/3/20 17:22:40 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[UserAudit](
	[Sno] [bigint] IDENTITY(1,1) NOT NULL,
	[UserID] [bigint] NOT NULL,
	[IsLogin] [bit] NOT NULL,
	[LoginOn] [datetime] NULL,
	[LogoutOn] [datetime] NULL,
 CONSTRAINT [PK_UserAudit] PRIMARY KEY CLUSTERED 
(
	[Sno] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Users]    Script Date: 12/3/20 17:22:40 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Users](
	[UserId] [bigint] IDENTITY(1,1) NOT NULL,
	[Email] [nvarchar](256) NULL,
	[Password] [nvarchar](max) NULL,
	[PhoneNumber] [nvarchar](50) NULL,
	[FirstName] [nvarchar](50) NULL,
	[LastName] [nvarchar](50) NULL,
	[RoleId] [int] NOT NULL,
	[IsPasswordChanged] [bit] NULL,
	[IsActive] [bit] NULL,
	[CreatedOn] [datetime] NULL,
	[CreatedBy] [int] NULL,
	[ModifiedOn] [datetime] NULL,
	[ModifiedBy] [int] NULL,
 CONSTRAINT [PK_tbl_User_Master] PRIMARY KEY CLUSTERED 
(
	[UserId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
SET IDENTITY_INSERT [dbo].[MenuList] ON 

INSERT [dbo].[MenuList] ([Id], [MenuName], [ParentMenu], [Url], [IsActive], [CreatedOn], [CreatedBy], [ModifiedOn], [ModifiedBy], [MenuClass]) VALUES (1, N'Cost Data', NULL, N'Home/Index', 1, CAST(N'2020-09-24T14:56:02.370' AS DateTime), NULL, NULL, NULL, N'zmdi zmdi-home zmdi-hc-fw')
INSERT [dbo].[MenuList] ([Id], [MenuName], [ParentMenu], [Url], [IsActive], [CreatedOn], [CreatedBy], [ModifiedOn], [ModifiedBy], [MenuClass]) VALUES (2, N'Projects', NULL, N'Projects/Projects', 1, CAST(N'2020-09-24T14:56:02.373' AS DateTime), NULL, NULL, NULL, N'zmdi zmdi-widgets zmdi-hc-fw')
INSERT [dbo].[MenuList] ([Id], [MenuName], [ParentMenu], [Url], [IsActive], [CreatedOn], [CreatedBy], [ModifiedOn], [ModifiedBy], [MenuClass]) VALUES (3, N'Import Cost Data', NULL, N'FileUpload/FileUpload', 1, CAST(N'2020-09-24T14:56:02.373' AS DateTime), NULL, NULL, NULL, N'zmdi zmdi-upload zmdi-hc-fw')
INSERT [dbo].[MenuList] ([Id], [MenuName], [ParentMenu], [Url], [IsActive], [CreatedOn], [CreatedBy], [ModifiedOn], [ModifiedBy], [MenuClass]) VALUES (4, N'Reports', NULL, N'#', 0, CAST(N'2020-09-24T14:56:02.373' AS DateTime), NULL, NULL, NULL, N'zmdi zmdi-folder zmdi-hc-fw')
INSERT [dbo].[MenuList] ([Id], [MenuName], [ParentMenu], [Url], [IsActive], [CreatedOn], [CreatedBy], [ModifiedOn], [ModifiedBy], [MenuClass]) VALUES (5, N'ValveList', 4, N'Reports/ValveList', 0, CAST(N'2020-09-24T14:56:02.373' AS DateTime), NULL, NULL, NULL, NULL)
INSERT [dbo].[MenuList] ([Id], [MenuName], [ParentMenu], [Url], [IsActive], [CreatedOn], [CreatedBy], [ModifiedOn], [ModifiedBy], [MenuClass]) VALUES (6, N'Instreent List', 4, N'#', 0, CAST(N'2020-09-24T14:56:02.377' AS DateTime), NULL, NULL, NULL, NULL)
INSERT [dbo].[MenuList] ([Id], [MenuName], [ParentMenu], [Url], [IsActive], [CreatedOn], [CreatedBy], [ModifiedOn], [ModifiedBy], [MenuClass]) VALUES (7, N'MTO', 4, N'#', 0, CAST(N'2020-09-24T14:56:02.377' AS DateTime), NULL, NULL, NULL, NULL)
INSERT [dbo].[MenuList] ([Id], [MenuName], [ParentMenu], [Url], [IsActive], [CreatedOn], [CreatedBy], [ModifiedOn], [ModifiedBy], [MenuClass]) VALUES (8, N'Users', NULL, N'Account/Users', 1, CAST(N'2020-09-24T14:56:02.377' AS DateTime), NULL, NULL, NULL, N'zmdi zmdi-account zmdi-hc-fw')
INSERT [dbo].[MenuList] ([Id], [MenuName], [ParentMenu], [Url], [IsActive], [CreatedOn], [CreatedBy], [ModifiedOn], [ModifiedBy], [MenuClass]) VALUES (9, N'Roles', NULL, N'Account/Roles', 1, CAST(N'2020-09-24T14:56:02.377' AS DateTime), NULL, NULL, NULL, N'zmdi zmdi-account-box-o zmdi-hc-fw')
INSERT [dbo].[MenuList] ([Id], [MenuName], [ParentMenu], [Url], [IsActive], [CreatedOn], [CreatedBy], [ModifiedOn], [ModifiedBy], [MenuClass]) VALUES (10, N'Reload Project Data', NULL, N'Projects/RefreshProject', 1, CAST(N'2020-09-24T14:56:02.377' AS DateTime), NULL, NULL, NULL, N'zmdi zmdi-home zmdi-hc-fw')
INSERT [dbo].[MenuList] ([Id], [MenuName], [ParentMenu], [Url], [IsActive], [CreatedOn], [CreatedBy], [ModifiedOn], [ModifiedBy], [MenuClass]) VALUES (11, N'Environment', NULL, N'#', 1, CAST(N'2020-10-21T12:57:12.800' AS DateTime), NULL, NULL, NULL, N'zmdi zmdi-folder zmdi-hc-fw')
INSERT [dbo].[MenuList] ([Id], [MenuName], [ParentMenu], [Url], [IsActive], [CreatedOn], [CreatedBy], [ModifiedOn], [ModifiedBy], [MenuClass]) VALUES (14, N'MS-SQL', 11, N'MSSQL/MSSQLHome', 1, CAST(N'2020-10-21T12:59:37.037' AS DateTime), NULL, NULL, NULL, NULL)
INSERT [dbo].[MenuList] ([Id], [MenuName], [ParentMenu], [Url], [IsActive], [CreatedOn], [CreatedBy], [ModifiedOn], [ModifiedBy], [MenuClass]) VALUES (15, N'SQL-Lite', 11, N'SqlLite/SqlLiteHome', 0, CAST(N'2020-10-21T13:01:05.237' AS DateTime), NULL, NULL, NULL, NULL)
INSERT [dbo].[MenuList] ([Id], [MenuName], [ParentMenu], [Url], [IsActive], [CreatedOn], [CreatedBy], [ModifiedOn], [ModifiedBy], [MenuClass]) VALUES (16, N'Report Types', NULL, N'Reports/AddReportType', 1, CAST(N'2020-10-24T00:20:40.017' AS DateTime), NULL, NULL, NULL, N'zmdi zmdi-widgets zmdi-hc-fw')
INSERT [dbo].[MenuList] ([Id], [MenuName], [ParentMenu], [Url], [IsActive], [CreatedOn], [CreatedBy], [ModifiedOn], [ModifiedBy], [MenuClass]) VALUES (17, N'MTOMisc Data', NULL, N'Reports/MTOMiscData', 1, CAST(N'2020-11-04T17:27:19.987' AS DateTime), NULL, NULL, NULL, N'zmdi zmdi-widgets zmdi-hc-fw')
INSERT [dbo].[MenuList] ([Id], [MenuName], [ParentMenu], [Url], [IsActive], [CreatedOn], [CreatedBy], [ModifiedOn], [ModifiedBy], [MenuClass]) VALUES (18, N'Group Elements', NULL, N'Elements/Elements', 1, CAST(N'2020-11-06T11:27:22.460' AS DateTime), NULL, NULL, NULL, N'zmdi zmdi-group zmdi-hc-fw')
INSERT [dbo].[MenuList] ([Id], [MenuName], [ParentMenu], [Url], [IsActive], [CreatedOn], [CreatedBy], [ModifiedOn], [ModifiedBy], [MenuClass]) VALUES (19, N'Material', NULL, N'elements/Material', 1, CAST(N'2020-11-06T11:27:22.460' AS DateTime), NULL, NULL, NULL, N'zmdi zmdi-flower zmdi-hc-fw')
INSERT [dbo].[MenuList] ([Id], [MenuName], [ParentMenu], [Url], [IsActive], [CreatedOn], [CreatedBy], [ModifiedOn], [ModifiedBy], [MenuClass]) VALUES (20, N'Pipe Component', NULL, N'elements/PipeComponents', 1, CAST(N'2020-11-06T11:27:22.460' AS DateTime), NULL, NULL, NULL, N'zmdi zmdi-input-composite zmdi-hc-fw')
INSERT [dbo].[MenuList] ([Id], [MenuName], [ParentMenu], [Url], [IsActive], [CreatedOn], [CreatedBy], [ModifiedOn], [ModifiedBy], [MenuClass]) VALUES (21, N'Size', NULL, N'elements/Size', 1, CAST(N'2020-11-06T11:27:22.460' AS DateTime), NULL, NULL, NULL, N'zmdi zmdi-square-o zmdi-hc-fw')
INSERT [dbo].[MenuList] ([Id], [MenuName], [ParentMenu], [Url], [IsActive], [CreatedOn], [CreatedBy], [ModifiedOn], [ModifiedBy], [MenuClass]) VALUES (22, N'Unit Of Measurement', NULL, N'Elements/UOM', 1, CAST(N'2020-11-06T11:27:22.460' AS DateTime), NULL, NULL, NULL, N'zmdi zmdi-view-stream zmdi-hc-fw')
INSERT [dbo].[MenuList] ([Id], [MenuName], [ParentMenu], [Url], [IsActive], [CreatedOn], [CreatedBy], [ModifiedOn], [ModifiedBy], [MenuClass]) VALUES (23, N'Manufacturer', NULL, N'Elements/Manufacturer
', 1, CAST(N'2020-11-06T11:27:22.460' AS DateTime), NULL, NULL, NULL, N'zmdi zmdi-group-work zmdi-hc-fw')
INSERT [dbo].[MenuList] ([Id], [MenuName], [ParentMenu], [Url], [IsActive], [CreatedOn], [CreatedBy], [ModifiedOn], [ModifiedBy], [MenuClass]) VALUES (26, N'Generate Barcode', NULL, N'MSSQL/MSSQLHome', 1, CAST(N'2020-12-03T15:15:49.300' AS DateTime), NULL, NULL, NULL, N'zmdi zmdi-blur-linear zmdi-hc-fw')
SET IDENTITY_INSERT [dbo].[MenuList] OFF
GO
SET IDENTITY_INSERT [dbo].[MenuRole] ON 

INSERT [dbo].[MenuRole] ([Id], [MenuId], [RoleId], [Created_On], [Created_By]) VALUES (1, 8, 1, CAST(N'2020-09-24T15:09:22.793' AS DateTime), NULL)
INSERT [dbo].[MenuRole] ([Id], [MenuId], [RoleId], [Created_On], [Created_By]) VALUES (2, 9, 1, CAST(N'2020-09-24T15:09:22.797' AS DateTime), NULL)
INSERT [dbo].[MenuRole] ([Id], [MenuId], [RoleId], [Created_On], [Created_By]) VALUES (11, 4, 1, CAST(N'2020-09-25T13:31:44.227' AS DateTime), NULL)
INSERT [dbo].[MenuRole] ([Id], [MenuId], [RoleId], [Created_On], [Created_By]) VALUES (12, 5, 1, CAST(N'2020-09-25T13:31:44.227' AS DateTime), NULL)
INSERT [dbo].[MenuRole] ([Id], [MenuId], [RoleId], [Created_On], [Created_By]) VALUES (13, 6, 1, CAST(N'2020-09-25T13:31:44.230' AS DateTime), NULL)
INSERT [dbo].[MenuRole] ([Id], [MenuId], [RoleId], [Created_On], [Created_By]) VALUES (14, 7, 1, CAST(N'2020-09-25T13:31:44.230' AS DateTime), NULL)
INSERT [dbo].[MenuRole] ([Id], [MenuId], [RoleId], [Created_On], [Created_By]) VALUES (17, 1, 4, CAST(N'2020-09-30T18:16:13.980' AS DateTime), 1)
INSERT [dbo].[MenuRole] ([Id], [MenuId], [RoleId], [Created_On], [Created_By]) VALUES (18, 3, 4, CAST(N'2020-09-30T18:16:18.537' AS DateTime), 1)
INSERT [dbo].[MenuRole] ([Id], [MenuId], [RoleId], [Created_On], [Created_By]) VALUES (25, 11, 1, CAST(N'2020-10-21T13:07:07.853' AS DateTime), 1)
INSERT [dbo].[MenuRole] ([Id], [MenuId], [RoleId], [Created_On], [Created_By]) VALUES (28, 14, 1, CAST(N'2020-10-21T13:08:43.303' AS DateTime), 1)
INSERT [dbo].[MenuRole] ([Id], [MenuId], [RoleId], [Created_On], [Created_By]) VALUES (29, 15, 1, CAST(N'2020-10-21T13:08:47.240' AS DateTime), NULL)
INSERT [dbo].[MenuRole] ([Id], [MenuId], [RoleId], [Created_On], [Created_By]) VALUES (30, 17, 4, CAST(N'2020-11-04T17:29:51.770' AS DateTime), NULL)
INSERT [dbo].[MenuRole] ([Id], [MenuId], [RoleId], [Created_On], [Created_By]) VALUES (31, 18, 4, CAST(N'2020-11-06T11:28:19.637' AS DateTime), NULL)
INSERT [dbo].[MenuRole] ([Id], [MenuId], [RoleId], [Created_On], [Created_By]) VALUES (35, 2, 3, CAST(N'2020-11-10T11:59:01.597' AS DateTime), 1)
INSERT [dbo].[MenuRole] ([Id], [MenuId], [RoleId], [Created_On], [Created_By]) VALUES (36, 10, 3, CAST(N'2020-11-10T11:59:01.600' AS DateTime), 1)
INSERT [dbo].[MenuRole] ([Id], [MenuId], [RoleId], [Created_On], [Created_By]) VALUES (38, 19, 4, CAST(N'2020-11-10T11:59:01.600' AS DateTime), 1)
INSERT [dbo].[MenuRole] ([Id], [MenuId], [RoleId], [Created_On], [Created_By]) VALUES (39, 20, 4, CAST(N'2020-11-10T11:59:01.600' AS DateTime), 1)
INSERT [dbo].[MenuRole] ([Id], [MenuId], [RoleId], [Created_On], [Created_By]) VALUES (40, 21, 4, CAST(N'2020-11-10T11:59:01.600' AS DateTime), 1)
INSERT [dbo].[MenuRole] ([Id], [MenuId], [RoleId], [Created_On], [Created_By]) VALUES (43, 22, 4, CAST(N'2020-11-17T17:20:30.347' AS DateTime), NULL)
INSERT [dbo].[MenuRole] ([Id], [MenuId], [RoleId], [Created_On], [Created_By]) VALUES (44, 23, 4, CAST(N'2020-11-17T17:20:30.347' AS DateTime), NULL)
INSERT [dbo].[MenuRole] ([Id], [MenuId], [RoleId], [Created_On], [Created_By]) VALUES (59, 14, 2, CAST(N'2020-12-01T17:36:55.890' AS DateTime), NULL)
INSERT [dbo].[MenuRole] ([Id], [MenuId], [RoleId], [Created_On], [Created_By]) VALUES (60, 15, 2, CAST(N'2020-12-01T17:36:59.943' AS DateTime), NULL)
INSERT [dbo].[MenuRole] ([Id], [MenuId], [RoleId], [Created_On], [Created_By]) VALUES (62, 26, 2, CAST(N'2020-12-01T17:40:08.260' AS DateTime), NULL)
SET IDENTITY_INSERT [dbo].[MenuRole] OFF
GO
SET IDENTITY_INSERT [dbo].[Roles] ON 

INSERT [dbo].[Roles] ([RoleId], [RoleName], [RoleDescription], [Is_Active], [Created_On], [Created_By], [Modified_On], [Modified_By]) VALUES (1, N'SuperAdmin', N'Application administrator role', 1, CAST(N'2020-09-24T15:06:38.120' AS DateTime), 1, NULL, NULL)
INSERT [dbo].[Roles] ([RoleId], [RoleName], [RoleDescription], [Is_Active], [Created_On], [Created_By], [Modified_On], [Modified_By]) VALUES (2, N'Admin', N'Admin Role', 1, CAST(N'2020-11-25T13:32:04.683' AS DateTime), 1, NULL, NULL)
INSERT [dbo].[Roles] ([RoleId], [RoleName], [RoleDescription], [Is_Active], [Created_On], [Created_By], [Modified_On], [Modified_By]) VALUES (3, N'Engineer', N'Engineer Role', 1, CAST(N'2020-09-24T15:42:29.777' AS DateTime), 1, CAST(N'2020-11-10T11:59:01.593' AS DateTime), 1)
INSERT [dbo].[Roles] ([RoleId], [RoleName], [RoleDescription], [Is_Active], [Created_On], [Created_By], [Modified_On], [Modified_By]) VALUES (4, N'Commercial', N'Commercial Role', 1, CAST(N'2020-09-24T15:43:06.370' AS DateTime), 1, CAST(N'2020-09-30T18:16:13.917' AS DateTime), 1)
SET IDENTITY_INSERT [dbo].[Roles] OFF
GO
SET IDENTITY_INSERT [dbo].[UserAudit] ON 

INSERT [dbo].[UserAudit] ([Sno], [UserID], [IsLogin], [LoginOn], [LogoutOn]) VALUES (1, 2, 1, CAST(N'2020-12-01T17:33:32.890' AS DateTime), NULL)
INSERT [dbo].[UserAudit] ([Sno], [UserID], [IsLogin], [LoginOn], [LogoutOn]) VALUES (2, 2, 1, CAST(N'2020-12-02T13:18:03.810' AS DateTime), NULL)
INSERT [dbo].[UserAudit] ([Sno], [UserID], [IsLogin], [LoginOn], [LogoutOn]) VALUES (3, 2, 1, CAST(N'2020-12-02T15:54:44.687' AS DateTime), NULL)
INSERT [dbo].[UserAudit] ([Sno], [UserID], [IsLogin], [LoginOn], [LogoutOn]) VALUES (4, 2, 1, CAST(N'2020-12-02T16:04:02.497' AS DateTime), NULL)
INSERT [dbo].[UserAudit] ([Sno], [UserID], [IsLogin], [LoginOn], [LogoutOn]) VALUES (5, 2, 1, CAST(N'2020-12-02T16:12:10.297' AS DateTime), NULL)
INSERT [dbo].[UserAudit] ([Sno], [UserID], [IsLogin], [LoginOn], [LogoutOn]) VALUES (6, 2, 1, CAST(N'2020-12-02T16:26:45.037' AS DateTime), NULL)
INSERT [dbo].[UserAudit] ([Sno], [UserID], [IsLogin], [LoginOn], [LogoutOn]) VALUES (7, 2, 1, CAST(N'2020-12-02T17:07:39.897' AS DateTime), NULL)
INSERT [dbo].[UserAudit] ([Sno], [UserID], [IsLogin], [LoginOn], [LogoutOn]) VALUES (8, 2, 1, CAST(N'2020-12-03T11:07:38.100' AS DateTime), NULL)
INSERT [dbo].[UserAudit] ([Sno], [UserID], [IsLogin], [LoginOn], [LogoutOn]) VALUES (9, 2, 1, CAST(N'2020-12-03T12:11:18.343' AS DateTime), NULL)
INSERT [dbo].[UserAudit] ([Sno], [UserID], [IsLogin], [LoginOn], [LogoutOn]) VALUES (10, 2, 1, CAST(N'2020-12-03T12:28:15.507' AS DateTime), NULL)
INSERT [dbo].[UserAudit] ([Sno], [UserID], [IsLogin], [LoginOn], [LogoutOn]) VALUES (11, 2, 1, CAST(N'2020-12-03T14:22:53.380' AS DateTime), NULL)
INSERT [dbo].[UserAudit] ([Sno], [UserID], [IsLogin], [LoginOn], [LogoutOn]) VALUES (12, 2, 1, CAST(N'2020-12-03T14:39:15.633' AS DateTime), NULL)
INSERT [dbo].[UserAudit] ([Sno], [UserID], [IsLogin], [LoginOn], [LogoutOn]) VALUES (13, 2, 1, CAST(N'2020-12-03T14:42:17.030' AS DateTime), NULL)
INSERT [dbo].[UserAudit] ([Sno], [UserID], [IsLogin], [LoginOn], [LogoutOn]) VALUES (14, 2, 1, CAST(N'2020-12-03T14:46:30.657' AS DateTime), NULL)
INSERT [dbo].[UserAudit] ([Sno], [UserID], [IsLogin], [LoginOn], [LogoutOn]) VALUES (15, 2, 1, CAST(N'2020-12-03T15:10:30.653' AS DateTime), NULL)
INSERT [dbo].[UserAudit] ([Sno], [UserID], [IsLogin], [LoginOn], [LogoutOn]) VALUES (16, 2, 0, NULL, CAST(N'2020-12-03T15:25:40.347' AS DateTime))
INSERT [dbo].[UserAudit] ([Sno], [UserID], [IsLogin], [LoginOn], [LogoutOn]) VALUES (17, 2, 1, CAST(N'2020-12-03T15:25:53.617' AS DateTime), NULL)
INSERT [dbo].[UserAudit] ([Sno], [UserID], [IsLogin], [LoginOn], [LogoutOn]) VALUES (18, 2, 1, CAST(N'2020-12-03T16:05:41.327' AS DateTime), NULL)
INSERT [dbo].[UserAudit] ([Sno], [UserID], [IsLogin], [LoginOn], [LogoutOn]) VALUES (19, 2, 1, CAST(N'2020-12-03T16:37:43.320' AS DateTime), NULL)
INSERT [dbo].[UserAudit] ([Sno], [UserID], [IsLogin], [LoginOn], [LogoutOn]) VALUES (20, 2, 0, NULL, CAST(N'2020-12-03T17:20:06.960' AS DateTime))
INSERT [dbo].[UserAudit] ([Sno], [UserID], [IsLogin], [LoginOn], [LogoutOn]) VALUES (21, 2, 1, CAST(N'2020-12-03T17:20:41.103' AS DateTime), NULL)
SET IDENTITY_INSERT [dbo].[UserAudit] OFF
GO
SET IDENTITY_INSERT [dbo].[Users] ON 

INSERT [dbo].[Users] ([UserId], [Email], [Password], [PhoneNumber], [FirstName], [LastName], [RoleId], [IsPasswordChanged], [IsActive], [CreatedOn], [CreatedBy], [ModifiedOn], [ModifiedBy]) VALUES (1, N'superadmin@exyte.com', N'186cf774c97b60a1c106ef718d10970a6a06e06bef89553d9ae65d938a886eae', NULL, N'Admin', NULL, 1, 1, 1, NULL, NULL, CAST(N'2020-11-25T13:31:27.543' AS DateTime), 1)
INSERT [dbo].[Users] ([UserId], [Email], [Password], [PhoneNumber], [FirstName], [LastName], [RoleId], [IsPasswordChanged], [IsActive], [CreatedOn], [CreatedBy], [ModifiedOn], [ModifiedBy]) VALUES (2, N'admin@exyte.com', N'8c6976e5b5410415bde908bd4dee15dfb167a9c873fc4bb8a81f6f2ab448a918', NULL, N'Admin', NULL, 2, 1, 1, CAST(N'2020-11-25T13:33:32.810' AS DateTime), 1, CAST(N'2020-11-25T13:41:40.867' AS DateTime), 1)
INSERT [dbo].[Users] ([UserId], [Email], [Password], [PhoneNumber], [FirstName], [LastName], [RoleId], [IsPasswordChanged], [IsActive], [CreatedOn], [CreatedBy], [ModifiedOn], [ModifiedBy]) VALUES (3, N'engineer@exyte.com', N'7826b958b79c70626801b880405eb5111557dadceb2fee2b1ed69a18eed0c6dc', N'9848984898', N'Engineer', NULL, 3, 1, 1, CAST(N'2020-09-24T15:44:43.637' AS DateTime), 1, CAST(N'2020-11-10T12:44:59.320' AS DateTime), 1)
INSERT [dbo].[Users] ([UserId], [Email], [Password], [PhoneNumber], [FirstName], [LastName], [RoleId], [IsPasswordChanged], [IsActive], [CreatedOn], [CreatedBy], [ModifiedOn], [ModifiedBy]) VALUES (4, N'commercial@exyte.com', N'd01acdec3a3b87b33882a0fb8959ffda858a0642f7f54190f67aa230e04d1547', N'9090909090', N'Commercial', NULL, 4, 1, 1, CAST(N'2020-09-24T15:55:54.497' AS DateTime), 1, CAST(N'2020-10-27T16:30:22.037' AS DateTime), 1)
SET IDENTITY_INSERT [dbo].[Users] OFF
GO
ALTER TABLE [dbo].[MenuList] ADD  CONSTRAINT [DF_Menu_Master_Created_On]  DEFAULT (getdate()) FOR [CreatedOn]
GO
ALTER TABLE [dbo].[MenuRole] ADD  CONSTRAINT [DF_Menu_Permission_Master_Created_On]  DEFAULT (getdate()) FOR [Created_On]
GO
ALTER TABLE [dbo].[OperationAudit] ADD  CONSTRAINT [DF_OperationAudit_CreatedOn]  DEFAULT (getdate()) FOR [CreatedOn]
GO
ALTER TABLE [dbo].[Roles] ADD  CONSTRAINT [DF_Roles_Is_Active]  DEFAULT ((1)) FOR [Is_Active]
GO
ALTER TABLE [dbo].[Roles] ADD  CONSTRAINT [DF_Role_Master_Created_On]  DEFAULT (getdate()) FOR [Created_On]
GO
ALTER TABLE [dbo].[Users] ADD  CONSTRAINT [DF_Users_IsPasswordChanged]  DEFAULT ((0)) FOR [IsPasswordChanged]
GO
ALTER TABLE [dbo].[Users] ADD  CONSTRAINT [DF_Users_IsActive]  DEFAULT ((1)) FOR [IsActive]
GO
ALTER TABLE [dbo].[MenuRole]  WITH CHECK ADD  CONSTRAINT [FK__Menu_Perm__MenuI__571DF1D5] FOREIGN KEY([MenuId])
REFERENCES [dbo].[MenuList] ([Id])
GO
ALTER TABLE [dbo].[MenuRole] CHECK CONSTRAINT [FK__Menu_Perm__MenuI__571DF1D5]
GO
ALTER TABLE [dbo].[MenuRole]  WITH CHECK ADD  CONSTRAINT [FK__Menu_Perm__RoleI__5CD6CB2B] FOREIGN KEY([RoleId])
REFERENCES [dbo].[Roles] ([RoleId])
GO
ALTER TABLE [dbo].[MenuRole] CHECK CONSTRAINT [FK__Menu_Perm__RoleI__5CD6CB2B]
GO
ALTER TABLE [dbo].[OperationAudit]  WITH CHECK ADD  CONSTRAINT [FK__Operation__Audit__412EB0B6] FOREIGN KEY([AuditId])
REFERENCES [dbo].[UserAudit] ([Sno])
GO
ALTER TABLE [dbo].[OperationAudit] CHECK CONSTRAINT [FK__Operation__Audit__412EB0B6]
GO
ALTER TABLE [dbo].[UserAudit]  WITH CHECK ADD  CONSTRAINT [FK__UserAudit__UserI__3D5E1FD2] FOREIGN KEY([UserID])
REFERENCES [dbo].[Users] ([UserId])
GO
ALTER TABLE [dbo].[UserAudit] CHECK CONSTRAINT [FK__UserAudit__UserI__3D5E1FD2]
GO
ALTER TABLE [dbo].[Users]  WITH CHECK ADD  CONSTRAINT [FK__User_Mast__RoleI__267ABA7A] FOREIGN KEY([RoleId])
REFERENCES [dbo].[Roles] ([RoleId])
GO
ALTER TABLE [dbo].[Users] CHECK CONSTRAINT [FK__User_Mast__RoleI__267ABA7A]
GO
/****** Object:  StoredProcedure [dbo].[GET_INSTRUMENT_DATA_FOR_ALL_DB]    Script Date: 12/3/20 17:22:40 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[GET_INSTRUMENT_DATA_FOR_ALL_DB] 
AS
DECLARE @DBName varchar(200);
DECLARE @projid varchar(200);
DECLARE @Query varchar(max);
DECLARE @DELQuery varchar(max);
BEGIN
	DECLARE ProjectDetails CURSOR
    FOR SELECT projdatabase,projectid from [ToolCostingDB].dbo.projmaster;
	OPEN ProjectDetails;
	FETCH NEXT FROM ProjectDetails INTO @DBName,@projid;
	WHILE @@FETCH_STATUS = 0
    BEGIN
        PRINT @projid;
        
	SET @DELQuery='DELETE FROM [ToolCostingDB].[dbo].[InstrumentData] WHERE projectid='''+@projid+'''';
	print @DELQuery
	EXEC(@DELQuery);
	SET @Query='
		INSERT INTO [ToolCostingDB].[dbo].[InstrumentData]
           (
           [ItemCode]
           ,[Size]
           ,[Quantity]
           ,[spec]
           ,[Manufacturer]
           ,[ModelNumber]
           ,[SSUD]
           ,[CostPerUnit]
		   ,[CostByQuantity]
           ,[InstallationPerUnit]           
           ,[CostByInstallationQuantity]
           ,[TotalCost]
		   ,[projectid]
		   ,[Description])

		select 
		final.ItemCode,		
		final.Size,
		final.Quantity,
		final.spec,
		final.Manufacturer,
		final.ModelNumber,
		final.SSUD,
		cost.CostPerUnit,
		final.Quantity*cost.CostPerUnit,
		cost.InstallationPerUnit,
		final.Quantity*cost.InstallationPerUnit,
		final.Quantity*cost.CostPerUnit+final.Quantity*cost.InstallationPerUnit,'''
		+@projid+''',
		cost.[Description]
		From
		(SELECT
			hvo.ItemCode,
			hvo.Size,
			count(prei.PnPID) Quantity,
			hvo.spec,
			replace(prei.Manufacturer,'' '','''') Manufacturer ,
			prei.ModelNumber,
			hvo.SSUD
			FROM
			(SELECT 
			TRIM(replace(ei.ModelNumber,'' '','''')) ModelNumber,
			TRIM(ei.Manufacturer) Manufacturer,
			ei.PnPID
			FROM ['+@DBName+'].[dbo].PnPProject proj
			INNER JOIN ['+@DBName+'].[dbo].EngineeringItems ei ON proj.[Project Details_MICAP] = ei.MICAP) prei
			INNER JOIN
			(SELECT 
			hv.PnPID,
			TRIM(replace(hv.Item_Code,'' '','''')) ItemCode,
			TRIM(replace(hv.SSUD,'' '','''')) SSUD,
			TRIM(hv.Size) Size,
			TRIM(ila.spec) spec
			FROM 
			['+@DBName+'].dbo.[InlineInstruments] hv
			INNER JOIN ['+@DBName+'].dbo.[Instrumentation] ila ON ila.PnPID = hv.PnPID) hvo
			ON prei.PnPID = hvo.PNPID
			GROUP BY 
			prei.ModelNumber,
			replace(prei.Manufacturer,'' '',''''),
			hvo.ItemCode,
			hvo.SSUD,
			hvo.Size,
			hvo.spec) final 
			INNER JOIN dbo.itemwisecostdetails cost ON cost.itemcode = final.ItemCode'
		--print @Query
		exec(@Query)
		FETCH NEXT FROM ProjectDetails INTO @DBName,@projid;
	END;
	CLOSE ProjectDetails;
	DEALLOCATE ProjectDetails;
END



GO
/****** Object:  StoredProcedure [dbo].[GET_MTO_DATA_FOR_ALL]    Script Date: 12/3/20 17:22:40 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[GET_MTO_DATA_FOR_ALL] 
AS
DECLARE @DBName varchar(200);
DECLARE @projid varchar(200);
DECLARE @PipeQuery varchar(max);
DECLARE @OtherQuery varchar(max);
DECLARE @FastnersQuery varchar(max);
DECLARE @DELQuery varchar(max);
DECLARE @MiscQuery varchar(max)
BEGIN
	DECLARE ProjectDetails CURSOR
    FOR SELECT projdatabase,projectid from dbo.projmaster WHERE reporttype='MTO';
	OPEN ProjectDetails;
	FETCH NEXT FROM ProjectDetails INTO @DBName,@projid;
	WHILE @@FETCH_STATUS = 0
    BEGIN
        PRINT @projid;
        
	SET @DELQuery='DELETE FROM [ToolCostingDB].[dbo].[MTOData] WHERE projectid='''+@projid+'''';
	--print @DELQuery
	EXEC(@DELQuery);
	SET @PipeQuery='
		INSERT INTO [ToolCostingDB].[dbo].[MTOData]
           (PackageCode,PackageDescription,LineID,[Service],Quantity,
		    Unit,Size,PackageClass,ItemCode,DescriptionSpec,
			FullExacode,InsulationType,InsulationThickness,Manufacturer,ModelNumber,
			MaterialRate,InstallationRate,ProjectID,TotMaterialRate,TotInstallationRate,Floor,Contractor)

		SELECT 
	
			trans.PackageCode,			
			trans.PackageDescription,
			trans.LineID,
			trans.[Service],
			CASE 
					WHEN comm.Unit = ''mm'' THEN ROUND(trans.Quantity, 2)
					ELSE trans.Quantity
					END Quantity,
			comm.Unit,trans.Size,trans.PackageClass,trans.ItemCode,trans.[Description],
			trans.FullExacode,trans.InsulationType,trans.InsulationThickness,trans.Manufacturer,trans.ModelNumber,
			CASE WHEN comm.MaterialRate is NULL OR LEN(comm.MaterialRate) = 0 THEN 0
				 WHEN trans.PackageDescription=''Liquid(Free Issue)'' THEN 0
					ELSE ROUND(comm.MaterialRate, 2)
					END MaterialRate,
			 CASE WHEN comm.InstallationRate is NULL OR LEN(comm.InstallationRate) = 0 THEN 0
					ELSE ROUND(comm.InstallationRate, 2)
					END InstallationRate,
			'''+@projid+''',
			CASE WHEN comm.MaterialRate is NULL OR LEN(comm.MaterialRate) = 0 THEN 0
				WHEN trans.PackageDescription=''Liquid(Free Issue)'' THEN 0
					ELSE ROUND(trans.Quantity*comm.MaterialRate, 2)
					END TotalMaterialRate,
			CASE WHEN comm.InstallationRate is NULL OR LEN(comm.InstallationRate) = 0 THEN 0
					ELSE ROUND(trans.Quantity*comm.InstallationRate, 2)
					END TotalInstallationRate,
			Floor,
			Contractor
			FROM [ToolCostingDB].[dbo].[CommercialData] comm
			RIGHT OUTER JOIN
		(SELECT 
			eitems.PackageCode,
			eitems.PackageDescription,
			prc.LineID,
			prc.Service,
			CASE WHEN ROUND(SUM(prc.CutLength)/1000, 1)  - (SUM(prc.CutLength)/1000) < 0
				THEN ROUND(SUM(prc.CutLength)/1000, 1) + 0.1
				ELSE ROUND(SUM(prc.CutLength)/1000, 1)
				END AS Quantity,
			eitems.Unit,
			eitems.Size,
			eitems.PackageClass,
			eitems.ItemCode,
			eitems.Description,
			eitems.FullExacode,
			prc.InsulationType,
			prc.InsulationThickness,
			eitems.Manufacturer,
			eitems.ModelNumber,
			eitems.floor,
			eitems.Contractor
			FROM
			(SELECT
					CASE WHEN ei.[ex_T_exa09_PackageCode] is NULL OR LEN(ei.[ex_T_exa09_PackageCode]) = 0 THEN ''''
					ELSE ei.[ex_T_exa09_PackageCode] 
					END PackageCode,
					CASE WHEN ei.[ex_T_exa10_Services] is NULL OR LEN(ei.[ex_T_exa10_Services]) = 0 THEN ''''
					ELSE ei.[ex_T_exa10_Services] 
					END PackageDescription,			
					CASE WHEN ei.[NominalUnit] is NULL OR LEN(ei.[NominalUnit]) = 0 THEN ''''
					ELSE ei.[NominalUnit] 
					END Unit,
					CASE WHEN ei.[NominalDiameter] is NULL OR LEN(ei.[NominalDiameter]) = 0 THEN ''''
					ELSE ei.[NominalDiameter] 
					END Size,
					CASE WHEN ei.spec is NULL OR LEN(ei.spec) = 0 THEN ''''
					ELSE ei.spec 
					END PackageClass,
					CASE WHEN ei.[ItemCode] is NULL OR LEN(ei.[ItemCode]) = 0 THEN ''''
					ELSE REPLACE(REPLACE(ei.ItemCode, CHAR(10), CHAR(32)),CHAR(13), CHAR(32))
					END ItemCode,
					CASE WHEN ei.[PartSizeLongdesc] is NULL OR LEN(ei.[PartSizeLongdesc]) = 0 THEN ''''
					ELSE ei.[PartSizeLongdesc] 
					END Description,
					CASE WHEN ei.[ex_T_exa54_ConcatenatedCode] is NULL OR LEN(ei.[ex_T_exa54_ConcatenatedCode]) = 0 THEN ''''
					ELSE ei.[ex_T_exa54_ConcatenatedCode] 
					END FullExacode,			
					CASE WHEN ei.[Manufacturer] is NULL OR LEN(ei.[Manufacturer]) = 0 THEN ''''
					ELSE ei.[Manufacturer] 
					END Manufacturer,
					ei.PnPID,
					'''' ModelNumber,
					CASE WHEN ei.[ex_T_exa21_Floor] is NULL OR LEN(ei.[ex_T_exa21_Floor]) = 0 THEN ''''
					ELSE ei.[ex_T_exa21_Floor] 
					END Floor,
					CASE WHEN ei.[ex_T_exa11_Contractor] is NULL OR LEN(ei.[ex_T_exa11_Contractor]) = 0 THEN ''''
					ELSE ei.[ex_T_exa11_Contractor] 
					END Contractor
				FROM 
					['+@DBName+'].[dbo].[EngineeringItems] ei 

				WHERE 
					LEN(ei.[ItemCode]) > 0 
					AND LTRIM(RTRIM(ei.[PartCategory]))=''Pipe'' OR LTRIM(RTRIM(ei.[PartCategory]))=''Pipes''
					) eitems
				INNER JOIN 
				(SELECT
					CASE WHEN pr.[LineNumberTag] is NULL OR LEN(pr.[LineNumberTag]) = 0 THEN ''''
					ELSE pr.[LineNumberTag] 
					END LineID,			
					CASE WHEN pr.[Service] is NULL OR LEN(pr.[Service]) = 0 THEN ''''
					ELSE pr.[Service] 
					END Service,
					CASE WHEN pr.[InsulationType] is NULL OR LEN(pr.[InsulationType]) = 0 THEN ''''
					ELSE pr.[InsulationType] 
					END InsulationType,
					CASE WHEN pr.[InsulationThickness] is NULL OR LEN(pr.[InsulationThickness]) = 0 THEN ''''
					ELSE pr.[InsulationThickness] 
					END InsulationThickness,
					pr.PnPID,
					pp.CutLength
				FROM ['+@DBName+'].[dbo].[PipeRunComponent] pr
				INNER JOIN ['+@DBName+'].[dbo].[pipe] pp ON pr.PnPID = pp.PnPID
				) prc 
				ON prc.PnPID = eitems.PnPID


		GROUP BY
			eitems.PackageCode,
			eitems.PackageDescription,
			prc.LineID,
			prc.Service,
			eitems.Unit,
			eitems.Size,
			eitems.PackageClass,
			eitems.ItemCode,
			eitems.Description,
			eitems.FullExacode,
			prc.InsulationType,
			prc.InsulationThickness,
			eitems.Manufacturer,
			eitems.ModelNumber,
			eitems.Floor,
			eitems.Contractor)
			trans 
		ON comm.ItemCode = trans.ItemCode'
		--print @PipeQuery
		exec(@PipeQuery)

SET @OtherQuery='
		INSERT INTO [ToolCostingDB].[dbo].[MTOData]
           (PackageCode,PackageDescription,LineID,[Service],Quantity,
		    Unit,Size,PackageClass,ItemCode,DescriptionSpec,
			FullExacode,InsulationType,InsulationThickness,Manufacturer,ModelNumber,
			MaterialRate,InstallationRate,ProjectID,TotMaterialRate,TotInstallationRate,floor,Contractor)

		SELECT 
	
			trans.PackageCode,
			trans.PackageDescription,
			trans.LineID,
			trans.[Service],
			CASE 
					WHEN comm.Unit = ''mm'' THEN ROUND(trans.Quantity, 2)
					ELSE trans.Quantity
					END Quantity,
			comm.Unit,trans.Size,trans.PackageClass,trans.ItemCode,trans.[Description],
			trans.FullExacode,trans.InsulationType,trans.InsulationThickness,trans.Manufacturer,trans.ModelNumber,
			CASE WHEN comm.MaterialRate is NULL OR LEN(comm.MaterialRate) = 0 THEN 0
				WHEN trans.PackageDescription=''Liquid(Free Issue)'' THEN 0
					ELSE ROUND(comm.MaterialRate, 2)
					END MaterialRate,
			 CASE WHEN comm.InstallationRate is NULL OR LEN(comm.InstallationRate) = 0 THEN 0
					ELSE ROUND(comm.InstallationRate, 2)
					END InstallationRate,
			'''+@projid+''',
			CASE WHEN comm.MaterialRate is NULL OR LEN(comm.MaterialRate) = 0 THEN 0
				WHEN trans.PackageDescription=''Liquid(Free Issue)'' THEN 0
					ELSE ROUND(trans.Quantity*comm.MaterialRate, 2)
					END TotalMaterialRate,
			CASE WHEN comm.InstallationRate is NULL OR LEN(comm.InstallationRate) = 0 THEN 0
					ELSE ROUND(trans.Quantity*comm.InstallationRate, 2)
					END TotalInstallationRate,
			Floor,
			Contractor
			FROM [ToolCostingDB].[dbo].[CommercialData] comm
			RIGHT OUTER JOIN
		(
		SELECT 
			eitems.PackageCode,
			eitems.PackageDescription,
			prc.LineID,
			prc.Service,
			COUNT(eitems.PackageCode) Quantity,
			eitems.Unit,
			eitems.Size,
			eitems.PackageClass,
			eitems.ItemCode,
			eitems.Description,
			eitems.FullExacode,
			prc.InsulationType,
			prc.InsulationThickness,
			eitems.Manufacturer,
			eitems.ModelNumber,
			eitems.Floor,
			eitems.Contractor
			FROM
			(SELECT
					CASE WHEN ei.[ex_T_exa09_PackageCode] is NULL OR LEN(ei.[ex_T_exa09_PackageCode]) = 0 THEN ''''
					ELSE ei.[ex_T_exa09_PackageCode] 
					END PackageCode,
					CASE WHEN ei.[ex_T_exa10_Services] is NULL OR LEN(ei.[ex_T_exa10_Services]) = 0 THEN ''''
					ELSE ei.[ex_T_exa10_Services] 
					END PackageDescription,			
					CASE WHEN ei.[NominalUnit] is NULL OR LEN(ei.[NominalUnit]) = 0 THEN ''''
					ELSE ei.[NominalUnit] 
					END Unit,
					CASE WHEN ei.[NominalDiameter] is NULL OR LEN(ei.[NominalDiameter]) = 0 THEN ''''
					ELSE ei.[NominalDiameter] 
					END Size,
					CASE WHEN ei.spec is NULL OR LEN(ei.spec) = 0 THEN ''''
					ELSE ei.spec 
					END PackageClass,
					CASE WHEN ei.[ItemCode] is NULL OR LEN(ei.[ItemCode]) = 0 THEN ''''
					ELSE REPLACE(REPLACE(ei.ItemCode, CHAR(10), CHAR(32)),CHAR(13), CHAR(32)) 
					END ItemCode,
					CASE WHEN ei.[PartSizeLongdesc] is NULL OR LEN(ei.[PartSizeLongdesc]) = 0 THEN ''''
					ELSE ei.[PartSizeLongdesc] 
					END Description,
					CASE WHEN ei.[ex_T_exa54_ConcatenatedCode] is NULL OR LEN(ei.[ex_T_exa54_ConcatenatedCode]) = 0 THEN ''''
					ELSE ei.[ex_T_exa54_ConcatenatedCode] 
					END FullExacode,			
					CASE WHEN ei.[Manufacturer] is NULL OR LEN(ei.[Manufacturer]) = 0 THEN ''''
					ELSE ei.[Manufacturer] 
					END Manufacturer,
					ei.PnPID,
					'''' ModelNumber,
					CASE WHEN ei.[ex_T_exa21_Floor] is NULL OR LEN(ei.[ex_T_exa21_Floor]) = 0 THEN ''''
					ELSE ei.[ex_T_exa21_Floor] 
					END Floor,
					CASE WHEN ei.[ex_T_exa11_Contractor] is NULL OR LEN(ei.[ex_T_exa11_Contractor]) = 0 THEN ''''
					ELSE ei.[ex_T_exa11_Contractor] 
					END Contractor
				FROM 
					['+@DBName+'].[dbo].[EngineeringItems] ei 

				WHERE 
					LEN(ei.[ItemCode]) > 0 
					AND LTRIM(RTRIM(ei.[PartCategory])) !=''Pipe'' AND LTRIM(RTRIM(ei.[PartCategory])) !=''Fasteners'' AND LTRIM(RTRIM(ei.[PartCategory])) != ''Pipes''
					) eitems
				INNER JOIN 
				(SELECT
					CASE WHEN pr.[LineNumberTag] is NULL OR LEN(pr.[LineNumberTag]) = 0 THEN ''''
					ELSE pr.[LineNumberTag] 
					END LineID,			
					CASE WHEN pr.[Service] is NULL OR LEN(pr.[Service]) = 0 THEN ''''
					ELSE pr.[Service] 
					END Service,
					CASE WHEN pr.[InsulationType] is NULL OR LEN(pr.[InsulationType]) = 0 THEN ''''
					ELSE pr.[InsulationType] 
					END InsulationType,
					CASE WHEN pr.[InsulationThickness] is NULL OR LEN(pr.[InsulationThickness]) = 0 THEN ''''
					ELSE pr.[InsulationThickness] 
					END InsulationThickness,
					pr.PnPID
				FROM ['+@DBName+'].[dbo].[PipeRunComponent] pr
				) prc 
				ON prc.PnPID = eitems.PnPID


		GROUP BY
			eitems.PackageCode,
			eitems.PackageDescription,
			prc.LineID,
			prc.Service,
			eitems.Unit,
			eitems.Size,
			eitems.PackageClass,
			eitems.ItemCode,
			eitems.Description,
			eitems.FullExacode,
			prc.InsulationType,
			prc.InsulationThickness,
			eitems.Manufacturer,
			eitems.ModelNumber,
			eitems.Floor,
			eitems.Contractor)
			trans 
		ON comm.ItemCode = trans.ItemCode'
		--print @PipeQuery
		exec(@OtherQuery)

SET @FastnersQuery='
		INSERT INTO [ToolCostingDB].[dbo].[MTOData]
           (PackageCode,PackageDescription,LineID,[Service],Quantity,
		    Unit,Size,PackageClass,ItemCode,DescriptionSpec,
			FullExacode,InsulationType,InsulationThickness,Manufacturer,ModelNumber,
			MaterialRate,InstallationRate,ProjectID,TotMaterialRate,TotInstallationRate,Floor,Contractor)

		SELECT 
	
			trans.PackageCode,
			trans.PackageDescription,
			trans.LineID,
			trans.[Service],
			CASE 
					WHEN comm.Unit = ''mm'' THEN ROUND(trans.Quantity, 2)
					ELSE trans.Quantity
					END Quantity,
			comm.Unit,trans.Size,trans.PackageClass,trans.ItemCode,trans.[Description],
			trans.FullExacode,trans.InsulationType,trans.InsulationThickness,trans.Manufacturer,trans.ModelNumber,
			CASE WHEN comm.MaterialRate is NULL OR LEN(comm.MaterialRate) = 0 THEN 0
			WHEN trans.PackageDescription=''Liquid(Free Issue)'' THEN 0
					ELSE ROUND(comm.MaterialRate, 2)
					END MaterialRate,
			 CASE WHEN comm.InstallationRate is NULL OR LEN(comm.InstallationRate) = 0 THEN 0
					ELSE ROUND(comm.InstallationRate, 2)
					END InstallationRate,
			'''+@projid+''',
			CASE WHEN comm.MaterialRate is NULL OR LEN(comm.MaterialRate) = 0 THEN 0
				WHEN trans.PackageDescription=''Liquid(Free Issue)'' THEN 0
					ELSE ROUND(trans.Quantity*comm.MaterialRate, 2)
					END TotalMaterialRate,
			CASE WHEN comm.InstallationRate is NULL OR LEN(comm.InstallationRate) = 0 THEN 0
					ELSE ROUND(trans.Quantity*comm.InstallationRate, 2)
					END TotalInstallationRate,
			Floor,
			Contractor
			FROM [ToolCostingDB].[dbo].[CommercialData] comm
			RIGHT OUTER JOIN
		(
	SELECT 
			eitems.PackageCode,
			eitems.PackageDescription,
			prc.LineID,
			prc.Service,
			COUNT(eitems.PackageCode) Quantity,
			eitems.Unit,
			eitems.Size,
			eitems.PackageClass,
			eitems.ItemCode,
			eitems.Description,
			eitems.FullExacode,
			prc.InsulationType,
			prc.InsulationThickness,
			eitems.Manufacturer,
			eitems.ModelNumber,
			eitems.Floor,
			eitems.Contractor
			FROM
			(SELECT
					CASE WHEN ei.[ex_T_exa09_PackageCode] is NULL OR LEN(ei.[ex_T_exa09_PackageCode]) = 0 THEN ''''
					ELSE ei.[ex_T_exa09_PackageCode] 
					END PackageCode,
					CASE WHEN ei.[ex_T_exa10_Services] is NULL OR LEN(ei.[ex_T_exa10_Services]) = 0 THEN ''''
					ELSE ei.[ex_T_exa10_Services] 
					END PackageDescription,			
					CASE WHEN ei.[NominalUnit] is NULL OR LEN(ei.[NominalUnit]) = 0 THEN ''''
					ELSE ei.[NominalUnit] 
					END Unit,
					CASE WHEN ei.[NominalDiameter] is NULL OR LEN(ei.[NominalDiameter]) = 0 THEN ''''
					ELSE ei.[NominalDiameter] 
					END Size,
					CASE WHEN ei.spec is NULL OR LEN(ei.spec) = 0 THEN ''''
					ELSE ei.spec 
					END PackageClass,
					CASE WHEN ei.[ItemCode] is NULL OR LEN(ei.[ItemCode]) = 0 THEN ''''
					ELSE REPLACE(REPLACE(ei.ItemCode, CHAR(10), CHAR(32)),CHAR(13), CHAR(32)) 
					END ItemCode,
					CASE WHEN ei.[PartSizeLongdesc] is NULL OR LEN(ei.[PartSizeLongdesc]) = 0 THEN ''''
					ELSE ei.[PartSizeLongdesc] 
					END Description,
					CASE WHEN ei.[ex_T_exa54_ConcatenatedCode] is NULL OR LEN(ei.[ex_T_exa54_ConcatenatedCode]) = 0 THEN ''''
					ELSE ei.[ex_T_exa54_ConcatenatedCode] 
					END FullExacode,			
					CASE WHEN ei.[Manufacturer] is NULL OR LEN(ei.[Manufacturer]) = 0 THEN ''''
					ELSE ei.[Manufacturer] 
					END Manufacturer,
					ei.PnPID,
					'''' ModelNumber,
					CASE WHEN ei.[ex_T_exa21_Floor] is NULL OR LEN(ei.[ex_T_exa21_Floor]) = 0 THEN ''''
					ELSE ei.[ex_T_exa21_Floor] 
					END Floor,
					CASE WHEN ei.[ex_T_exa11_Contractor] is NULL OR LEN(ei.[ex_T_exa11_Contractor]) = 0 THEN ''''
					ELSE ei.[ex_T_exa11_Contractor] 
					END Contractor
				FROM 
					['+@DBName+'].[dbo].[EngineeringItems] ei 

				WHERE 
					LEN(ei.[ItemCode]) > 0 
					AND LTRIM(RTRIM(ei.[PartCategory])) =''Fasteners''
					) eitems
				INNER JOIN 
				(SELECT
					CASE WHEN fst.[LineNumberTag] is NULL OR LEN(fst.[LineNumberTag]) = 0 THEN ''''
					ELSE fst.[LineNumberTag] 
					END LineID,			
					CASE WHEN fst.[Service] is NULL OR LEN(fst.[Service]) = 0 THEN ''''
					ELSE fst.[Service] 
					END Service,
					CASE WHEN fst.[InsulationType] is NULL OR LEN(fst.[InsulationType]) = 0 THEN ''''
					ELSE fst.[InsulationType] 
					END InsulationType,
					CASE WHEN fst.[InsulationThickness] is NULL OR LEN(fst.[InsulationThickness]) = 0 THEN ''''
					ELSE fst.[InsulationThickness] 
					END InsulationThickness,
					fst.PnPID
				FROM ['+@DBName+'].[dbo].[FASTENERS] fst
				) prc 
				ON prc.PnPID = eitems.PnPID


		GROUP BY
			eitems.PackageCode,
			eitems.PackageDescription,
			prc.LineID,
			prc.Service,
			eitems.Unit,
			eitems.Size,
			eitems.PackageClass,
			eitems.ItemCode,
			eitems.Description,
			eitems.FullExacode,
			prc.InsulationType,
			prc.InsulationThickness,
			eitems.Manufacturer,
			eitems.ModelNumber,
			eitems.Floor,
			eitems.Contractor
		)trans 
		ON comm.ItemCode = trans.ItemCode'
--print @PipeQuery
exec(@FastnersQuery)


SET @MiscQuery=      'INSERT INTO [ToolCostingDB].[dbo].[MTOData]
           (PackageCode,PackageDescription,LineID,[Service],Quantity,
                  Unit,Size,PackageClass,ItemCode,DescriptionSpec,
              FullExacode,InsulationType,InsulationThickness,Manufacturer,ModelNumber,
              MaterialRate,InstallationRate,ProjectID,TotMaterialRate,TotInstallationRate)
              SELECT
              packagecode,packagedesc,
       '''','''',1,'''','''','''',itemcode,packagedesc,'''','''','''','''','''',cost,0,'''+@projid+''',cost,0
              FROM MTOMiscData WHERE projectid='''+@projid+''''
              exec(@MiscQuery)



		FETCH NEXT FROM ProjectDetails INTO @DBName,@projid;
	END;
	CLOSE ProjectDetails;
	DEALLOCATE ProjectDetails;
END



GO
/****** Object:  StoredProcedure [dbo].[GET_MTO_DATA_FOR_DB]    Script Date: 12/3/20 17:22:40 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[GET_MTO_DATA_FOR_DB] @projidinput varchar(50)
AS
DECLARE @DBName varchar(200);
DECLARE @projid varchar(200);
DECLARE @PipeQuery varchar(max);
DECLARE @OtherQuery varchar(max);
DECLARE @FastnersQuery varchar(max);
DECLARE @DELQuery varchar(max);
DECLARE @MiscQuery varchar(max)
BEGIN
	DECLARE ProjectDetails CURSOR
    FOR SELECT projdatabase,projectid from dbo.projmaster WHERE reporttype='MTO' AND projectid=@projidinput;
	OPEN ProjectDetails;
	FETCH NEXT FROM ProjectDetails INTO @DBName,@projid;
	WHILE @@FETCH_STATUS = 0
    BEGIN
        PRINT @projid;
        
	SET @DELQuery='DELETE FROM [ToolCostingDB].[dbo].[MTOData] WHERE projectid='''+@projid+'''';
	--print @DELQuery
	EXEC(@DELQuery);
	SET @PipeQuery='
		INSERT INTO [ToolCostingDB].[dbo].[MTOData]
           (PackageCode,PackageDescription,LineID,[Service],Quantity,
		    Unit,Size,PackageClass,ItemCode,DescriptionSpec,
			FullExacode,InsulationType,InsulationThickness,Manufacturer,ModelNumber,
			MaterialRate,InstallationRate,ProjectID,TotMaterialRate,TotInstallationRate,Floor,Contractor)

		SELECT 
	
			trans.PackageCode,			
			trans.PackageDescription,
			trans.LineID,
			trans.[Service],
			CASE 
					WHEN comm.Unit = ''mm'' THEN ROUND(trans.Quantity, 2)
					ELSE trans.Quantity
					END Quantity,
			comm.Unit,trans.Size,trans.PackageClass,trans.ItemCode,trans.[Description],
			trans.FullExacode,trans.InsulationType,trans.InsulationThickness,trans.Manufacturer,trans.ModelNumber,
			CASE WHEN comm.MaterialRate is NULL OR LEN(comm.MaterialRate) = 0 THEN 0
				 WHEN trans.PackageDescription=''Liquid(Free Issue)'' THEN 0
					ELSE ROUND(comm.MaterialRate, 2)
					END MaterialRate,
			 CASE WHEN comm.InstallationRate is NULL OR LEN(comm.InstallationRate) = 0 THEN 0
					ELSE ROUND(comm.InstallationRate, 2)
					END InstallationRate,
			'''+@projid+''',
			CASE WHEN comm.MaterialRate is NULL OR LEN(comm.MaterialRate) = 0 THEN 0
				WHEN trans.PackageDescription=''Liquid(Free Issue)'' THEN 0
					ELSE ROUND(trans.Quantity*comm.MaterialRate, 2)
					END TotalMaterialRate,
			CASE WHEN comm.InstallationRate is NULL OR LEN(comm.InstallationRate) = 0 THEN 0
					ELSE ROUND(trans.Quantity*comm.InstallationRate, 2)
					END TotalInstallationRate,
			Floor,
			Contractor
			FROM [ToolCostingDB].[dbo].[CommercialData] comm
			RIGHT OUTER JOIN
		(SELECT 
			eitems.PackageCode,
			eitems.PackageDescription,
			prc.LineID,
			prc.Service,
			CASE WHEN ROUND(SUM(prc.CutLength)/1000, 1)  - (SUM(prc.CutLength)/1000) < 0
				THEN ROUND(SUM(prc.CutLength)/1000, 1) + 0.1
				ELSE ROUND(SUM(prc.CutLength)/1000, 1)
				END AS Quantity,
			eitems.Unit,
			eitems.Size,
			eitems.PackageClass,
			eitems.ItemCode,
			eitems.Description,
			eitems.FullExacode,
			prc.InsulationType,
			prc.InsulationThickness,
			eitems.Manufacturer,
			eitems.ModelNumber,
			eitems.floor,
			eitems.Contractor
			FROM
			(SELECT
					CASE WHEN ei.[ex_T_exa09_PackageCode] is NULL OR LEN(ei.[ex_T_exa09_PackageCode]) = 0 THEN ''''
					ELSE ei.[ex_T_exa09_PackageCode] 
					END PackageCode,
					CASE WHEN ei.[ex_T_exa10_Services] is NULL OR LEN(ei.[ex_T_exa10_Services]) = 0 THEN ''''
					ELSE ei.[ex_T_exa10_Services] 
					END PackageDescription,			
					CASE WHEN ei.[NominalUnit] is NULL OR LEN(ei.[NominalUnit]) = 0 THEN ''''
					ELSE ei.[NominalUnit] 
					END Unit,
					CASE WHEN ei.[NominalDiameter] is NULL OR LEN(ei.[NominalDiameter]) = 0 THEN ''''
					ELSE ei.[NominalDiameter] 
					END Size,
					CASE WHEN ei.spec is NULL OR LEN(ei.spec) = 0 THEN ''''
					ELSE ei.spec 
					END PackageClass,
					CASE WHEN ei.[ItemCode] is NULL OR LEN(ei.[ItemCode]) = 0 THEN ''''
					ELSE REPLACE(REPLACE(ei.ItemCode, CHAR(10), CHAR(32)),CHAR(13), CHAR(32))
					END ItemCode,
					CASE WHEN ei.[PartSizeLongdesc] is NULL OR LEN(ei.[PartSizeLongdesc]) = 0 THEN ''''
					ELSE ei.[PartSizeLongdesc] 
					END Description,
					CASE WHEN ei.[ex_T_exa54_ConcatenatedCode] is NULL OR LEN(ei.[ex_T_exa54_ConcatenatedCode]) = 0 THEN ''''
					ELSE ei.[ex_T_exa54_ConcatenatedCode] 
					END FullExacode,			
					CASE WHEN ei.[Manufacturer] is NULL OR LEN(ei.[Manufacturer]) = 0 THEN ''''
					ELSE ei.[Manufacturer] 
					END Manufacturer,
					ei.PnPID,
					'''' ModelNumber,
					CASE WHEN ei.[ex_T_exa21_Floor] is NULL OR LEN(ei.[ex_T_exa21_Floor]) = 0 THEN ''''
					ELSE ei.[ex_T_exa21_Floor] 
					END Floor,
					CASE WHEN ei.[ex_T_exa11_Contractor] is NULL OR LEN(ei.[ex_T_exa11_Contractor]) = 0 THEN ''''
					ELSE ei.[ex_T_exa11_Contractor] 
					END Contractor
				FROM 
					['+@DBName+'].[dbo].[EngineeringItems] ei 

				WHERE 
					LEN(ei.[ItemCode]) > 0 
					AND LTRIM(RTRIM(ei.[PartCategory]))=''Pipe'' OR LTRIM(RTRIM(ei.[PartCategory]))=''Pipes''
					) eitems
				INNER JOIN 
				(SELECT
					CASE WHEN pr.[LineNumberTag] is NULL OR LEN(pr.[LineNumberTag]) = 0 THEN ''''
					ELSE pr.[LineNumberTag] 
					END LineID,			
					CASE WHEN pr.[Service] is NULL OR LEN(pr.[Service]) = 0 THEN ''''
					ELSE pr.[Service] 
					END Service,
					CASE WHEN pr.[InsulationType] is NULL OR LEN(pr.[InsulationType]) = 0 THEN ''''
					ELSE pr.[InsulationType] 
					END InsulationType,
					CASE WHEN pr.[InsulationThickness] is NULL OR LEN(pr.[InsulationThickness]) = 0 THEN ''''
					ELSE pr.[InsulationThickness] 
					END InsulationThickness,
					pr.PnPID,
					pp.CutLength
				FROM ['+@DBName+'].[dbo].[PipeRunComponent] pr
				INNER JOIN ['+@DBName+'].[dbo].[pipe] pp ON pr.PnPID = pp.PnPID
				) prc 
				ON prc.PnPID = eitems.PnPID


		GROUP BY
			eitems.PackageCode,
			eitems.PackageDescription,
			prc.LineID,
			prc.Service,
			eitems.Unit,
			eitems.Size,
			eitems.PackageClass,
			eitems.ItemCode,
			eitems.Description,
			eitems.FullExacode,
			prc.InsulationType,
			prc.InsulationThickness,
			eitems.Manufacturer,
			eitems.ModelNumber,
			eitems.Floor,
			eitems.Contractor)
			trans 
		ON comm.ItemCode = trans.ItemCode'
		--print @PipeQuery
		exec(@PipeQuery)

SET @OtherQuery='
		INSERT INTO [ToolCostingDB].[dbo].[MTOData]
           (PackageCode,PackageDescription,LineID,[Service],Quantity,
		    Unit,Size,PackageClass,ItemCode,DescriptionSpec,
			FullExacode,InsulationType,InsulationThickness,Manufacturer,ModelNumber,
			MaterialRate,InstallationRate,ProjectID,TotMaterialRate,TotInstallationRate,floor,Contractor)

		SELECT 
	
			trans.PackageCode,
			trans.PackageDescription,
			trans.LineID,
			trans.[Service],
			CASE 
					WHEN comm.Unit = ''mm'' THEN ROUND(trans.Quantity, 2)
					ELSE trans.Quantity
					END Quantity,
			comm.Unit,trans.Size,trans.PackageClass,trans.ItemCode,trans.[Description],
			trans.FullExacode,trans.InsulationType,trans.InsulationThickness,trans.Manufacturer,trans.ModelNumber,
			CASE WHEN comm.MaterialRate is NULL OR LEN(comm.MaterialRate) = 0 THEN 0
				WHEN trans.PackageDescription=''Liquid(Free Issue)'' THEN 0
					ELSE ROUND(comm.MaterialRate, 2)
					END MaterialRate,
			 CASE WHEN comm.InstallationRate is NULL OR LEN(comm.InstallationRate) = 0 THEN 0
					ELSE ROUND(comm.InstallationRate, 2)
					END InstallationRate,
			'''+@projid+''',
			CASE WHEN comm.MaterialRate is NULL OR LEN(comm.MaterialRate) = 0 THEN 0
				WHEN trans.PackageDescription=''Liquid(Free Issue)'' THEN 0
					ELSE ROUND(trans.Quantity*comm.MaterialRate, 2)
					END TotalMaterialRate,
			CASE WHEN comm.InstallationRate is NULL OR LEN(comm.InstallationRate) = 0 THEN 0
					ELSE ROUND(trans.Quantity*comm.InstallationRate, 2)
					END TotalInstallationRate,
			Floor,
			Contractor
			FROM [ToolCostingDB].[dbo].[CommercialData] comm
			RIGHT OUTER JOIN
		(
		SELECT 
			eitems.PackageCode,
			eitems.PackageDescription,
			prc.LineID,
			prc.Service,
			COUNT(eitems.PackageCode) Quantity,
			eitems.Unit,
			eitems.Size,
			eitems.PackageClass,
			eitems.ItemCode,
			eitems.Description,
			eitems.FullExacode,
			prc.InsulationType,
			prc.InsulationThickness,
			eitems.Manufacturer,
			eitems.ModelNumber,
			eitems.Floor,
			eitems.Contractor
			FROM
			(SELECT
					CASE WHEN ei.[ex_T_exa09_PackageCode] is NULL OR LEN(ei.[ex_T_exa09_PackageCode]) = 0 THEN ''''
					ELSE ei.[ex_T_exa09_PackageCode] 
					END PackageCode,
					CASE WHEN ei.[ex_T_exa10_Services] is NULL OR LEN(ei.[ex_T_exa10_Services]) = 0 THEN ''''
					ELSE ei.[ex_T_exa10_Services] 
					END PackageDescription,			
					CASE WHEN ei.[NominalUnit] is NULL OR LEN(ei.[NominalUnit]) = 0 THEN ''''
					ELSE ei.[NominalUnit] 
					END Unit,
					CASE WHEN ei.[NominalDiameter] is NULL OR LEN(ei.[NominalDiameter]) = 0 THEN ''''
					ELSE ei.[NominalDiameter] 
					END Size,
					CASE WHEN ei.spec is NULL OR LEN(ei.spec) = 0 THEN ''''
					ELSE ei.spec 
					END PackageClass,
					CASE WHEN ei.[ItemCode] is NULL OR LEN(ei.[ItemCode]) = 0 THEN ''''
					ELSE REPLACE(REPLACE(ei.ItemCode, CHAR(10), CHAR(32)),CHAR(13), CHAR(32)) 
					END ItemCode,
					CASE WHEN ei.[PartSizeLongdesc] is NULL OR LEN(ei.[PartSizeLongdesc]) = 0 THEN ''''
					ELSE ei.[PartSizeLongdesc] 
					END Description,
					CASE WHEN ei.[ex_T_exa54_ConcatenatedCode] is NULL OR LEN(ei.[ex_T_exa54_ConcatenatedCode]) = 0 THEN ''''
					ELSE ei.[ex_T_exa54_ConcatenatedCode] 
					END FullExacode,			
					CASE WHEN ei.[Manufacturer] is NULL OR LEN(ei.[Manufacturer]) = 0 THEN ''''
					ELSE ei.[Manufacturer] 
					END Manufacturer,
					ei.PnPID,
					'''' ModelNumber,
					CASE WHEN ei.[ex_T_exa21_Floor] is NULL OR LEN(ei.[ex_T_exa21_Floor]) = 0 THEN ''''
					ELSE ei.[ex_T_exa21_Floor] 
					END Floor,
					CASE WHEN ei.[ex_T_exa11_Contractor] is NULL OR LEN(ei.[ex_T_exa11_Contractor]) = 0 THEN ''''
					ELSE ei.[ex_T_exa11_Contractor] 
					END Contractor
				FROM 
					['+@DBName+'].[dbo].[EngineeringItems] ei 

				WHERE 
					LEN(ei.[ItemCode]) > 0 
					AND LTRIM(RTRIM(ei.[PartCategory])) !=''Pipe'' AND LTRIM(RTRIM(ei.[PartCategory])) !=''Fasteners'' AND LTRIM(RTRIM(ei.[PartCategory])) != ''Pipes''
					) eitems
				INNER JOIN 
				(SELECT
					CASE WHEN pr.[LineNumberTag] is NULL OR LEN(pr.[LineNumberTag]) = 0 THEN ''''
					ELSE pr.[LineNumberTag] 
					END LineID,			
					CASE WHEN pr.[Service] is NULL OR LEN(pr.[Service]) = 0 THEN ''''
					ELSE pr.[Service] 
					END Service,
					CASE WHEN pr.[InsulationType] is NULL OR LEN(pr.[InsulationType]) = 0 THEN ''''
					ELSE pr.[InsulationType] 
					END InsulationType,
					CASE WHEN pr.[InsulationThickness] is NULL OR LEN(pr.[InsulationThickness]) = 0 THEN ''''
					ELSE pr.[InsulationThickness] 
					END InsulationThickness,
					pr.PnPID
				FROM ['+@DBName+'].[dbo].[PipeRunComponent] pr
				) prc 
				ON prc.PnPID = eitems.PnPID


		GROUP BY
			eitems.PackageCode,
			eitems.PackageDescription,
			prc.LineID,
			prc.Service,
			eitems.Unit,
			eitems.Size,
			eitems.PackageClass,
			eitems.ItemCode,
			eitems.Description,
			eitems.FullExacode,
			prc.InsulationType,
			prc.InsulationThickness,
			eitems.Manufacturer,
			eitems.ModelNumber,
			eitems.Floor,
			eitems.Contractor)
			trans 
		ON comm.ItemCode = trans.ItemCode'
		--print @PipeQuery
		exec(@OtherQuery)

SET @FastnersQuery='
		INSERT INTO [ToolCostingDB].[dbo].[MTOData]
           (PackageCode,PackageDescription,LineID,[Service],Quantity,
		    Unit,Size,PackageClass,ItemCode,DescriptionSpec,
			FullExacode,InsulationType,InsulationThickness,Manufacturer,ModelNumber,
			MaterialRate,InstallationRate,ProjectID,TotMaterialRate,TotInstallationRate,Floor,Contractor)

		SELECT 
	
			trans.PackageCode,
			trans.PackageDescription,
			trans.LineID,
			trans.[Service],
			CASE 
					WHEN comm.Unit = ''mm'' THEN ROUND(trans.Quantity, 2)
					ELSE trans.Quantity
					END Quantity,
			comm.Unit,trans.Size,trans.PackageClass,trans.ItemCode,trans.[Description],
			trans.FullExacode,trans.InsulationType,trans.InsulationThickness,trans.Manufacturer,trans.ModelNumber,
			CASE WHEN comm.MaterialRate is NULL OR LEN(comm.MaterialRate) = 0 THEN 0
			WHEN trans.PackageDescription=''Liquid(Free Issue)'' THEN 0
					ELSE ROUND(comm.MaterialRate, 2)
					END MaterialRate,
			 CASE WHEN comm.InstallationRate is NULL OR LEN(comm.InstallationRate) = 0 THEN 0
					ELSE ROUND(comm.InstallationRate, 2)
					END InstallationRate,
			'''+@projid+''',
			CASE WHEN comm.MaterialRate is NULL OR LEN(comm.MaterialRate) = 0 THEN 0
				WHEN trans.PackageDescription=''Liquid(Free Issue)'' THEN 0
					ELSE ROUND(trans.Quantity*comm.MaterialRate, 2)
					END TotalMaterialRate,
			CASE WHEN comm.InstallationRate is NULL OR LEN(comm.InstallationRate) = 0 THEN 0
					ELSE ROUND(trans.Quantity*comm.InstallationRate, 2)
					END TotalInstallationRate,
			Floor,
			Contractor
			FROM [ToolCostingDB].[dbo].[CommercialData] comm
			RIGHT OUTER JOIN
		(
	SELECT 
			eitems.PackageCode,
			eitems.PackageDescription,
			prc.LineID,
			prc.Service,
			COUNT(eitems.PackageCode) Quantity,
			eitems.Unit,
			eitems.Size,
			eitems.PackageClass,
			eitems.ItemCode,
			eitems.Description,
			eitems.FullExacode,
			prc.InsulationType,
			prc.InsulationThickness,
			eitems.Manufacturer,
			eitems.ModelNumber,
			eitems.Floor,
			eitems.Contractor
			FROM
			(SELECT
					CASE WHEN ei.[ex_T_exa09_PackageCode] is NULL OR LEN(ei.[ex_T_exa09_PackageCode]) = 0 THEN ''''
					ELSE ei.[ex_T_exa09_PackageCode] 
					END PackageCode,
					CASE WHEN ei.[ex_T_exa10_Services] is NULL OR LEN(ei.[ex_T_exa10_Services]) = 0 THEN ''''
					ELSE ei.[ex_T_exa10_Services] 
					END PackageDescription,			
					CASE WHEN ei.[NominalUnit] is NULL OR LEN(ei.[NominalUnit]) = 0 THEN ''''
					ELSE ei.[NominalUnit] 
					END Unit,
					CASE WHEN ei.[NominalDiameter] is NULL OR LEN(ei.[NominalDiameter]) = 0 THEN ''''
					ELSE ei.[NominalDiameter] 
					END Size,
					CASE WHEN ei.spec is NULL OR LEN(ei.spec) = 0 THEN ''''
					ELSE ei.spec 
					END PackageClass,
					CASE WHEN ei.[ItemCode] is NULL OR LEN(ei.[ItemCode]) = 0 THEN ''''
					ELSE REPLACE(REPLACE(ei.ItemCode, CHAR(10), CHAR(32)),CHAR(13), CHAR(32)) 
					END ItemCode,
					CASE WHEN ei.[PartSizeLongdesc] is NULL OR LEN(ei.[PartSizeLongdesc]) = 0 THEN ''''
					ELSE ei.[PartSizeLongdesc] 
					END Description,
					CASE WHEN ei.[ex_T_exa54_ConcatenatedCode] is NULL OR LEN(ei.[ex_T_exa54_ConcatenatedCode]) = 0 THEN ''''
					ELSE ei.[ex_T_exa54_ConcatenatedCode] 
					END FullExacode,			
					CASE WHEN ei.[Manufacturer] is NULL OR LEN(ei.[Manufacturer]) = 0 THEN ''''
					ELSE ei.[Manufacturer] 
					END Manufacturer,
					ei.PnPID,
					'''' ModelNumber,
					CASE WHEN ei.[ex_T_exa21_Floor] is NULL OR LEN(ei.[ex_T_exa21_Floor]) = 0 THEN ''''
					ELSE ei.[ex_T_exa21_Floor] 
					END Floor,
					CASE WHEN ei.[ex_T_exa11_Contractor] is NULL OR LEN(ei.[ex_T_exa11_Contractor]) = 0 THEN ''''
					ELSE ei.[ex_T_exa11_Contractor] 
					END Contractor
				FROM 
					['+@DBName+'].[dbo].[EngineeringItems] ei 

				WHERE 
					LEN(ei.[ItemCode]) > 0 
					AND LTRIM(RTRIM(ei.[PartCategory])) =''Fasteners''
					) eitems
				INNER JOIN 
				(SELECT
					CASE WHEN fst.[LineNumberTag] is NULL OR LEN(fst.[LineNumberTag]) = 0 THEN ''''
					ELSE fst.[LineNumberTag] 
					END LineID,			
					CASE WHEN fst.[Service] is NULL OR LEN(fst.[Service]) = 0 THEN ''''
					ELSE fst.[Service] 
					END Service,
					CASE WHEN fst.[InsulationType] is NULL OR LEN(fst.[InsulationType]) = 0 THEN ''''
					ELSE fst.[InsulationType] 
					END InsulationType,
					CASE WHEN fst.[InsulationThickness] is NULL OR LEN(fst.[InsulationThickness]) = 0 THEN ''''
					ELSE fst.[InsulationThickness] 
					END InsulationThickness,
					fst.PnPID
				FROM ['+@DBName+'].[dbo].[FASTENERS] fst
				) prc 
				ON prc.PnPID = eitems.PnPID


		GROUP BY
			eitems.PackageCode,
			eitems.PackageDescription,
			prc.LineID,
			prc.Service,
			eitems.Unit,
			eitems.Size,
			eitems.PackageClass,
			eitems.ItemCode,
			eitems.Description,
			eitems.FullExacode,
			prc.InsulationType,
			prc.InsulationThickness,
			eitems.Manufacturer,
			eitems.ModelNumber,
			eitems.Floor,
			eitems.Contractor
		)trans 
		ON comm.ItemCode = trans.ItemCode'
--print @PipeQuery
exec(@FastnersQuery)


SET @MiscQuery=      'INSERT INTO [ToolCostingDB].[dbo].[MTOData]
           (PackageCode,PackageDescription,LineID,[Service],Quantity,
                  Unit,Size,PackageClass,ItemCode,DescriptionSpec,
              FullExacode,InsulationType,InsulationThickness,Manufacturer,ModelNumber,
              MaterialRate,InstallationRate,ProjectID,TotMaterialRate,TotInstallationRate)
              SELECT
              packagecode,packagedesc,
       '''','''',1,'''','''','''',itemcode,packagedesc,'''','''','''','''','''',cost,0,'''+@projid+''',cost,0
              FROM MTOMiscData WHERE projectid='''+@projid+''''
              exec(@MiscQuery)



		FETCH NEXT FROM ProjectDetails INTO @DBName,@projid;
	END;
	CLOSE ProjectDetails;
	DEALLOCATE ProjectDetails;
END
GO
/****** Object:  StoredProcedure [dbo].[GET_TOOL_DATA_FROM_DBc]    Script Date: 12/3/20 17:22:40 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[GET_TOOL_DATA_FROM_DBc] 
AS
DECLARE @DBName varchar(200);
DECLARE @projid varchar(200);
DECLARE @Query varchar(max);
DECLARE @DELQuery varchar(max);
BEGIN
	DECLARE ProjectDetails CURSOR
    FOR SELECT projdatabase,projectid from [ToolCostingDB].dbo.projmaster;
	OPEN ProjectDetails;
	FETCH NEXT FROM ProjectDetails INTO @DBName,@projid;
	WHILE @@FETCH_STATUS = 0
    BEGIN
        PRINT @projid;
        
	SET @DELQuery='DELETE FROM [ToolCostingDB].[dbo].[ProjectWistCostDetails] WHERE projectid='''+@projid+'''';
	print @DELQuery
	EXEC(@DELQuery);
	SET @Query='
		INSERT INTO [ToolCostingDB].[dbo].[ProjectWistCostDetails]
           (
           [ItemCode]
           ,[Size]
           ,[Quantity]
           ,[spec]
           ,[Manufacturer]
           ,[ModelNumber]
           ,[SSUD]
           ,[CostPerUnit]
		   ,[CostByQuantity]
           ,[InstallationPerUnit]           
           ,[CostByInstallationQuantity]
           ,[TotalCost]
		   ,[projectid]
		   ,[Description])

		select 
		final.ItemCode,		
		final.Size,
		final.Quantity,
		final.spec,
		final.Manufacturer,
		final.ModelNumber,
		final.SSUD,
		cost.CostPerUnit,
		final.Quantity*cost.CostPerUnit,
		cost.InstallationPerUnit,
		final.Quantity*cost.InstallationPerUnit,
		final.Quantity*cost.CostPerUnit+final.Quantity*cost.InstallationPerUnit,'''
		+@projid+''',
		cost.[Description]
		From
		(SELECT
			hvo.ItemCode,
			hvo.Size,
			count(prei.PnPID) Quantity,
			hvo.spec,
			replace(prei.Manufacturer,'' '','''') Manufacturer ,
			prei.ModelNumber,
			hvo.SSUD
			FROM
			(SELECT 
			TRIM(replace(ei.ModelNumber,'' '','''')) ModelNumber,
			TRIM(ei.Manufacturer) Manufacturer,
			ei.PnPID
			FROM ['+@DBName+'].[dbo].PnPProject proj
			INNER JOIN ['+@DBName+'].[dbo].EngineeringItems ei ON proj.[Project Details_MICAP] = ei.MICAP) prei
			INNER JOIN
			(SELECT 
			hv.PnPID,
			TRIM(replace(hv.Item_Code,'' '','''')) ItemCode,
			TRIM(replace(hv.SSUD,'' '','''')) SSUD,
			TRIM(ila.Size) Size,
			TRIM(ila.spec) spec
			FROM 
			['+@DBName+'].dbo.HandValves hv
			INNER JOIN ['+@DBName+'].dbo.[InLineAssets] ila ON ila.PnPID = hv.PnPID) hvo
			ON prei.PnPID = hvo.PNPID
			GROUP BY 
			prei.ModelNumber,
			replace(prei.Manufacturer,'' '',''''),
			hvo.ItemCode,
			hvo.SSUD,
			hvo.Size,
			hvo.spec) final 
			INNER JOIN dbo.itemwisecostdetails cost ON cost.itemcode = final.ItemCode'
		--print @Query
		exec(@Query)
		FETCH NEXT FROM ProjectDetails INTO @DBName,@projid;
	END;
	CLOSE ProjectDetails;
	DEALLOCATE ProjectDetails;
END



GO
/****** Object:  StoredProcedure [dbo].[GET_VALVE_DATA_FROM_DB]    Script Date: 12/3/20 17:22:40 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[GET_VALVE_DATA_FROM_DB] 
AS
DECLARE @DBName varchar(200);
DECLARE @projid varchar(200);
DECLARE @Query varchar(max);
DECLARE @DELQuery varchar(max);
BEGIN
	DECLARE ProjectDetails CURSOR
    FOR SELECT projdatabase,projectid from [ToolCostingDB].dbo.projmaster;
	OPEN ProjectDetails;
	FETCH NEXT FROM ProjectDetails INTO @DBName,@projid;
	WHILE @@FETCH_STATUS = 0
    BEGIN
        PRINT @projid;
        
	SET @DELQuery='DELETE FROM [ToolCostingDB].[dbo].[valvedata] WHERE projectid='''+@projid+'''';
	print @DELQuery
	EXEC(@DELQuery);
	SET @Query='
		INSERT INTO [ToolCostingDB].[dbo].[valvedata]
           (
           [ItemCode]
           ,[Size]
           ,[Quantity]
           ,[spec]
           ,[Manufacturer]
           ,[ModelNumber]
           ,[SSUD]
           ,[CostPerUnit]
		   ,[CostByQuantity]
           ,[InstallationPerUnit]           
           ,[CostByInstallationQuantity]
           ,[TotalCost]
		   ,[projectid]
		   ,[Description])

		select 
		final.ItemCode,		
		final.Size,
		final.Quantity,
		final.spec,
		final.Manufacturer,
		final.ModelNumber,
		final.SSUD,
		cost.CostPerUnit,
		final.Quantity*cost.CostPerUnit,
		cost.InstallationPerUnit,
		final.Quantity*cost.InstallationPerUnit,
		final.Quantity*cost.CostPerUnit+final.Quantity*cost.InstallationPerUnit,'''
		+@projid+''',
		cost.[Description]
		From
		(SELECT
			hvo.ItemCode,
			hvo.Size,
			count(prei.PnPID) Quantity,
			hvo.spec,
			replace(prei.Manufacturer,'' '','''') Manufacturer ,
			prei.ModelNumber,
			hvo.SSUD
			FROM
			(SELECT 
			TRIM(replace(ei.ModelNumber,'' '','''')) ModelNumber,
			TRIM(ei.Manufacturer) Manufacturer,
			ei.PnPID
			FROM ['+@DBName+'].[dbo].PnPProject proj
			INNER JOIN ['+@DBName+'].[dbo].EngineeringItems ei ON proj.[Project Details_MICAP] = ei.MICAP) prei
			INNER JOIN
			(SELECT 
			hv.PnPID,
			TRIM(replace(hv.Item_Code,'' '','''')) ItemCode,
			TRIM(replace(hv.SSUD,'' '','''')) SSUD,
			TRIM(ila.Size) Size,
			TRIM(ila.spec) spec
			FROM 
			['+@DBName+'].dbo.HandValves hv
			INNER JOIN ['+@DBName+'].dbo.[InLineAssets] ila ON ila.PnPID = hv.PnPID) hvo
			ON prei.PnPID = hvo.PNPID
			GROUP BY 
			prei.ModelNumber,
			replace(prei.Manufacturer,'' '',''''),
			hvo.ItemCode,
			hvo.SSUD,
			hvo.Size,
			hvo.spec) final 
			INNER JOIN dbo.itemwisecostdetails cost ON cost.itemcode = final.ItemCode'
		--print @Query
		exec(@Query)
		FETCH NEXT FROM ProjectDetails INTO @DBName,@projid;
	END;
	CLOSE ProjectDetails;
	DEALLOCATE ProjectDetails;
END



GO
/****** Object:  StoredProcedure [dbo].[SP_INSERT_GROUPELEMENT_LEVELS]    Script Date: 12/3/20 17:22:40 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		Vidhya K N 
-- Create date: 10th Nov 2020
-- Description:	To insert the group elements based on elements and levels
-- =============================================
CREATE PROCEDURE [dbo].[SP_INSERT_GROUPELEMENT_LEVELS]
(@Level varchar(50),
@Element nvarchar(200),
@ElementType bigint,
@Description nvarchar(2000),
@CreatedBy int 
--,
--@Material nvarchar(250),
--@Code nvarchar(250)
)
	
AS
BEGIN
	
	SET NOCOUNT ON;
	DECLARE @ELEMENT_COUNT INT 
	BEGIN TRANSACTION
	BEGIN TRY 
		IF (@Level =1 )
		BEGIN
			INSERT INTO Level1(
				Element
			  ,[Description]
			  ,[ElementType]
			  ,[ParentLevel]
			  ,[CreatedBy]
			  ,[CreatedOn])
			VALUES (
				@Element,
				@Description,
				@ElementType,
				NULL,
				@CreatedBy,
				GETDATE()
 			)
	
		END
		ELSE IF (@Level =2 )
		BEGIN
			SET @ELEMENT_COUNT = (SELECT COUNT (*) FROM Level2  GE  WHERE GE.ParentLevel = @Element )
			IF (@ELEMENT_COUNT >0)
			BEGIN
				 INSERT INTO  Level2(
					Element
				  ,[Description]
				  
				  ,[ParentLevel]
				  ,[CreatedBy]
				  ,[CreatedOn])
				VALUES 
				(
					CONCAT(	@Element ,10*(@ELEMENT_COUNT + 1)),
					@Description,
					
					@Element,
					@CreatedBy,
					GETDATE()

				)
			END
			ELSE 
			BEGIN
				 INSERT INTO  Level2(
					Element
				  ,[Description]
				   
				  ,[ParentLevel]
				  ,[CreatedBy]
				  ,[CreatedOn])
				VALUES 
				(
				CONCAT(	@Element ,'10'),
					@Description,
					
					@Element,
					@CreatedBy,
					GETDATE()
				)
			END 

		END
		ELSE IF (@Level =3 )
		BEGIN
			SET @ELEMENT_COUNT = (SELECT COUNT (*) FROM Level3  GE  WHERE GE.ParentLevel = @Element )
			IF (@ELEMENT_COUNT >0)
			BEGIN
				 INSERT INTO  Level3(
					Element
				  ,[Description]
				  
				  ,[ParentLevel]
				  ,[CreatedBy]
				  ,[CreatedOn])
				VALUES 
				(
					CONCAT(	@Element ,10*(@ELEMENT_COUNT + 1)),
					@Description,
					
					@Element,
					@CreatedBy,
					GETDATE()

				)
			END
			ELSE 
			BEGIN
				 INSERT INTO  Level3(
					Element
				  ,[Description]
				   
				  ,[ParentLevel]
				  ,[CreatedBy]
				  ,[CreatedOn])
				VALUES 
				(
				CONCAT(	@Element ,'10'),
					@Description,
					
					@Element,
					@CreatedBy,
					GETDATE()
				)
			END 

		END
		ELSE IF (@Level =4 )
		BEGIN
			SET @ELEMENT_COUNT = (SELECT COUNT (*) FROM Level4  GE  WHERE GE.ParentLevel = @Element )
			IF (@ELEMENT_COUNT >0)
			BEGIN
				 INSERT INTO  Level4(
					Element
				  ,[Description]
				   
				  ,[ParentLevel]
				  ,[CreatedBy]
				  ,[CreatedOn])
				VALUES 
				(
					CONCAT(	@Element ,100*(@ELEMENT_COUNT + 1)),
					@Description,
					
					@Element,
					@CreatedBy,
					GETDATE()

				)
			END
			ELSE 
			BEGIN
				 INSERT INTO  Level4(
					Element
				  ,[Description]
				  
				  ,[ParentLevel]
				  ,[CreatedBy]
				  ,[CreatedOn])
				VALUES 
				(
				CONCAT(	@Element ,'100'),
					@Description,
					
					@Element,
					@CreatedBy,
					GETDATE()
				)
			END 

		END
		ELSE IF (@Level =5 )
		BEGIN
			SET @ELEMENT_COUNT = (SELECT COUNT (*) FROM Level5  GE  WHERE GE.ParentLevel = @Element )
			IF (@ELEMENT_COUNT >0)
			BEGIN
				 INSERT INTO  Level5(
					Element
				  ,[Description]
				   
				  ,[ParentLevel]
				  ,[CreatedBy]
				  ,[CreatedOn])
				VALUES 
				(
					CONCAT(	SUBSTRING(@Element,1,3) , 
					(CAST(SUBSTRING(@Element,4,LEN(@Element)-1) as int)+(@ELEMENT_COUNT + 1))),					
					@Description,
					
					@Element,
					@CreatedBy,
					GETDATE()

				)
			END
			ELSE 
			BEGIN
				 INSERT INTO  Level5(
					Element
				  ,[Description]
				  
				  ,[ParentLevel]
				  ,[CreatedBy]
				  ,[CreatedOn])
				VALUES 
				(
				 CONCAT(SUBSTRING(@Element,1,3) ,
				 (CAST(SUBSTRING(@Element,4,LEN(@Element)-1) as int)+1)),
				 
					@Description,
				   
					@Element,
					@CreatedBy,
					GETDATE()
				)
			END  

		END
		--ELSE IF (@Level =6 )
		--BEGIN
		 
			
		--		 INSERT INTO  Level6(
		--			Element
		--		  ,[Material]
		--		  ,[Code]
		--		  ,[ParentLevel]
		--		  ,[CreatedBy]
		--		  ,[CreatedOn])
		--		VALUES 
		--		(
		--		CONCAT(	@Element ,@Code),
		--			@Material ,
		--			@Code ,
		--			@Element,
		--			@CreatedBy,
		--			GETDATE()
		--		)
			 

		--END
		SELECT
			ERROR_NUMBER() AS ErrorNumber,
			ERROR_SEVERITY() AS ErrorSeverity,
			ERROR_STATE() AS ErrorState,
			ERROR_PROCEDURE() AS ErrorProcedure,
			ERROR_LINE() AS ErrorLine,
			ERROR_MESSAGE() AS ErrorMessage;
	END TRY
	BEGIN CATCH
	   SELECT
			ERROR_NUMBER() AS ErrorNumber,
			ERROR_SEVERITY() AS ErrorSeverity,
			ERROR_STATE() AS ErrorState,
			ERROR_PROCEDURE() AS ErrorProcedure,
			ERROR_LINE() AS ErrorLine,
			ERROR_MESSAGE() AS ErrorMessage;
	   WHILE(@@trancount > 0)
	   BEGIN
		  ROLLBACK TRANSACTION
	   END
	END CATCH
	if (@@trancount <> 0)
	BEGIN
	   COMMIT TRANSACTION;
	END
END

GO
USE [master]
GO
ALTER DATABASE [ToolCostingDB] SET  READ_WRITE 
GO
