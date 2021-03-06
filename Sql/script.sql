USE [master]
GO
/****** Object:  Database [PersonelTakip]    Script Date: 19.09.2021 21:34:36 ******/
CREATE DATABASE [PersonelTakip]
 CONTAINMENT = NONE

GO
ALTER DATABASE [PersonelTakip] SET COMPATIBILITY_LEVEL = 110
GO
IF (1 = FULLTEXTSERVICEPROPERTY('IsFullTextInstalled'))
begin
EXEC [PersonelTakip].[dbo].[sp_fulltext_database] @action = 'enable'
end
GO
ALTER DATABASE [PersonelTakip] SET ANSI_NULL_DEFAULT OFF 
GO
ALTER DATABASE [PersonelTakip] SET ANSI_NULLS OFF 
GO
ALTER DATABASE [PersonelTakip] SET ANSI_PADDING OFF 
GO
ALTER DATABASE [PersonelTakip] SET ANSI_WARNINGS OFF 
GO
ALTER DATABASE [PersonelTakip] SET ARITHABORT OFF 
GO
ALTER DATABASE [PersonelTakip] SET AUTO_CLOSE OFF 
GO
ALTER DATABASE [PersonelTakip] SET AUTO_CREATE_STATISTICS ON 
GO
ALTER DATABASE [PersonelTakip] SET AUTO_SHRINK OFF 
GO
ALTER DATABASE [PersonelTakip] SET AUTO_UPDATE_STATISTICS ON 
GO
ALTER DATABASE [PersonelTakip] SET CURSOR_CLOSE_ON_COMMIT OFF 
GO
ALTER DATABASE [PersonelTakip] SET CURSOR_DEFAULT  GLOBAL 
GO
ALTER DATABASE [PersonelTakip] SET CONCAT_NULL_YIELDS_NULL OFF 
GO
ALTER DATABASE [PersonelTakip] SET NUMERIC_ROUNDABORT OFF 
GO
ALTER DATABASE [PersonelTakip] SET QUOTED_IDENTIFIER OFF 
GO
ALTER DATABASE [PersonelTakip] SET RECURSIVE_TRIGGERS OFF 
GO
ALTER DATABASE [PersonelTakip] SET  DISABLE_BROKER 
GO
ALTER DATABASE [PersonelTakip] SET AUTO_UPDATE_STATISTICS_ASYNC OFF 
GO
ALTER DATABASE [PersonelTakip] SET DATE_CORRELATION_OPTIMIZATION OFF 
GO
ALTER DATABASE [PersonelTakip] SET TRUSTWORTHY OFF 
GO
ALTER DATABASE [PersonelTakip] SET ALLOW_SNAPSHOT_ISOLATION OFF 
GO
ALTER DATABASE [PersonelTakip] SET PARAMETERIZATION SIMPLE 
GO
ALTER DATABASE [PersonelTakip] SET READ_COMMITTED_SNAPSHOT OFF 
GO
ALTER DATABASE [PersonelTakip] SET HONOR_BROKER_PRIORITY OFF 
GO
ALTER DATABASE [PersonelTakip] SET RECOVERY FULL 
GO
ALTER DATABASE [PersonelTakip] SET  MULTI_USER 
GO
ALTER DATABASE [PersonelTakip] SET PAGE_VERIFY CHECKSUM  
GO
ALTER DATABASE [PersonelTakip] SET DB_CHAINING OFF 
GO
ALTER DATABASE [PersonelTakip] SET FILESTREAM( NON_TRANSACTED_ACCESS = OFF ) 
GO
ALTER DATABASE [PersonelTakip] SET TARGET_RECOVERY_TIME = 0 SECONDS 
GO
USE [PersonelTakip]
GO
/****** Object:  Table [dbo].[Department]    Script Date: 19.09.2021 21:34:36 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[Department](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[DepartmentName] [varchar](50) NULL,
 CONSTRAINT [PK_Department] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[Employees]    Script Date: 19.09.2021 21:34:36 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[Employees](
	[EmployeeID] [int] NOT NULL,
	[ProdmaID] [int] IDENTITY(10,1) NOT NULL,
	[Password] [varchar](20) NOT NULL,
	[UserType] [int] NOT NULL,
	[NationalityID] [varchar](11) NOT NULL,
	[EmployeeName] [varchar](20) NOT NULL,
	[EmployeeSurname] [varchar](20) NOT NULL,
	[Email] [varchar](50) NULL,
	[Phone] [varchar](20) NULL,
	[Address] [varchar](150) NULL,
	[Department] [int] NOT NULL,
	[State] [varchar](20) NOT NULL,
	[Salary] [money] NULL,
	[EntryDate] [datetime] NOT NULL,
	[ExitDate] [datetime] NULL,
	[NormalShiftTime] [time](7) NOT NULL,
	[Total] [varchar](50) NULL,
 CONSTRAINT [PK_Personel] PRIMARY KEY CLUSTERED 
(
	[EmployeeID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[Holidays]    Script Date: 19.09.2021 21:34:36 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Holidays](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[Date] [date] NULL,
	[ByUser] [bit] NULL,
 CONSTRAINT [PK_Tatiller] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[Shift]    Script Date: 19.09.2021 21:34:36 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[Shift](
	[ShiftID] [int] IDENTITY(1,1) NOT NULL,
	[EmployeeID] [int] NOT NULL,
	[ShiftDate] [date] NULL,
	[EntryTime] [time](7) NULL,
	[ExitTime] [time](7) NULL,
	[WorkTime] [time](7) NULL,
	[OverTime] [time](7) NULL,
	[MissingTime] [time](7) NULL,
	[Period] [varchar](20) NULL,
	[Deleted] [bit] NULL,
 CONSTRAINT [PK_MesaiHareketleri] PRIMARY KEY CLUSTERED 
(
	[ShiftID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[UserType]    Script Date: 19.09.2021 21:34:36 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[UserType](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[UserTypeName] [varchar](50) NULL,
 CONSTRAINT [PK_UserType] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
SET IDENTITY_INSERT [dbo].[Department] ON 

INSERT [dbo].[Department] ([Id], [DepartmentName]) VALUES (1, N'ARGE')
INSERT [dbo].[Department] ([Id], [DepartmentName]) VALUES (2, N'IT')
INSERT [dbo].[Department] ([Id], [DepartmentName]) VALUES (6, N'Muhasebe')
INSERT [dbo].[Department] ([Id], [DepartmentName]) VALUES (5, N'Satış/Pazarlama')
INSERT [dbo].[Department] ([Id], [DepartmentName]) VALUES (3, N'Üretim')
INSERT [dbo].[Department] ([Id], [DepartmentName]) VALUES (4, N'Yönetim')
SET IDENTITY_INSERT [dbo].[Department] OFF
SET IDENTITY_INSERT [dbo].[Employees] ON 

INSERT [dbo].[Employees] ([EmployeeID], [ProdmaID], [Password], [UserType], [NationalityID], [EmployeeName], [EmployeeSurname], [Email], [Phone], [Address], [Department], [State], [Salary], [EntryDate], [ExitDate], [NormalShiftTime], [Total]) VALUES (1, 10, N'1234', 5, N'14256792364', N'Mehmet', N'Yılmaz', N'arslanbrs5b@gmail.com', N'5362147847', N'Bakırköy/İstanbul', 2, N'Aktif', 2000.0000, CAST(0x0000A69000D35FCA AS DateTime), CAST(0x0001AC0400000000 AS DateTime), CAST(0x070010ACD1530000 AS Time), N'8 h 40 m')
INSERT [dbo].[Employees] ([EmployeeID], [ProdmaID], [Password], [UserType], [NationalityID], [EmployeeName], [EmployeeSurname], [Email], [Phone], [Address], [Department], [State], [Salary], [EntryDate], [ExitDate], [NormalShiftTime], [Total]) VALUES (3, 11, N'1234', 5, N'43099857162', N'Oğuzhan', N'Ergin', N'arslanbrs5b@hotmail.com', N'5458040053', N'Çerkezköy-Tekirdağ', 3, N'Aktif', 6500.0000, CAST(0x0000A65500000000 AS DateTime), CAST(0x0001AC0400000000 AS DateTime), CAST(0x070010ACD1530000 AS Time), N'10 h 0 m')
INSERT [dbo].[Employees] ([EmployeeID], [ProdmaID], [Password], [UserType], [NationalityID], [EmployeeName], [EmployeeSurname], [Email], [Phone], [Address], [Department], [State], [Salary], [EntryDate], [ExitDate], [NormalShiftTime], [Total]) VALUES (6, 12, N'1234', 5, N'76454123545', N'Tevfik', N'Azizoğlu', N'arslan1881@outlook.com', N'5341254789', N'Kağıthane/İstanbul', 4, N'Aktif', 7000.0000, CAST(0x0000A65800000000 AS DateTime), CAST(0x0001AC0400000000 AS DateTime), CAST(0x0700A8E76F4B0000 AS Time), N'8 h 0 m')
INSERT [dbo].[Employees] ([EmployeeID], [ProdmaID], [Password], [UserType], [NationalityID], [EmployeeName], [EmployeeSurname], [Email], [Phone], [Address], [Department], [State], [Salary], [EntryDate], [ExitDate], [NormalShiftTime], [Total]) VALUES (7, 13, N'1234', 5, N'45874125478', N'Hüseyin', N'Entel', NULL, N'5462147852', N'Sarıyer/İstanbul', 3, N'Aktif', 50000.0000, CAST(0x0000A6A400000000 AS DateTime), CAST(0x0001AC0400000000 AS DateTime), CAST(0x070040230E430000 AS Time), N'0 h 0 m')
INSERT [dbo].[Employees] ([EmployeeID], [ProdmaID], [Password], [UserType], [NationalityID], [EmployeeName], [EmployeeSurname], [Email], [Phone], [Address], [Department], [State], [Salary], [EntryDate], [ExitDate], [NormalShiftTime], [Total]) VALUES (10, 14, N'1234', 2, N'53214785214', N'Ayla', N'Satıcı', NULL, N'5321478541', N'Kartal/İstanbul', 5, N'Aktif', 1600.0000, CAST(0x0000A69C00000000 AS DateTime), CAST(0x0001AC0400000000 AS DateTime), CAST(0x070040230E430000 AS Time), N'0 h 0 m')
INSERT [dbo].[Employees] ([EmployeeID], [ProdmaID], [Password], [UserType], [NationalityID], [EmployeeName], [EmployeeSurname], [Email], [Phone], [Address], [Department], [State], [Salary], [EntryDate], [ExitDate], [NormalShiftTime], [Total]) VALUES (11, 15, N'1234', 5, N'85545215465', N'Seda', N'Gür', NULL, N'5445698741', N'Üsküdar/İstanbul', 5, N'Aktif', 1550.0000, CAST(0x0000A69500000000 AS DateTime), CAST(0x0001AC0400000000 AS DateTime), CAST(0x070040230E430000 AS Time), N'0 h 0 m')
INSERT [dbo].[Employees] ([EmployeeID], [ProdmaID], [Password], [UserType], [NationalityID], [EmployeeName], [EmployeeSurname], [Email], [Phone], [Address], [Department], [State], [Salary], [EntryDate], [ExitDate], [NormalShiftTime], [Total]) VALUES (17, 16, N'1234', 1, N'89632458745', N'Furkan', N'Çakır', NULL, N'5467843456', N'Maltepe/İstanbul', 4, N'Aktif', 7500.0000, CAST(0x0000A69B00000000 AS DateTime), CAST(0x0001AC0400000000 AS DateTime), CAST(0x070040230E430000 AS Time), N'0 h 0 m')
INSERT [dbo].[Employees] ([EmployeeID], [ProdmaID], [Password], [UserType], [NationalityID], [EmployeeName], [EmployeeSurname], [Email], [Phone], [Address], [Department], [State], [Salary], [EntryDate], [ExitDate], [NormalShiftTime], [Total]) VALUES (18, 17, N'1234', 2, N'17415478965', N'Hayriye', N'Keman', NULL, N'5462147852', N'Silivri/İstanbul', 6, N'Aktif', 2000.0000, CAST(0x0000A69500000000 AS DateTime), CAST(0x0001AC0400000000 AS DateTime), CAST(0x070040230E430000 AS Time), N'0 h 0 m')
INSERT [dbo].[Employees] ([EmployeeID], [ProdmaID], [Password], [UserType], [NationalityID], [EmployeeName], [EmployeeSurname], [Email], [Phone], [Address], [Department], [State], [Salary], [EntryDate], [ExitDate], [NormalShiftTime], [Total]) VALUES (19, 18, N'1234', 5, N'12345230975', N'Umut', N'Kafadar', N'arslanbrs5b@gmail.com', N'5394789432', N'Kozyatağı/İstanbul', 2, N'Aktif', 5000.0000, CAST(0x0000A69B00000000 AS DateTime), CAST(0x0001AC0400000000 AS DateTime), CAST(0x070040230E430000 AS Time), N'-3 h 20 m')
INSERT [dbo].[Employees] ([EmployeeID], [ProdmaID], [Password], [UserType], [NationalityID], [EmployeeName], [EmployeeSurname], [Email], [Phone], [Address], [Department], [State], [Salary], [EntryDate], [ExitDate], [NormalShiftTime], [Total]) VALUES (20, 19, N'1234', 2, N'12345678912', N'Arda', N'Güven', NULL, N'5353535353', N'Sancaktepe/İstanbul', 1, N'Aktif', 5000.0000, CAST(0x0000A96D00000000 AS DateTime), NULL, CAST(0x070010ACD1530000 AS Time), N'0 h 0 m')
INSERT [dbo].[Employees] ([EmployeeID], [ProdmaID], [Password], [UserType], [NationalityID], [EmployeeName], [EmployeeSurname], [Email], [Phone], [Address], [Department], [State], [Salary], [EntryDate], [ExitDate], [NormalShiftTime], [Total]) VALUES (21, 20, N'1234', 2, N'45687234569', N'Mehmet', N'Bardak', NULL, N'5357833353', N'Maltepe/İstanbul', 3, N'Aktif', 6500.0000, CAST(0x0000AD9F008A6FE1 AS DateTime), NULL, CAST(0x070010ACD1530000 AS Time), N'0 h 0 m')
INSERT [dbo].[Employees] ([EmployeeID], [ProdmaID], [Password], [UserType], [NationalityID], [EmployeeName], [EmployeeSurname], [Email], [Phone], [Address], [Department], [State], [Salary], [EntryDate], [ExitDate], [NormalShiftTime], [Total]) VALUES (22, 21, N'1234', 2, N'98767982345', N'Gökhan', N'Güzel', NULL, N'5357833345', N'Üsküdar/İstanbul', 2, N'Aktif', 2000.0000, CAST(0x0000AD9F008B3B60 AS DateTime), NULL, CAST(0x070010ACD1530000 AS Time), N'0 h 0 m')
SET IDENTITY_INSERT [dbo].[Employees] OFF
SET IDENTITY_INSERT [dbo].[Holidays] ON 

INSERT [dbo].[Holidays] ([Id], [Date], [ByUser]) VALUES (5, CAST(0x6E420B00 AS Date), 0)
INSERT [dbo].[Holidays] ([Id], [Date], [ByUser]) VALUES (6, CAST(0x76420B00 AS Date), 0)
INSERT [dbo].[Holidays] ([Id], [Date], [ByUser]) VALUES (7, CAST(0x88420B00 AS Date), 0)
INSERT [dbo].[Holidays] ([Id], [Date], [ByUser]) VALUES (8, CAST(0xC1420B00 AS Date), 0)
INSERT [dbo].[Holidays] ([Id], [Date], [ByUser]) VALUES (9, CAST(0xEF420B00 AS Date), 0)
INSERT [dbo].[Holidays] ([Id], [Date], [ByUser]) VALUES (10, CAST(0x2B430B00 AS Date), 0)
INSERT [dbo].[Holidays] ([Id], [Date], [ByUser]) VALUES (11, CAST(0xFE410B00 AS Date), 0)
INSERT [dbo].[Holidays] ([Id], [Date], [ByUser]) VALUES (15, CAST(0x04430B00 AS Date), 1)
INSERT [dbo].[Holidays] ([Id], [Date], [ByUser]) VALUES (16, CAST(0x08430B00 AS Date), 1)
SET IDENTITY_INSERT [dbo].[Holidays] OFF
SET IDENTITY_INSERT [dbo].[Shift] ON 

INSERT [dbo].[Shift] ([ShiftID], [EmployeeID], [ShiftDate], [EntryTime], [ExitTime], [WorkTime], [OverTime], [MissingTime], [Period], [Deleted]) VALUES (1, 1, CAST(0xF1420B00 AS Date), CAST(0x0700709A4A320000 AS Time), CAST(0x0700942E7A950000 AS Time), CAST(0x070024942F630000 AS Time), CAST(0x070014E85D0F0000 AS Time), CAST(0x0700000000000000 AS Time), N'09/2021', 0)
INSERT [dbo].[Shift] ([ShiftID], [EmployeeID], [ShiftDate], [EntryTime], [ExitTime], [WorkTime], [OverTime], [MissingTime], [Period], [Deleted]) VALUES (2, 1, CAST(0xF2420B00 AS Date), CAST(0x0700709A4A320000 AS Time), CAST(0x070050CFDF960000 AS Time), CAST(0x0700E03495640000 AS Time), CAST(0x0700D088C3100000 AS Time), CAST(0x0700000000000000 AS Time), N'09/2021', 0)
INSERT [dbo].[Shift] ([ShiftID], [EmployeeID], [ShiftDate], [EntryTime], [ExitTime], [WorkTime], [OverTime], [MissingTime], [Period], [Deleted]) VALUES (59, 6, CAST(0xF1420B00 AS Date), CAST(0x070040230E430000 AS Time), CAST(0x0700B893419F0000 AS Time), CAST(0x0700A8E76F4B0000 AS Time), CAST(0x0700D088C3100000 AS Time), CAST(0x0700000000000000 AS Time), N'09/2021', 0)
INSERT [dbo].[Shift] ([ShiftID], [EmployeeID], [ShiftDate], [EntryTime], [ExitTime], [WorkTime], [OverTime], [MissingTime], [Period], [Deleted]) VALUES (61, 6, CAST(0xF3420B00 AS Date), CAST(0x070040230E430000 AS Time), CAST(0x0700B893419F0000 AS Time), CAST(0x0700A8E76F4B0000 AS Time), CAST(0x0700D088C3100000 AS Time), CAST(0x0700000000000000 AS Time), N'09/2021', 0)
INSERT [dbo].[Shift] ([ShiftID], [EmployeeID], [ShiftDate], [EntryTime], [ExitTime], [WorkTime], [OverTime], [MissingTime], [Period], [Deleted]) VALUES (62, 6, CAST(0xF6420B00 AS Date), CAST(0x070040230E430000 AS Time), CAST(0x070050CFDF960000 AS Time), CAST(0x0700A8E76F4B0000 AS Time), CAST(0x070068C461080000 AS Time), CAST(0x0700000000000000 AS Time), N'09/2021', 0)
INSERT [dbo].[Shift] ([ShiftID], [EmployeeID], [ShiftDate], [EntryTime], [ExitTime], [WorkTime], [OverTime], [MissingTime], [Period], [Deleted]) VALUES (63, 6, CAST(0xF7420B00 AS Date), CAST(0x070040230E430000 AS Time), CAST(0x07002058A3A70000 AS Time), CAST(0x0700A8E76F4B0000 AS Time), CAST(0x0700384D25190000 AS Time), CAST(0x0700000000000000 AS Time), N'09/2021', 0)
INSERT [dbo].[Shift] ([ShiftID], [EmployeeID], [ShiftDate], [EntryTime], [ExitTime], [WorkTime], [OverTime], [MissingTime], [Period], [Deleted]) VALUES (64, 6, CAST(0xDB420B00 AS Date), CAST(0x070040230E430000 AS Time), CAST(0x0700B893419F0000 AS Time), CAST(0x0700A8E76F4B0000 AS Time), CAST(0x0700D088C3100000 AS Time), CAST(0x0700000000000000 AS Time), N'08/2021', 0)
INSERT [dbo].[Shift] ([ShiftID], [EmployeeID], [ShiftDate], [EntryTime], [ExitTime], [WorkTime], [OverTime], [MissingTime], [Period], [Deleted]) VALUES (65, 6, CAST(0xDC420B00 AS Date), CAST(0x070040230E430000 AS Time), CAST(0x070050CFDF960000 AS Time), CAST(0x0700A8E76F4B0000 AS Time), CAST(0x070068C461080000 AS Time), CAST(0x0700000000000000 AS Time), N'08/2021', 0)
INSERT [dbo].[Shift] ([ShiftID], [EmployeeID], [ShiftDate], [EntryTime], [ExitTime], [WorkTime], [OverTime], [MissingTime], [Period], [Deleted]) VALUES (66, 6, CAST(0xDD420B00 AS Date), CAST(0x070040230E430000 AS Time), CAST(0x070050CFDF960000 AS Time), CAST(0x0700A8E76F4B0000 AS Time), CAST(0x070068C461080000 AS Time), CAST(0x0700000000000000 AS Time), N'08/2021', 0)
INSERT [dbo].[Shift] ([ShiftID], [EmployeeID], [ShiftDate], [EntryTime], [ExitTime], [WorkTime], [OverTime], [MissingTime], [Period], [Deleted]) VALUES (67, 6, CAST(0xDE420B00 AS Date), CAST(0x070040230E430000 AS Time), CAST(0x070050CFDF960000 AS Time), CAST(0x0700A8E76F4B0000 AS Time), CAST(0x070068C461080000 AS Time), CAST(0x0700000000000000 AS Time), N'08/2021', 0)
INSERT [dbo].[Shift] ([ShiftID], [EmployeeID], [ShiftDate], [EntryTime], [ExitTime], [WorkTime], [OverTime], [MissingTime], [Period], [Deleted]) VALUES (68, 6, CAST(0xDF420B00 AS Date), CAST(0x070040230E430000 AS Time), CAST(0x070080461C860000 AS Time), CAST(0x070040230E430000 AS Time), CAST(0x070040230E430000 AS Time), CAST(0x0700000000000000 AS Time), N'08/2021', 0)
INSERT [dbo].[Shift] ([ShiftID], [EmployeeID], [ShiftDate], [EntryTime], [ExitTime], [WorkTime], [OverTime], [MissingTime], [Period], [Deleted]) VALUES (69, 6, CAST(0xE2420B00 AS Date), CAST(0x070040230E430000 AS Time), CAST(0x070050CFDF960000 AS Time), CAST(0x0700A8E76F4B0000 AS Time), CAST(0x070068C461080000 AS Time), CAST(0x0700000000000000 AS Time), N'08/2021', 0)
INSERT [dbo].[Shift] ([ShiftID], [EmployeeID], [ShiftDate], [EntryTime], [ExitTime], [WorkTime], [OverTime], [MissingTime], [Period], [Deleted]) VALUES (70, 6, CAST(0xE3420B00 AS Date), CAST(0x070040230E430000 AS Time), CAST(0x070050CFDF960000 AS Time), CAST(0x0700A8E76F4B0000 AS Time), CAST(0x070068C461080000 AS Time), CAST(0x0700000000000000 AS Time), N'08/2021', 0)
INSERT [dbo].[Shift] ([ShiftID], [EmployeeID], [ShiftDate], [EntryTime], [ExitTime], [WorkTime], [OverTime], [MissingTime], [Period], [Deleted]) VALUES (71, 6, CAST(0xE4420B00 AS Date), CAST(0x070040230E430000 AS Time), CAST(0x07001CEDAE920000 AS Time), CAST(0x0700A8E76F4B0000 AS Time), CAST(0x070034E230040000 AS Time), CAST(0x0700000000000000 AS Time), N'08/2021', 0)
INSERT [dbo].[Shift] ([ShiftID], [EmployeeID], [ShiftDate], [EntryTime], [ExitTime], [WorkTime], [OverTime], [MissingTime], [Period], [Deleted]) VALUES (72, 6, CAST(0xE5420B00 AS Date), CAST(0x070040230E430000 AS Time), CAST(0x0700DCF808A90000 AS Time), CAST(0x0700A8E76F4B0000 AS Time), CAST(0x0700F4ED8A1A0000 AS Time), CAST(0x0700000000000000 AS Time), N'08/2021', 0)
INSERT [dbo].[Shift] ([ShiftID], [EmployeeID], [ShiftDate], [EntryTime], [ExitTime], [WorkTime], [OverTime], [MissingTime], [Period], [Deleted]) VALUES (73, 6, CAST(0xE6420B00 AS Date), CAST(0x070040230E430000 AS Time), CAST(0x0700C03AC26F0000 AS Time), CAST(0x07008017B42C0000 AS Time), CAST(0x07008017B42C0000 AS Time), CAST(0x0700000000000000 AS Time), N'08/2021', 0)
INSERT [dbo].[Shift] ([ShiftID], [EmployeeID], [ShiftDate], [EntryTime], [ExitTime], [WorkTime], [OverTime], [MissingTime], [Period], [Deleted]) VALUES (74, 6, CAST(0xE9420B00 AS Date), CAST(0x070040230E430000 AS Time), CAST(0x070050CFDF960000 AS Time), CAST(0x0700A8E76F4B0000 AS Time), CAST(0x070068C461080000 AS Time), CAST(0x0700000000000000 AS Time), N'08/2021', 0)
INSERT [dbo].[Shift] ([ShiftID], [EmployeeID], [ShiftDate], [EntryTime], [ExitTime], [WorkTime], [OverTime], [MissingTime], [Period], [Deleted]) VALUES (75, 6, CAST(0xEA420B00 AS Date), CAST(0x070040230E430000 AS Time), CAST(0x070080461C860000 AS Time), CAST(0x070040230E430000 AS Time), CAST(0x0700000000000000 AS Time), CAST(0x070068C461080000 AS Time), N'08/2021', 0)
INSERT [dbo].[Shift] ([ShiftID], [EmployeeID], [ShiftDate], [EntryTime], [ExitTime], [WorkTime], [OverTime], [MissingTime], [Period], [Deleted]) VALUES (76, 6, CAST(0xEB420B00 AS Date), CAST(0x070040230E430000 AS Time), CAST(0x070050CFDF960000 AS Time), CAST(0x0700A8E76F4B0000 AS Time), CAST(0x070068C461080000 AS Time), CAST(0x0700000000000000 AS Time), N'08/2021', 0)
INSERT [dbo].[Shift] ([ShiftID], [EmployeeID], [ShiftDate], [EntryTime], [ExitTime], [WorkTime], [OverTime], [MissingTime], [Period], [Deleted]) VALUES (77, 6, CAST(0xEC420B00 AS Date), CAST(0x070040230E430000 AS Time), CAST(0x070050CFDF960000 AS Time), CAST(0x0700A8E76F4B0000 AS Time), CAST(0x070068C461080000 AS Time), CAST(0x0700000000000000 AS Time), N'08/2021', 0)
INSERT [dbo].[Shift] ([ShiftID], [EmployeeID], [ShiftDate], [EntryTime], [ExitTime], [WorkTime], [OverTime], [MissingTime], [Period], [Deleted]) VALUES (78, 6, CAST(0xED420B00 AS Date), CAST(0x070040230E430000 AS Time), CAST(0x070050CFDF960000 AS Time), CAST(0x070010ACD1530000 AS Time), CAST(0x070010ACD1530000 AS Time), CAST(0x0700000000000000 AS Time), N'08/2021', 0)
INSERT [dbo].[Shift] ([ShiftID], [EmployeeID], [ShiftDate], [EntryTime], [ExitTime], [WorkTime], [OverTime], [MissingTime], [Period], [Deleted]) VALUES (79, 6, CAST(0xEF420B00 AS Date), CAST(0x070040230E430000 AS Time), CAST(0x070050CFDF960000 AS Time), CAST(0x0700A8E76F4B0000 AS Time), CAST(0x070068C461080000 AS Time), CAST(0x0700000000000000 AS Time), N'08/2021', 0)
INSERT [dbo].[Shift] ([ShiftID], [EmployeeID], [ShiftDate], [EntryTime], [ExitTime], [WorkTime], [OverTime], [MissingTime], [Period], [Deleted]) VALUES (83, 3, CAST(0xF3420B00 AS Date), CAST(0x070040230E430000 AS Time), CAST(0x070050CFDF960000 AS Time), CAST(0x070010ACD1530000 AS Time), CAST(0x0700000000000000 AS Time), CAST(0x0700000000000000 AS Time), N'09/2021', 0)
INSERT [dbo].[Shift] ([ShiftID], [EmployeeID], [ShiftDate], [EntryTime], [ExitTime], [WorkTime], [OverTime], [MissingTime], [Period], [Deleted]) VALUES (84, 3, CAST(0xF4420B00 AS Date), CAST(0x070040230E430000 AS Time), CAST(0x070050CFDF960000 AS Time), CAST(0x070010ACD1530000 AS Time), CAST(0x070010ACD1530000 AS Time), CAST(0x0700000000000000 AS Time), N'09/2021', 0)
INSERT [dbo].[Shift] ([ShiftID], [EmployeeID], [ShiftDate], [EntryTime], [ExitTime], [WorkTime], [OverTime], [MissingTime], [Period], [Deleted]) VALUES (85, 1, CAST(0xD4420B00 AS Date), CAST(0x070040230E430000 AS Time), CAST(0x070050CFDF960000 AS Time), CAST(0x070010ACD1530000 AS Time), CAST(0x0700000000000000 AS Time), CAST(0x0700000000000000 AS Time), N'08/2021', 0)
INSERT [dbo].[Shift] ([ShiftID], [EmployeeID], [ShiftDate], [EntryTime], [ExitTime], [WorkTime], [OverTime], [MissingTime], [Period], [Deleted]) VALUES (86, 1, CAST(0xD5420B00 AS Date), CAST(0x070040230E430000 AS Time), CAST(0x07002058A3A70000 AS Time), CAST(0x0700E03495640000 AS Time), CAST(0x0700D088C3100000 AS Time), CAST(0x0700000000000000 AS Time), N'08/2021', 0)
INSERT [dbo].[Shift] ([ShiftID], [EmployeeID], [ShiftDate], [EntryTime], [ExitTime], [WorkTime], [OverTime], [MissingTime], [Period], [Deleted]) VALUES (87, 1, CAST(0xD6420B00 AS Date), CAST(0x070040230E430000 AS Time), CAST(0x070080461C860000 AS Time), CAST(0x070040230E430000 AS Time), CAST(0x0700000000000000 AS Time), CAST(0x0700D088C3100000 AS Time), N'08/2021', 0)
INSERT [dbo].[Shift] ([ShiftID], [EmployeeID], [ShiftDate], [EntryTime], [ExitTime], [WorkTime], [OverTime], [MissingTime], [Period], [Deleted]) VALUES (88, 3, CAST(0xD6420B00 AS Date), CAST(0x070040230E430000 AS Time), CAST(0x070080461C860000 AS Time), CAST(0x070040230E430000 AS Time), CAST(0x0700000000000000 AS Time), CAST(0x0700D088C3100000 AS Time), N'08/2021', 0)
INSERT [dbo].[Shift] ([ShiftID], [EmployeeID], [ShiftDate], [EntryTime], [ExitTime], [WorkTime], [OverTime], [MissingTime], [Period], [Deleted]) VALUES (89, 3, CAST(0xDA420B00 AS Date), CAST(0x070040230E430000 AS Time), CAST(0x070050CFDF960000 AS Time), CAST(0x070010ACD1530000 AS Time), CAST(0x0700000000000000 AS Time), CAST(0x0700000000000000 AS Time), N'08/2021', 0)
INSERT [dbo].[Shift] ([ShiftID], [EmployeeID], [ShiftDate], [EntryTime], [ExitTime], [WorkTime], [OverTime], [MissingTime], [Period], [Deleted]) VALUES (90, 3, CAST(0xDF420B00 AS Date), CAST(0x070040230E430000 AS Time), CAST(0x070050CFDF960000 AS Time), CAST(0x070010ACD1530000 AS Time), CAST(0x070010ACD1530000 AS Time), CAST(0x0700000000000000 AS Time), N'08/2021', 0)
INSERT [dbo].[Shift] ([ShiftID], [EmployeeID], [ShiftDate], [EntryTime], [ExitTime], [WorkTime], [OverTime], [MissingTime], [Period], [Deleted]) VALUES (91, 1, CAST(0xDB420B00 AS Date), CAST(0x070040230E430000 AS Time), CAST(0x070050CFDF960000 AS Time), CAST(0x070010ACD1530000 AS Time), CAST(0x0700000000000000 AS Time), CAST(0x0700000000000000 AS Time), N'08/2021', 0)
INSERT [dbo].[Shift] ([ShiftID], [EmployeeID], [ShiftDate], [EntryTime], [ExitTime], [WorkTime], [OverTime], [MissingTime], [Period], [Deleted]) VALUES (92, 1, CAST(0xDB420B00 AS Date), CAST(0x070040230E430000 AS Time), CAST(0x0700B893419F0000 AS Time), CAST(0x07007870335C0000 AS Time), CAST(0x070068C461080000 AS Time), CAST(0x0700000000000000 AS Time), N'08/2021', 0)
INSERT [dbo].[Shift] ([ShiftID], [EmployeeID], [ShiftDate], [EntryTime], [ExitTime], [WorkTime], [OverTime], [MissingTime], [Period], [Deleted]) VALUES (1105, 6, CAST(0xEF420B00 AS Date), CAST(0x070050A0773D0000 AS Time), CAST(0x0700604C49910000 AS Time), CAST(0x0700A8E76F4B0000 AS Time), CAST(0x070068C461080000 AS Time), CAST(0x0700000000000000 AS Time), N'08/2021', 0)
INSERT [dbo].[Shift] ([ShiftID], [EmployeeID], [ShiftDate], [EntryTime], [ExitTime], [WorkTime], [OverTime], [MissingTime], [Period], [Deleted]) VALUES (1106, 1, CAST(0xF6420B00 AS Date), CAST(0x070040230E430000 AS Time), CAST(0x070050CFDF960000 AS Time), CAST(0x070010ACD1530000 AS Time), CAST(0x0700000000000000 AS Time), CAST(0x0700000000000000 AS Time), N'09/2021', 0)
INSERT [dbo].[Shift] ([ShiftID], [EmployeeID], [ShiftDate], [EntryTime], [ExitTime], [WorkTime], [OverTime], [MissingTime], [Period], [Deleted]) VALUES (1107, 19, CAST(0xF1420B00 AS Date), CAST(0x070040230E430000 AS Time), CAST(0x070080461C860000 AS Time), CAST(0x070040230E430000 AS Time), CAST(0x0700000000000000 AS Time), CAST(0x0700000000000000 AS Time), N'09/2021', 0)
INSERT [dbo].[Shift] ([ShiftID], [EmployeeID], [ShiftDate], [EntryTime], [ExitTime], [WorkTime], [OverTime], [MissingTime], [Period], [Deleted]) VALUES (1108, 19, CAST(0xF3420B00 AS Date), CAST(0x070040230E430000 AS Time), CAST(0x0700C03AC26F0000 AS Time), CAST(0x07008017B42C0000 AS Time), CAST(0x0700000000000000 AS Time), CAST(0x0700C00B5A160000 AS Time), N'09/2021', 0)
INSERT [dbo].[Shift] ([ShiftID], [EmployeeID], [ShiftDate], [EntryTime], [ExitTime], [WorkTime], [OverTime], [MissingTime], [Period], [Deleted]) VALUES (1109, 19, CAST(0xF6420B00 AS Date), CAST(0x070040230E430000 AS Time), CAST(0x070080461C860000 AS Time), CAST(0x070040230E430000 AS Time), CAST(0x0700000000000000 AS Time), CAST(0x0700000000000000 AS Time), N'09/2021', 0)
INSERT [dbo].[Shift] ([ShiftID], [EmployeeID], [ShiftDate], [EntryTime], [ExitTime], [WorkTime], [OverTime], [MissingTime], [Period], [Deleted]) VALUES (1110, 19, CAST(0xF7420B00 AS Date), CAST(0x070040230E430000 AS Time), CAST(0x0700B893419F0000 AS Time), CAST(0x070040230E430000 AS Time), CAST(0x0700384D25190000 AS Time), CAST(0x0700000000000000 AS Time), N'09/2021', 0)
INSERT [dbo].[Shift] ([ShiftID], [EmployeeID], [ShiftDate], [EntryTime], [ExitTime], [WorkTime], [OverTime], [MissingTime], [Period], [Deleted]) VALUES (2108, 19, CAST(0xF9420B00 AS Date), CAST(0x0700EC460A4A0000 AS Time), CAST(0x0700049A5C6E0000 AS Time), CAST(0x0700185352240000 AS Time), CAST(0x0700000000000000 AS Time), CAST(0x070028D0BB1E0000 AS Time), N'09/2021', 0)
INSERT [dbo].[Shift] ([ShiftID], [EmployeeID], [ShiftDate], [EntryTime], [ExitTime], [WorkTime], [OverTime], [MissingTime], [Period], [Deleted]) VALUES (2109, 1, CAST(0xFB420B00 AS Date), CAST(0x0700A8E76F4B0000 AS Time), CAST(0x070080461C860000 AS Time), CAST(0x0700D85EAC3A0000 AS Time), CAST(0x0700D85EAC3A0000 AS Time), CAST(0x0700000000000000 AS Time), N'09/2021', 0)
INSERT [dbo].[Shift] ([ShiftID], [EmployeeID], [ShiftDate], [EntryTime], [ExitTime], [WorkTime], [OverTime], [MissingTime], [Period], [Deleted]) VALUES (2110, 1, CAST(0xF7420B00 AS Date), CAST(0x07007870335C0000 AS Time), CAST(0x0700B893419F0000 AS Time), CAST(0x070040230E430000 AS Time), CAST(0x0700000000000000 AS Time), CAST(0x0700D088C3100000 AS Time), N'09/2021', 0)
INSERT [dbo].[Shift] ([ShiftID], [EmployeeID], [ShiftDate], [EntryTime], [ExitTime], [WorkTime], [OverTime], [MissingTime], [Period], [Deleted]) VALUES (2111, 1, CAST(0xFD420B00 AS Date), CAST(0x0700AE702A3E0000 AS Time), CAST(0x0700942E7A950000 AS Time), CAST(0x070088ED9C560000 AS Time), CAST(0x07007841CB020000 AS Time), CAST(0x0700000000000000 AS Time), N'09/2021', 0)
INSERT [dbo].[Shift] ([ShiftID], [EmployeeID], [ShiftDate], [EntryTime], [ExitTime], [WorkTime], [OverTime], [MissingTime], [Period], [Deleted]) VALUES (2112, 1, CAST(0xF8420B00 AS Date), CAST(0x070040230E430000 AS Time), CAST(0x07001CEDAE920000 AS Time), CAST(0x0700DCC9A04F0000 AS Time), CAST(0x0700000000000000 AS Time), CAST(0x070034E230040000 AS Time), N'09/2021', 0)
SET IDENTITY_INSERT [dbo].[Shift] OFF
SET IDENTITY_INSERT [dbo].[UserType] ON 

INSERT [dbo].[UserType] ([Id], [UserTypeName]) VALUES (1, N'Administrator')
INSERT [dbo].[UserType] ([Id], [UserTypeName]) VALUES (2, N'Manager')
INSERT [dbo].[UserType] ([Id], [UserTypeName]) VALUES (5, N'User')
SET IDENTITY_INSERT [dbo].[UserType] OFF
SET ANSI_PADDING ON

GO
/****** Object:  Index [UC_DepartmentName]    Script Date: 19.09.2021 21:34:36 ******/
ALTER TABLE [dbo].[Department] ADD  CONSTRAINT [UC_DepartmentName] UNIQUE NONCLUSTERED 
(
	[DepartmentName] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
SET ANSI_PADDING ON

GO
/****** Object:  Index [UC_PersonelTC]    Script Date: 19.09.2021 21:34:36 ******/
ALTER TABLE [dbo].[Employees] ADD  CONSTRAINT [UC_PersonelTC] UNIQUE NONCLUSTERED 
(
	[NationalityID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
/****** Object:  Index [Uc_Tarih]    Script Date: 19.09.2021 21:34:36 ******/
ALTER TABLE [dbo].[Holidays] ADD  CONSTRAINT [Uc_Tarih] UNIQUE NONCLUSTERED 
(
	[Date] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
SET ANSI_PADDING ON

GO
/****** Object:  Index [UC_UserType]    Script Date: 19.09.2021 21:34:36 ******/
ALTER TABLE [dbo].[UserType] ADD  CONSTRAINT [UC_UserType] UNIQUE NONCLUSTERED 
(
	[UserTypeName] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
ALTER TABLE [dbo].[Employees] ADD  CONSTRAINT [DF_Personel_Durum]  DEFAULT ('Aktif') FOR [State]
GO
ALTER TABLE [dbo].[Employees] ADD  CONSTRAINT [DF_Personel_GirisTarihi]  DEFAULT (getdate()) FOR [EntryDate]
GO
ALTER TABLE [dbo].[Holidays] ADD  CONSTRAINT [DF_Table_1_BySystem]  DEFAULT ((0)) FOR [ByUser]
GO
ALTER TABLE [dbo].[Shift] ADD  CONSTRAINT [DF_MesaiHareketleri_Silindi]  DEFAULT ((0)) FOR [Deleted]
GO
ALTER TABLE [dbo].[Employees]  WITH CHECK ADD  CONSTRAINT [FK_Employees_UserType] FOREIGN KEY([UserType])
REFERENCES [dbo].[UserType] ([Id])
GO
ALTER TABLE [dbo].[Employees] CHECK CONSTRAINT [FK_Employees_UserType]
GO
ALTER TABLE [dbo].[Employees]  WITH CHECK ADD  CONSTRAINT [FK_Personel_Department] FOREIGN KEY([Department])
REFERENCES [dbo].[Department] ([Id])
GO
ALTER TABLE [dbo].[Employees] CHECK CONSTRAINT [FK_Personel_Department]
GO
ALTER TABLE [dbo].[Shift]  WITH CHECK ADD  CONSTRAINT [FK_MesaiHareketleri_Personel] FOREIGN KEY([EmployeeID])
REFERENCES [dbo].[Employees] ([EmployeeID])
GO
ALTER TABLE [dbo].[Shift] CHECK CONSTRAINT [FK_MesaiHareketleri_Personel]
GO
USE [master]
GO
ALTER DATABASE [PersonelTakip] SET  READ_WRITE 
GO
