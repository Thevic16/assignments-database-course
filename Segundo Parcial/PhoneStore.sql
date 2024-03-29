USE [master]
GO
/****** Object:  Database [PhoneStore]    Script Date: 16/11/2020 11:01:02 a. m. ******/
CREATE DATABASE [PhoneStore]
 CONTAINMENT = NONE
 ON  PRIMARY 
( NAME = N'PhoneStore', FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL15.MSSQLSERVER\MSSQL\DATA\PhoneStore.mdf' , SIZE = 8192KB , MAXSIZE = UNLIMITED, FILEGROWTH = 65536KB )
 LOG ON 
( NAME = N'PhoneStore_log', FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL15.MSSQLSERVER\MSSQL\DATA\PhoneStore_log.ldf' , SIZE = 8192KB , MAXSIZE = 2048GB , FILEGROWTH = 65536KB )
 WITH CATALOG_COLLATION = DATABASE_DEFAULT
GO
ALTER DATABASE [PhoneStore] SET COMPATIBILITY_LEVEL = 150
GO
IF (1 = FULLTEXTSERVICEPROPERTY('IsFullTextInstalled'))
begin
EXEC [PhoneStore].[dbo].[sp_fulltext_database] @action = 'enable'
end
GO
ALTER DATABASE [PhoneStore] SET ANSI_NULL_DEFAULT OFF 
GO
ALTER DATABASE [PhoneStore] SET ANSI_NULLS OFF 
GO
ALTER DATABASE [PhoneStore] SET ANSI_PADDING OFF 
GO
ALTER DATABASE [PhoneStore] SET ANSI_WARNINGS OFF 
GO
ALTER DATABASE [PhoneStore] SET ARITHABORT OFF 
GO
ALTER DATABASE [PhoneStore] SET AUTO_CLOSE OFF 
GO
ALTER DATABASE [PhoneStore] SET AUTO_SHRINK OFF 
GO
ALTER DATABASE [PhoneStore] SET AUTO_UPDATE_STATISTICS ON 
GO
ALTER DATABASE [PhoneStore] SET CURSOR_CLOSE_ON_COMMIT OFF 
GO
ALTER DATABASE [PhoneStore] SET CURSOR_DEFAULT  GLOBAL 
GO
ALTER DATABASE [PhoneStore] SET CONCAT_NULL_YIELDS_NULL OFF 
GO
ALTER DATABASE [PhoneStore] SET NUMERIC_ROUNDABORT OFF 
GO
ALTER DATABASE [PhoneStore] SET QUOTED_IDENTIFIER OFF 
GO
ALTER DATABASE [PhoneStore] SET RECURSIVE_TRIGGERS OFF 
GO
ALTER DATABASE [PhoneStore] SET  DISABLE_BROKER 
GO
ALTER DATABASE [PhoneStore] SET AUTO_UPDATE_STATISTICS_ASYNC OFF 
GO
ALTER DATABASE [PhoneStore] SET DATE_CORRELATION_OPTIMIZATION OFF 
GO
ALTER DATABASE [PhoneStore] SET TRUSTWORTHY OFF 
GO
ALTER DATABASE [PhoneStore] SET ALLOW_SNAPSHOT_ISOLATION OFF 
GO
ALTER DATABASE [PhoneStore] SET PARAMETERIZATION SIMPLE 
GO
ALTER DATABASE [PhoneStore] SET READ_COMMITTED_SNAPSHOT OFF 
GO
ALTER DATABASE [PhoneStore] SET HONOR_BROKER_PRIORITY OFF 
GO
ALTER DATABASE [PhoneStore] SET RECOVERY FULL 
GO
ALTER DATABASE [PhoneStore] SET  MULTI_USER 
GO
ALTER DATABASE [PhoneStore] SET PAGE_VERIFY CHECKSUM  
GO
ALTER DATABASE [PhoneStore] SET DB_CHAINING OFF 
GO
ALTER DATABASE [PhoneStore] SET FILESTREAM( NON_TRANSACTED_ACCESS = OFF ) 
GO
ALTER DATABASE [PhoneStore] SET TARGET_RECOVERY_TIME = 60 SECONDS 
GO
ALTER DATABASE [PhoneStore] SET DELAYED_DURABILITY = DISABLED 
GO
EXEC sys.sp_db_vardecimal_storage_format N'PhoneStore', N'ON'
GO
ALTER DATABASE [PhoneStore] SET QUERY_STORE = OFF
GO
USE [PhoneStore]
GO
/****** Object:  Table [dbo].[Billing]    Script Date: 16/11/2020 11:01:02 a. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Billing](
	[IdBilling] [nchar](4) NOT NULL,
	[BillingDate] [date] NULL,
	[IdClient] [nchar](4) NULL,
	[BillAmount] [money] NULL,
	[Discount] [float] NULL,
	[TaxApplied] [float] NULL,
	[TotalCommiEmpl] [money] NULL,
 CONSTRAINT [PK_Billing] PRIMARY KEY CLUSTERED 
(
	[IdBilling] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Client]    Script Date: 16/11/2020 11:01:03 a. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Client](
	[IdClient] [nchar](4) NOT NULL,
	[IdEmplFami] [nchar](4) NULL,
 CONSTRAINT [PK_Client] PRIMARY KEY CLUSTERED 
(
	[IdClient] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[ClientContact]    Script Date: 16/11/2020 11:01:03 a. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[ClientContact](
	[IdClient] [nchar](4) NULL,
	[Description] [nchar](30) NULL,
	[Information] [nchar](30) NULL
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Diagnosis]    Script Date: 16/11/2020 11:01:03 a. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Diagnosis](
	[IdClient] [nchar](4) NULL,
	[RequiredService] [nchar](50) NULL,
	[DiagnosisDate] [datetime] NOT NULL,
	[EqupRepairDescrip] [nchar](50) NULL,
	[PaymentType] [nchar](20) NULL,
	[ServiceCost] [money] NULL,
 CONSTRAINT [PK_Diagnosis] PRIMARY KEY CLUSTERED 
(
	[DiagnosisDate] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[EmplContact]    Script Date: 16/11/2020 11:01:03 a. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[EmplContact](
	[IdEmpl] [nchar](4) NULL,
	[Description] [nchar](30) NULL,
	[Information] [nchar](30) NULL
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Employee]    Script Date: 16/11/2020 11:01:03 a. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Employee](
	[IdEmpl] [nchar](4) NOT NULL,
	[Document] [nchar](50) NULL,
	[PayrollAccount] [nchar](22) NULL,
	[BankAccount] [nchar](22) NULL,
	[IdSupervisor] [nchar](4) NULL,
	[WorkArea] [nchar](30) NULL,
	[JobPosition] [nchar](20) NULL,
	[WorkAreaPhone] [nchar](10) NULL,
	[Discount] [float] NULL,
	[EntryDate] [date] NULL,
	[DateOfBirth] [date] NULL,
	[Salary] [money] NULL,
 CONSTRAINT [PK_Employee] PRIMARY KEY CLUSTERED 
(
	[IdEmpl] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[EquiFeature]    Script Date: 16/11/2020 11:01:03 a. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[EquiFeature](
	[IdEqui] [nchar](4) NULL,
	[Description] [nchar](50) NULL,
	[Information] [nchar](50) NULL
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[EqupmentSale]    Script Date: 16/11/2020 11:01:03 a. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[EqupmentSale](
	[IdEqui] [nchar](4) NOT NULL,
	[Description] [nchar](50) NULL,
	[AcquisitionPrice] [money] NULL,
	[SalePrice] [money] NULL,
	[Quantity] [int] NULL,
 CONSTRAINT [PK_EqupmentSale] PRIMARY KEY CLUSTERED 
(
	[IdEqui] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[ExecutionSequence]    Script Date: 16/11/2020 11:01:03 a. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[ExecutionSequence](
	[IdService] [nchar](4) NULL,
	[Sequence] [int] NULL,
	[Description] [nchar](50) NULL,
	[IdEmpl] [nchar](4) NULL,
	[EmplComment] [nchar](50) NULL,
	[TimeInit] [datetime] NULL,
	[TimeFinal] [datetime] NULL
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[InvoiceEquip]    Script Date: 16/11/2020 11:01:03 a. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[InvoiceEquip](
	[IdBilling] [nchar](4) NULL,
	[IdEqui] [nchar](4) NULL,
	[Tax] [money] NULL,
	[IdEmpl] [nchar](4) NULL,
	[CommissionEmpl] [money] NULL,
	[IdInvoiceE] [nchar](4) NOT NULL,
 CONSTRAINT [PK_InvoiceEquip] PRIMARY KEY CLUSTERED 
(
	[IdInvoiceE] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[InvoiceService]    Script Date: 16/11/2020 11:01:03 a. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[InvoiceService](
	[IdBilling] [nchar](4) NULL,
	[IdService] [nchar](4) NULL,
	[Tax] [money] NULL,
	[IdInvoiceS] [nchar](4) NOT NULL,
 CONSTRAINT [PK_InvoiceService] PRIMARY KEY CLUSTERED 
(
	[IdInvoiceS] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[JobHistory]    Script Date: 16/11/2020 11:01:03 a. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[JobHistory](
	[IdEmpl] [nchar](4) NULL,
	[JobPosition] [nchar](20) NULL,
	[Salary] [money] NULL,
	[StartDate] [date] NULL,
	[FinalDate] [date] NULL
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Part]    Script Date: 16/11/2020 11:01:03 a. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Part](
	[IdPart] [nchar](4) NOT NULL,
	[IdClient] [nchar](4) NULL,
	[IdService] [nchar](4) NULL,
	[Description] [nchar](50) NULL,
	[Information] [nchar](50) NULL,
	[CostPart] [money] NULL,
	[Authorization] [bit] NULL,
	[CommissionEmpl] [money] NULL,
	[IdEmpl] [nchar](4) NULL,
 CONSTRAINT [PK_Part] PRIMARY KEY CLUSTERED 
(
	[IdPart] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Service]    Script Date: 16/11/2020 11:01:03 a. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Service](
	[IdService] [nchar](4) NOT NULL,
	[IdClient] [nchar](4) NULL,
	[RequstDate] [date] NULL,
	[EquInfomation] [nchar](50) NULL,
	[ServiceComment] [nchar](50) NULL,
	[Cost] [money] NULL,
 CONSTRAINT [PK_Service] PRIMARY KEY CLUSTERED 
(
	[IdService] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
ALTER TABLE [dbo].[Billing]  WITH CHECK ADD  CONSTRAINT [FK_Billing_Client] FOREIGN KEY([IdClient])
REFERENCES [dbo].[Client] ([IdClient])
GO
ALTER TABLE [dbo].[Billing] CHECK CONSTRAINT [FK_Billing_Client]
GO
ALTER TABLE [dbo].[Client]  WITH CHECK ADD  CONSTRAINT [FK_Client_Employee] FOREIGN KEY([IdEmplFami])
REFERENCES [dbo].[Employee] ([IdEmpl])
GO
ALTER TABLE [dbo].[Client] CHECK CONSTRAINT [FK_Client_Employee]
GO
ALTER TABLE [dbo].[ClientContact]  WITH CHECK ADD  CONSTRAINT [FK_ClientContact_Client] FOREIGN KEY([IdClient])
REFERENCES [dbo].[Client] ([IdClient])
GO
ALTER TABLE [dbo].[ClientContact] CHECK CONSTRAINT [FK_ClientContact_Client]
GO
ALTER TABLE [dbo].[Diagnosis]  WITH CHECK ADD  CONSTRAINT [FK_Diagnosis_Client] FOREIGN KEY([IdClient])
REFERENCES [dbo].[Client] ([IdClient])
GO
ALTER TABLE [dbo].[Diagnosis] CHECK CONSTRAINT [FK_Diagnosis_Client]
GO
ALTER TABLE [dbo].[EmplContact]  WITH CHECK ADD  CONSTRAINT [FK_EmplContact_Employee] FOREIGN KEY([IdEmpl])
REFERENCES [dbo].[Employee] ([IdEmpl])
GO
ALTER TABLE [dbo].[EmplContact] CHECK CONSTRAINT [FK_EmplContact_Employee]
GO
ALTER TABLE [dbo].[Employee]  WITH CHECK ADD  CONSTRAINT [FK_Employee_Employee] FOREIGN KEY([IdSupervisor])
REFERENCES [dbo].[Employee] ([IdEmpl])
GO
ALTER TABLE [dbo].[Employee] CHECK CONSTRAINT [FK_Employee_Employee]
GO
ALTER TABLE [dbo].[EquiFeature]  WITH CHECK ADD  CONSTRAINT [FK_EquiFeature_EqupmentSale] FOREIGN KEY([IdEqui])
REFERENCES [dbo].[EqupmentSale] ([IdEqui])
GO
ALTER TABLE [dbo].[EquiFeature] CHECK CONSTRAINT [FK_EquiFeature_EqupmentSale]
GO
ALTER TABLE [dbo].[ExecutionSequence]  WITH CHECK ADD  CONSTRAINT [FK_ExecutionSequence_Employee] FOREIGN KEY([IdEmpl])
REFERENCES [dbo].[Employee] ([IdEmpl])
GO
ALTER TABLE [dbo].[ExecutionSequence] CHECK CONSTRAINT [FK_ExecutionSequence_Employee]
GO
ALTER TABLE [dbo].[ExecutionSequence]  WITH CHECK ADD  CONSTRAINT [FK_ExecutionSequence_Service] FOREIGN KEY([IdService])
REFERENCES [dbo].[Service] ([IdService])
GO
ALTER TABLE [dbo].[ExecutionSequence] CHECK CONSTRAINT [FK_ExecutionSequence_Service]
GO
ALTER TABLE [dbo].[InvoiceEquip]  WITH CHECK ADD  CONSTRAINT [FK_InvoiceEquip_Billing] FOREIGN KEY([IdEmpl])
REFERENCES [dbo].[Employee] ([IdEmpl])
GO
ALTER TABLE [dbo].[InvoiceEquip] CHECK CONSTRAINT [FK_InvoiceEquip_Billing]
GO
ALTER TABLE [dbo].[InvoiceEquip]  WITH CHECK ADD  CONSTRAINT [FK_InvoiceEquip_Billing1] FOREIGN KEY([IdBilling])
REFERENCES [dbo].[Billing] ([IdBilling])
GO
ALTER TABLE [dbo].[InvoiceEquip] CHECK CONSTRAINT [FK_InvoiceEquip_Billing1]
GO
ALTER TABLE [dbo].[InvoiceEquip]  WITH CHECK ADD  CONSTRAINT [FK_InvoiceEquip_EqupmentSale] FOREIGN KEY([IdEqui])
REFERENCES [dbo].[EqupmentSale] ([IdEqui])
GO
ALTER TABLE [dbo].[InvoiceEquip] CHECK CONSTRAINT [FK_InvoiceEquip_EqupmentSale]
GO
ALTER TABLE [dbo].[InvoiceService]  WITH CHECK ADD  CONSTRAINT [FK_InvoiceService_Billing] FOREIGN KEY([IdBilling])
REFERENCES [dbo].[Billing] ([IdBilling])
GO
ALTER TABLE [dbo].[InvoiceService] CHECK CONSTRAINT [FK_InvoiceService_Billing]
GO
ALTER TABLE [dbo].[JobHistory]  WITH CHECK ADD  CONSTRAINT [FK_JobHistory_Employee] FOREIGN KEY([IdEmpl])
REFERENCES [dbo].[Employee] ([IdEmpl])
GO
ALTER TABLE [dbo].[JobHistory] CHECK CONSTRAINT [FK_JobHistory_Employee]
GO
ALTER TABLE [dbo].[Part]  WITH CHECK ADD  CONSTRAINT [FK_Part_Client] FOREIGN KEY([IdClient])
REFERENCES [dbo].[Client] ([IdClient])
GO
ALTER TABLE [dbo].[Part] CHECK CONSTRAINT [FK_Part_Client]
GO
ALTER TABLE [dbo].[Part]  WITH CHECK ADD  CONSTRAINT [FK_Part_Employee] FOREIGN KEY([IdEmpl])
REFERENCES [dbo].[Employee] ([IdEmpl])
GO
ALTER TABLE [dbo].[Part] CHECK CONSTRAINT [FK_Part_Employee]
GO
ALTER TABLE [dbo].[Part]  WITH CHECK ADD  CONSTRAINT [FK_Part_Service] FOREIGN KEY([IdService])
REFERENCES [dbo].[Service] ([IdService])
GO
ALTER TABLE [dbo].[Part] CHECK CONSTRAINT [FK_Part_Service]
GO
ALTER TABLE [dbo].[Service]  WITH CHECK ADD  CONSTRAINT [FK_Service_Client] FOREIGN KEY([IdClient])
REFERENCES [dbo].[Client] ([IdClient])
GO
ALTER TABLE [dbo].[Service] CHECK CONSTRAINT [FK_Service_Client]
GO
USE [master]
GO
ALTER DATABASE [PhoneStore] SET  READ_WRITE 
GO
