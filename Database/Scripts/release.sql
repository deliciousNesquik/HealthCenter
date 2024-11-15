USE [master]
GO
/****** Object:  Database [HealthCenter]    Script Date: 10.11.2024 1:42:56 ******/
CREATE DATABASE [HealthCenter]
 CONTAINMENT = NONE
 ON  PRIMARY 
( NAME = N'HealthCenter', FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL16.SQLEXPRESS\MSSQL\DATA\HealthCenter.mdf' , SIZE = 8192KB , MAXSIZE = UNLIMITED, FILEGROWTH = 65536KB )
 LOG ON 
( NAME = N'HealthCenter_log', FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL16.SQLEXPRESS\MSSQL\DATA\HealthCenter_log.ldf' , SIZE = 8192KB , MAXSIZE = 2048GB , FILEGROWTH = 65536KB )
GO
IF (1 = FULLTEXTSERVICEPROPERTY('IsFullTextInstalled'))
begin
EXEC [HealthCenter].[dbo].[sp_fulltext_database] @action = 'enable'
end
GO
ALTER DATABASE [HealthCenter] SET ANSI_NULL_DEFAULT OFF 
GO
ALTER DATABASE [HealthCenter] SET ANSI_NULLS OFF 
GO
ALTER DATABASE [HealthCenter] SET ANSI_PADDING OFF 
GO
ALTER DATABASE [HealthCenter] SET ANSI_WARNINGS OFF 
GO
ALTER DATABASE [HealthCenter] SET ARITHABORT OFF 
GO
ALTER DATABASE [HealthCenter] SET AUTO_CLOSE OFF 
GO
ALTER DATABASE [HealthCenter] SET AUTO_SHRINK OFF 
GO
ALTER DATABASE [HealthCenter] SET AUTO_UPDATE_STATISTICS ON 
GO
ALTER DATABASE [HealthCenter] SET CURSOR_CLOSE_ON_COMMIT OFF 
GO
ALTER DATABASE [HealthCenter] SET CURSOR_DEFAULT  GLOBAL 
GO
ALTER DATABASE [HealthCenter] SET CONCAT_NULL_YIELDS_NULL OFF 
GO
ALTER DATABASE [HealthCenter] SET NUMERIC_ROUNDABORT OFF 
GO
ALTER DATABASE [HealthCenter] SET QUOTED_IDENTIFIER OFF 
GO
ALTER DATABASE [HealthCenter] SET RECURSIVE_TRIGGERS OFF 
GO
ALTER DATABASE [HealthCenter] SET  DISABLE_BROKER 
GO
ALTER DATABASE [HealthCenter] SET AUTO_UPDATE_STATISTICS_ASYNC OFF 
GO
ALTER DATABASE [HealthCenter] SET DATE_CORRELATION_OPTIMIZATION OFF 
GO
ALTER DATABASE [HealthCenter] SET TRUSTWORTHY OFF 
GO
ALTER DATABASE [HealthCenter] SET ALLOW_SNAPSHOT_ISOLATION OFF 
GO
ALTER DATABASE [HealthCenter] SET PARAMETERIZATION SIMPLE 
GO
ALTER DATABASE [HealthCenter] SET READ_COMMITTED_SNAPSHOT OFF 
GO
ALTER DATABASE [HealthCenter] SET HONOR_BROKER_PRIORITY OFF 
GO
ALTER DATABASE [HealthCenter] SET RECOVERY SIMPLE 
GO
ALTER DATABASE [HealthCenter] SET  MULTI_USER 
GO
ALTER DATABASE [HealthCenter] SET PAGE_VERIFY CHECKSUM  
GO
ALTER DATABASE [HealthCenter] SET DB_CHAINING OFF 
GO
ALTER DATABASE [HealthCenter] SET FILESTREAM( NON_TRANSACTED_ACCESS = OFF ) 
GO
ALTER DATABASE [HealthCenter] SET TARGET_RECOVERY_TIME = 60 SECONDS 
GO
ALTER DATABASE [HealthCenter] SET DELAYED_DURABILITY = DISABLED 
GO
USE [HealthCenter]
GO
/****** Object:  Table [dbo].[Departments]    Script Date: 10.11.2024 1:42:56 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Departments](
	[ID] [int] IDENTITY(1,1) NOT NULL,
	[NameDepartments] [nvarchar](50) NOT NULL,
	[Level] [int] NOT NULL,
	[RoomNumbers] [nvarchar](10) NOT NULL,
	[HeadOfTheDepartment] [int] NULL,
PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Diagnoses]    Script Date: 10.11.2024 1:42:56 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Diagnoses](
	[ID] [int] NOT NULL,
	[NameDiagnose] [nvarchar](50) NOT NULL,
	[SignsOfTheDisease] [nvarchar](150) NOT NULL,
	[TheTreatmentPeriod] [nvarchar](150) NOT NULL,
	[Appointments] [nvarchar](150) NOT NULL,
	[Image] [nvarchar](50) NULL,
 CONSTRAINT [PK__Diagnose__3214EC27A91EE3FB] PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Employee]    Script Date: 10.11.2024 1:42:56 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Employee](
	[ID] [int] IDENTITY(1,1) NOT NULL,
	[Surname] [nvarchar](20) NOT NULL,
	[Name] [nvarchar](20) NOT NULL,
	[Patronymic] [nvarchar](20) NOT NULL,
	[Post] [nvarchar](50) NOT NULL,
	[WorkExperience] [int] NOT NULL,
	[ScientificTitle] [nvarchar](50) NULL,
	[Adress] [nvarchar](70) NOT NULL,
	[IDDepartaments] [int] NULL,
PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Genders]    Script Date: 10.11.2024 1:42:56 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Genders](
	[ID] [int] IDENTITY(1,1) NOT NULL,
	[Gender] [nvarchar](10) NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[MedicalHistory]    Script Date: 10.11.2024 1:42:56 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[MedicalHistory](
	[ID] [int] IDENTITY(1,1) NOT NULL,
	[IDPatient] [int] NOT NULL,
	[IDEmployee] [int] NOT NULL,
	[IDDiagnose] [int] NOT NULL,
	[Treatment] [nvarchar](max) NOT NULL,
	[DateOfTheDisease] [date] NOT NULL,
	[DateOfCure] [date] NOT NULL,
	[IDTypeOfTreatment] [int] NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Patients]    Script Date: 10.11.2024 1:42:56 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Patients](
	[ID] [int] IDENTITY(1,1) NOT NULL,
	[Surname] [nvarchar](20) NOT NULL,
	[Name] [nvarchar](20) NOT NULL,
	[Patronymic] [nvarchar](20) NOT NULL,
	[Adress] [nvarchar](70) NOT NULL,
	[City] [nvarchar](15) NOT NULL,
	[Age] [int] NOT NULL,
	[IDGender] [int] NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[TypeOfTreatments]    Script Date: 10.11.2024 1:42:56 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[TypeOfTreatments](
	[ID] [int] IDENTITY(1,1) NOT NULL,
	[TypeOfTreatment] [nvarchar](50) NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
SET IDENTITY_INSERT [dbo].[Departments] ON 

INSERT [dbo].[Departments] ([ID], [NameDepartments], [Level], [RoomNumbers], [HeadOfTheDepartment]) VALUES (1, N'Хирургия', 1, N'1-7', 4)
INSERT [dbo].[Departments] ([ID], [NameDepartments], [Level], [RoomNumbers], [HeadOfTheDepartment]) VALUES (2, N'Терапия', 1, N'7-11', 1)
INSERT [dbo].[Departments] ([ID], [NameDepartments], [Level], [RoomNumbers], [HeadOfTheDepartment]) VALUES (3, N'Нервология', 1, N'11-14', NULL)
INSERT [dbo].[Departments] ([ID], [NameDepartments], [Level], [RoomNumbers], [HeadOfTheDepartment]) VALUES (5, N'Отделение профилактики', 1, N'14-16', 7)
INSERT [dbo].[Departments] ([ID], [NameDepartments], [Level], [RoomNumbers], [HeadOfTheDepartment]) VALUES (6, N'Клинико-диагностическая лаборатория 1 этаж', 1, N'16-18', 14)
INSERT [dbo].[Departments] ([ID], [NameDepartments], [Level], [RoomNumbers], [HeadOfTheDepartment]) VALUES (8, N'Регистратура', 1, N'0', 5)
INSERT [dbo].[Departments] ([ID], [NameDepartments], [Level], [RoomNumbers], [HeadOfTheDepartment]) VALUES (9, N'Рентгенология', 1, N'18-19', 11)
INSERT [dbo].[Departments] ([ID], [NameDepartments], [Level], [RoomNumbers], [HeadOfTheDepartment]) VALUES (10, N'Клинико-диагностическая лаборатория 2 этаж', 2, N'20', 14)
SET IDENTITY_INSERT [dbo].[Departments] OFF
GO
INSERT [dbo].[Diagnoses] ([ID], [NameDiagnose], [SignsOfTheDisease], [TheTreatmentPeriod], [Appointments], [Image]) VALUES (1, N'ОРЗ', N'Насморк, кашель, горло', N'5 дней', N'Пить теплые напитки, принимать антипиретики', N'ОРЗ.png')
INSERT [dbo].[Diagnoses] ([ID], [NameDiagnose], [SignsOfTheDisease], [TheTreatmentPeriod], [Appointments], [Image]) VALUES (2, N'Гастрит', N'Боль в животе, изжога, тошнота', N'14 дней', N'Соблюдать диету, принимать препараты для уменьшения кислотности желудка', N'Гастрит.png')
INSERT [dbo].[Diagnoses] ([ID], [NameDiagnose], [SignsOfTheDisease], [TheTreatmentPeriod], [Appointments], [Image]) VALUES (3, N'Диабет', N'Частое мочеиспускание, усталость, зуд кожи', N'пожизненно', N'Следить за уровнем сахара в крови, прием инсулина', N'Диабет.png')
INSERT [dbo].[Diagnoses] ([ID], [NameDiagnose], [SignsOfTheDisease], [TheTreatmentPeriod], [Appointments], [Image]) VALUES (4, N'Артрит', N'Боль и отечность в суставах, ограничение подвижности', N'неопределенный', N'Принимать противовоспалительные препараты, физиотерапия', N'Артрит.png')
INSERT [dbo].[Diagnoses] ([ID], [NameDiagnose], [SignsOfTheDisease], [TheTreatmentPeriod], [Appointments], [Image]) VALUES (5, N'Бронхит', N'Кашель с мокротой, одышка, слабость', N'10 дней', N'Принимать антибиотики, выполнять ингаляции', N'Бронхит.png')
INSERT [dbo].[Diagnoses] ([ID], [NameDiagnose], [SignsOfTheDisease], [TheTreatmentPeriod], [Appointments], [Image]) VALUES (6, N'Гангрена легкого', N'высокая лихорадка, боль в грудной клетке, одышка, бледность и цианоз кожных покровов, потливость.', N'неопределенно', N'Антибиотики, Дренирование, Поддерживающая терапия', NULL)
GO
SET IDENTITY_INSERT [dbo].[Employee] ON 

INSERT [dbo].[Employee] ([ID], [Surname], [Name], [Patronymic], [Post], [WorkExperience], [ScientificTitle], [Adress], [IDDepartaments]) VALUES (1, N'Иванов', N'Петр', N'Сергеевич', N'Терапевт', 10, N'Кандидат медицинских наук', N'ул. Ленина, д. 10', 2)
INSERT [dbo].[Employee] ([ID], [Surname], [Name], [Patronymic], [Post], [WorkExperience], [ScientificTitle], [Adress], [IDDepartaments]) VALUES (2, N'Петрова', N'Анна', N'Ивановна', N'Медсестра', 5, NULL, N'ул. Пушкина, д. 5', 5)
INSERT [dbo].[Employee] ([ID], [Surname], [Name], [Patronymic], [Post], [WorkExperience], [ScientificTitle], [Adress], [IDDepartaments]) VALUES (3, N'Сидоров', N'Алексей', N'Владимирович', N'Хирург', 15, N'Доктор медицинских наук', N'пр. Гагарина, д. 15', 1)
INSERT [dbo].[Employee] ([ID], [Surname], [Name], [Patronymic], [Post], [WorkExperience], [ScientificTitle], [Adress], [IDDepartaments]) VALUES (4, N'Козлов', N'Михаил', N'Александрович', N'Лаборант', 3, NULL, N'ул. Кирова, д. 3', 10)
INSERT [dbo].[Employee] ([ID], [Surname], [Name], [Patronymic], [Post], [WorkExperience], [ScientificTitle], [Adress], [IDDepartaments]) VALUES (5, N'Никитина', N'Елена', N'Игоревна', N'Регистратор', 7, NULL, N'пер. Советский, д. 7', 8)
INSERT [dbo].[Employee] ([ID], [Surname], [Name], [Patronymic], [Post], [WorkExperience], [ScientificTitle], [Adress], [IDDepartaments]) VALUES (6, N'Иванов', N'Петр', N'Сергеевич', N'Врач-терапевт', 10, N'Кандидат медицинских наук', N'ул. Ленина, д. 10', 2)
INSERT [dbo].[Employee] ([ID], [Surname], [Name], [Patronymic], [Post], [WorkExperience], [ScientificTitle], [Adress], [IDDepartaments]) VALUES (7, N'Петров', N'Алексей', N'Иванович', N'Старшый мед брат', 5, N'Кандидат медицинских наук', N'пр. Победы, д. 5', 5)
INSERT [dbo].[Employee] ([ID], [Surname], [Name], [Patronymic], [Post], [WorkExperience], [ScientificTitle], [Adress], [IDDepartaments]) VALUES (8, N'Сидорова', N'Елена', N'Александровна', N'Хирург', 15, N'Доктор медицинских наук', N'ул. Гагарина, д. 15', 1)
INSERT [dbo].[Employee] ([ID], [Surname], [Name], [Patronymic], [Post], [WorkExperience], [ScientificTitle], [Adress], [IDDepartaments]) VALUES (9, N'Козлов', N'Дмитрий', N'Николаевич', N'Лаборант', 3, NULL, N'пр. Мира, д. 25', 10)
INSERT [dbo].[Employee] ([ID], [Surname], [Name], [Patronymic], [Post], [WorkExperience], [ScientificTitle], [Adress], [IDDepartaments]) VALUES (10, N'Михайлова', N'Ольга', N'Владимировна', N'Администратор', 7, NULL, N'ул. Пушкина, д. 20', 8)
INSERT [dbo].[Employee] ([ID], [Surname], [Name], [Patronymic], [Post], [WorkExperience], [ScientificTitle], [Adress], [IDDepartaments]) VALUES (11, N'Новиков', N'Игорь', N'Анатольевич', N'Рентгенолог', 12, NULL, N'пр. Ленинградский, д. 30', 9)
INSERT [dbo].[Employee] ([ID], [Surname], [Name], [Patronymic], [Post], [WorkExperience], [ScientificTitle], [Adress], [IDDepartaments]) VALUES (13, N'Зайцев', N'Андрей', N'Сергеевич', N'Фармацевт', 6, NULL, N'пр. Гагарина, д. 8', 6)
INSERT [dbo].[Employee] ([ID], [Surname], [Name], [Patronymic], [Post], [WorkExperience], [ScientificTitle], [Adress], [IDDepartaments]) VALUES (14, N'Григорьева', N'Наталья', N'Васильевна', N'Лаборант-микробиолог', 9, NULL, N'ул. Ленина, д. 40', 10)
INSERT [dbo].[Employee] ([ID], [Surname], [Name], [Patronymic], [Post], [WorkExperience], [ScientificTitle], [Adress], [IDDepartaments]) VALUES (17, N'Иванов', N'Андрей', N'Романович', N'Дворник', 12, NULL, N'ул. Ленина, д. 56', NULL)
SET IDENTITY_INSERT [dbo].[Employee] OFF
GO
SET IDENTITY_INSERT [dbo].[Genders] ON 

INSERT [dbo].[Genders] ([ID], [Gender]) VALUES (1, N'Мужской')
INSERT [dbo].[Genders] ([ID], [Gender]) VALUES (2, N'Женский')
SET IDENTITY_INSERT [dbo].[Genders] OFF
GO
SET IDENTITY_INSERT [dbo].[MedicalHistory] ON 

INSERT [dbo].[MedicalHistory] ([ID], [IDPatient], [IDEmployee], [IDDiagnose], [Treatment], [DateOfTheDisease], [DateOfCure], [IDTypeOfTreatment]) VALUES (1, 1, 1, 4, N'Принимать противовоспалительные препараты, физиотерапия', CAST(N'2024-03-28' AS Date), CAST(N'2024-05-28' AS Date), 1)
INSERT [dbo].[MedicalHistory] ([ID], [IDPatient], [IDEmployee], [IDDiagnose], [Treatment], [DateOfTheDisease], [DateOfCure], [IDTypeOfTreatment]) VALUES (2, 2, 2, 5, N'Принимать антибиотики, выполнять ингаляции', CAST(N'2024-03-20' AS Date), CAST(N'2024-03-30' AS Date), 1)
INSERT [dbo].[MedicalHistory] ([ID], [IDPatient], [IDEmployee], [IDDiagnose], [Treatment], [DateOfTheDisease], [DateOfCure], [IDTypeOfTreatment]) VALUES (3, 3, 2, 1, N'Пить теплые напитки, принимать антипиретики', CAST(N'2024-03-15' AS Date), CAST(N'2024-03-20' AS Date), 1)
INSERT [dbo].[MedicalHistory] ([ID], [IDPatient], [IDEmployee], [IDDiagnose], [Treatment], [DateOfTheDisease], [DateOfCure], [IDTypeOfTreatment]) VALUES (4, 4, 3, 6, N'Антибиотики, Дренирование, Поддерживающая терапия', CAST(N'2024-03-28' AS Date), CAST(N'2024-06-28' AS Date), 2)
INSERT [dbo].[MedicalHistory] ([ID], [IDPatient], [IDEmployee], [IDDiagnose], [Treatment], [DateOfTheDisease], [DateOfCure], [IDTypeOfTreatment]) VALUES (5, 5, 2, 1, N'Пить теплые напитки, принимать антипиретики', CAST(N'2024-01-10' AS Date), CAST(N'2024-01-15' AS Date), 1)
INSERT [dbo].[MedicalHistory] ([ID], [IDPatient], [IDEmployee], [IDDiagnose], [Treatment], [DateOfTheDisease], [DateOfCure], [IDTypeOfTreatment]) VALUES (6, 1, 1, 2, N'ну все гг', CAST(N'2024-11-09' AS Date), CAST(N'2024-11-17' AS Date), 1)
INSERT [dbo].[MedicalHistory] ([ID], [IDPatient], [IDEmployee], [IDDiagnose], [Treatment], [DateOfTheDisease], [DateOfCure], [IDTypeOfTreatment]) VALUES (7, 1, 1, 1, N'1', CAST(N'2024-11-04' AS Date), CAST(N'2024-11-24' AS Date), 2)
INSERT [dbo].[MedicalHistory] ([ID], [IDPatient], [IDEmployee], [IDDiagnose], [Treatment], [DateOfTheDisease], [DateOfCure], [IDTypeOfTreatment]) VALUES (12, 1, 1, 1, N'123', CAST(N'2024-11-09' AS Date), CAST(N'2024-11-17' AS Date), 1)
SET IDENTITY_INSERT [dbo].[MedicalHistory] OFF
GO
SET IDENTITY_INSERT [dbo].[Patients] ON 

INSERT [dbo].[Patients] ([ID], [Surname], [Name], [Patronymic], [Adress], [City], [Age], [IDGender]) VALUES (1, N'Смирнов', N'Иван', N'Петрович', N'ул. Гагарина, д. 10', N'Уфа', 35, 1)
INSERT [dbo].[Patients] ([ID], [Surname], [Name], [Patronymic], [Adress], [City], [Age], [IDGender]) VALUES (2, N'Иванова', N'Ольга', N'Александровна', N'пр. Ленина, д. 5', N'Уфа', 28, 2)
INSERT [dbo].[Patients] ([ID], [Surname], [Name], [Patronymic], [Adress], [City], [Age], [IDGender]) VALUES (3, N'Петров', N'Алексей', N'Игоревич', N'ул. Пушкина, д. 15', N'Уфа', 42, 1)
INSERT [dbo].[Patients] ([ID], [Surname], [Name], [Patronymic], [Adress], [City], [Age], [IDGender]) VALUES (4, N'Сидорова', N'Екатерина', N'Дмитриевна', N'пер. Кирова, д. 3', N'Уфа', 19, 2)
INSERT [dbo].[Patients] ([ID], [Surname], [Name], [Patronymic], [Adress], [City], [Age], [IDGender]) VALUES (5, N'Козлов', N'Дмитрий', N'Сергеевич', N'ул. Советская, д. 7', N'Уфа', 55, 1)
INSERT [dbo].[Patients] ([ID], [Surname], [Name], [Patronymic], [Adress], [City], [Age], [IDGender]) VALUES (6, N'Иванов', N'Петр', N'Сергеевич', N'ул. Ленина, д. 10', N'Уфа', 35, 1)
INSERT [dbo].[Patients] ([ID], [Surname], [Name], [Patronymic], [Adress], [City], [Age], [IDGender]) VALUES (7, N'Петров', N'Алексей', N'Иванович', N'пр. Победы, д. 5', N'Уфа', 28, 1)
INSERT [dbo].[Patients] ([ID], [Surname], [Name], [Patronymic], [Adress], [City], [Age], [IDGender]) VALUES (8, N'Сидорова', N'Елена', N'Александровна', N'ул. Гагарина, д. 15', N'Уфа', 42, 2)
INSERT [dbo].[Patients] ([ID], [Surname], [Name], [Patronymic], [Adress], [City], [Age], [IDGender]) VALUES (9, N'Козлов', N'Дмитрий', N'Николаевич', N'пр. Мира, д. 25', N'Уфа', 31, 1)
INSERT [dbo].[Patients] ([ID], [Surname], [Name], [Patronymic], [Adress], [City], [Age], [IDGender]) VALUES (10, N'Михайлова', N'Ольга', N'Владимировна', N'ул. Пушкина, д. 20', N'Уфа', 39, 2)
INSERT [dbo].[Patients] ([ID], [Surname], [Name], [Patronymic], [Adress], [City], [Age], [IDGender]) VALUES (11, N'Новиков', N'Игорь', N'Анатольевич', N'пр. Ленинградский, д. 30', N'Уфа', 45, 1)
INSERT [dbo].[Patients] ([ID], [Surname], [Name], [Patronymic], [Adress], [City], [Age], [IDGender]) VALUES (12, N'Белова', N'Мария', N'Игоревна', N'ул. Кирова, д. 12', N'Уфа', 33, 2)
INSERT [dbo].[Patients] ([ID], [Surname], [Name], [Patronymic], [Adress], [City], [Age], [IDGender]) VALUES (13, N'Зайцев', N'Андрей', N'Сергеевич', N'пр. Гагарина, д. 8', N'Уфа', 29, 1)
INSERT [dbo].[Patients] ([ID], [Surname], [Name], [Patronymic], [Adress], [City], [Age], [IDGender]) VALUES (14, N'Григорьева', N'Наталья', N'Васильевна', N'ул. Ленина, д. 40', N'Уфа', 37, 2)
INSERT [dbo].[Patients] ([ID], [Surname], [Name], [Patronymic], [Adress], [City], [Age], [IDGender]) VALUES (15, N'Кузнецов', N'Александр', N'Павлович', N'пр. Победы, д. 18', N'Уфа', 41, 1)
SET IDENTITY_INSERT [dbo].[Patients] OFF
GO
SET IDENTITY_INSERT [dbo].[TypeOfTreatments] ON 

INSERT [dbo].[TypeOfTreatments] ([ID], [TypeOfTreatment]) VALUES (1, N'Амбулаторное')
INSERT [dbo].[TypeOfTreatments] ([ID], [TypeOfTreatment]) VALUES (2, N'Стационарное')
SET IDENTITY_INSERT [dbo].[TypeOfTreatments] OFF
GO
ALTER TABLE [dbo].[Departments]  WITH CHECK ADD FOREIGN KEY([HeadOfTheDepartment])
REFERENCES [dbo].[Employee] ([ID])
GO
ALTER TABLE [dbo].[Employee]  WITH CHECK ADD FOREIGN KEY([IDDepartaments])
REFERENCES [dbo].[Departments] ([ID])
GO
ALTER TABLE [dbo].[MedicalHistory]  WITH CHECK ADD  CONSTRAINT [FK__MedicalHi__IDDia__49C3F6B7] FOREIGN KEY([IDDiagnose])
REFERENCES [dbo].[Diagnoses] ([ID])
GO
ALTER TABLE [dbo].[MedicalHistory] CHECK CONSTRAINT [FK__MedicalHi__IDDia__49C3F6B7]
GO
ALTER TABLE [dbo].[MedicalHistory]  WITH CHECK ADD FOREIGN KEY([IDEmployee])
REFERENCES [dbo].[Employee] ([ID])
GO
ALTER TABLE [dbo].[MedicalHistory]  WITH CHECK ADD FOREIGN KEY([IDPatient])
REFERENCES [dbo].[Patients] ([ID])
GO
ALTER TABLE [dbo].[MedicalHistory]  WITH CHECK ADD FOREIGN KEY([IDTypeOfTreatment])
REFERENCES [dbo].[TypeOfTreatments] ([ID])
GO
ALTER TABLE [dbo].[Patients]  WITH CHECK ADD FOREIGN KEY([IDGender])
REFERENCES [dbo].[Genders] ([ID])
GO
ALTER TABLE [dbo].[Departments]  WITH CHECK ADD  CONSTRAINT [CK_Departments] CHECK  (([Level]>(0)))
GO
ALTER TABLE [dbo].[Departments] CHECK CONSTRAINT [CK_Departments]
GO
ALTER TABLE [dbo].[Employee]  WITH CHECK ADD  CONSTRAINT [CK_Employee] CHECK  (([WorkExperience]>=(0) AND [WorkExperience]<=(99)))
GO
ALTER TABLE [dbo].[Employee] CHECK CONSTRAINT [CK_Employee]
GO
ALTER TABLE [dbo].[Patients]  WITH CHECK ADD  CONSTRAINT [CK_Пациенты] CHECK  (([Age]>=(1) AND [Age]<=(99)))
GO
ALTER TABLE [dbo].[Patients] CHECK CONSTRAINT [CK_Пациенты]
GO
USE [master]
GO
ALTER DATABASE [HealthCenter] SET  READ_WRITE 
GO
