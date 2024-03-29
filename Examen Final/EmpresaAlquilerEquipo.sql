USE [master]
GO
/****** Object:  Database [EmpresaAlquilerEquipo]    Script Date: 7/12/2020 11:18:13 a. m. ******/
CREATE DATABASE [EmpresaAlquilerEquipo]
 CONTAINMENT = NONE
 ON  PRIMARY 
( NAME = N'EmpresaAlquilerEquipo', FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL15.MSSQLSERVER\MSSQL\DATA\EmpresaAlquilerEquipo.mdf' , SIZE = 8192KB , MAXSIZE = UNLIMITED, FILEGROWTH = 65536KB )
 LOG ON 
( NAME = N'EmpresaAlquilerEquipo_log', FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL15.MSSQLSERVER\MSSQL\DATA\EmpresaAlquilerEquipo_log.ldf' , SIZE = 73728KB , MAXSIZE = 2048GB , FILEGROWTH = 65536KB )
 WITH CATALOG_COLLATION = DATABASE_DEFAULT
GO
ALTER DATABASE [EmpresaAlquilerEquipo] SET COMPATIBILITY_LEVEL = 150
GO
IF (1 = FULLTEXTSERVICEPROPERTY('IsFullTextInstalled'))
begin
EXEC [EmpresaAlquilerEquipo].[dbo].[sp_fulltext_database] @action = 'enable'
end
GO
ALTER DATABASE [EmpresaAlquilerEquipo] SET ANSI_NULL_DEFAULT OFF 
GO
ALTER DATABASE [EmpresaAlquilerEquipo] SET ANSI_NULLS OFF 
GO
ALTER DATABASE [EmpresaAlquilerEquipo] SET ANSI_PADDING OFF 
GO
ALTER DATABASE [EmpresaAlquilerEquipo] SET ANSI_WARNINGS OFF 
GO
ALTER DATABASE [EmpresaAlquilerEquipo] SET ARITHABORT OFF 
GO
ALTER DATABASE [EmpresaAlquilerEquipo] SET AUTO_CLOSE OFF 
GO
ALTER DATABASE [EmpresaAlquilerEquipo] SET AUTO_SHRINK OFF 
GO
ALTER DATABASE [EmpresaAlquilerEquipo] SET AUTO_UPDATE_STATISTICS ON 
GO
ALTER DATABASE [EmpresaAlquilerEquipo] SET CURSOR_CLOSE_ON_COMMIT OFF 
GO
ALTER DATABASE [EmpresaAlquilerEquipo] SET CURSOR_DEFAULT  GLOBAL 
GO
ALTER DATABASE [EmpresaAlquilerEquipo] SET CONCAT_NULL_YIELDS_NULL OFF 
GO
ALTER DATABASE [EmpresaAlquilerEquipo] SET NUMERIC_ROUNDABORT OFF 
GO
ALTER DATABASE [EmpresaAlquilerEquipo] SET QUOTED_IDENTIFIER OFF 
GO
ALTER DATABASE [EmpresaAlquilerEquipo] SET RECURSIVE_TRIGGERS OFF 
GO
ALTER DATABASE [EmpresaAlquilerEquipo] SET  DISABLE_BROKER 
GO
ALTER DATABASE [EmpresaAlquilerEquipo] SET AUTO_UPDATE_STATISTICS_ASYNC OFF 
GO
ALTER DATABASE [EmpresaAlquilerEquipo] SET DATE_CORRELATION_OPTIMIZATION OFF 
GO
ALTER DATABASE [EmpresaAlquilerEquipo] SET TRUSTWORTHY OFF 
GO
ALTER DATABASE [EmpresaAlquilerEquipo] SET ALLOW_SNAPSHOT_ISOLATION OFF 
GO
ALTER DATABASE [EmpresaAlquilerEquipo] SET PARAMETERIZATION SIMPLE 
GO
ALTER DATABASE [EmpresaAlquilerEquipo] SET READ_COMMITTED_SNAPSHOT OFF 
GO
ALTER DATABASE [EmpresaAlquilerEquipo] SET HONOR_BROKER_PRIORITY OFF 
GO
ALTER DATABASE [EmpresaAlquilerEquipo] SET RECOVERY FULL 
GO
ALTER DATABASE [EmpresaAlquilerEquipo] SET  MULTI_USER 
GO
ALTER DATABASE [EmpresaAlquilerEquipo] SET PAGE_VERIFY CHECKSUM  
GO
ALTER DATABASE [EmpresaAlquilerEquipo] SET DB_CHAINING OFF 
GO
ALTER DATABASE [EmpresaAlquilerEquipo] SET FILESTREAM( NON_TRANSACTED_ACCESS = OFF ) 
GO
ALTER DATABASE [EmpresaAlquilerEquipo] SET TARGET_RECOVERY_TIME = 60 SECONDS 
GO
ALTER DATABASE [EmpresaAlquilerEquipo] SET DELAYED_DURABILITY = DISABLED 
GO
EXEC sys.sp_db_vardecimal_storage_format N'EmpresaAlquilerEquipo', N'ON'
GO
ALTER DATABASE [EmpresaAlquilerEquipo] SET QUERY_STORE = OFF
GO
USE [EmpresaAlquilerEquipo]
GO
/****** Object:  Table [dbo].[Cliente]    Script Date: 7/12/2020 11:18:14 a. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Cliente](
	[IdCliente] [nchar](4) NOT NULL,
	[PNombre] [nchar](30) NOT NULL,
	[SNombre] [nchar](30) NULL,
	[PApellido] [nchar](30) NOT NULL,
	[SApellido] [nchar](30) NOT NULL,
	[IdDocumento] [nchar](4) NOT NULL,
	[Direccion] [nchar](254) NULL,
 CONSTRAINT [PK_Cliente] PRIMARY KEY CLUSTERED 
(
	[IdCliente] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[ClienteEquipoAlqui]    Script Date: 7/12/2020 11:18:14 a. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[ClienteEquipoAlqui](
	[IdPropuesta] [nchar](4) NOT NULL,
	[IdProyecto] [nchar](4) NOT NULL,
	[IdCliente] [nchar](4) NOT NULL,
	[IdEquipo] [nchar](4) NOT NULL,
	[CantidadRetirado] [int] NULL,
	[CantidadDisp] [int] NULL,
 CONSTRAINT [PK_ClienteEquipoAlqui] PRIMARY KEY CLUSTERED 
(
	[IdPropuesta] ASC,
	[IdProyecto] ASC,
	[IdCliente] ASC,
	[IdEquipo] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Conteo]    Script Date: 7/12/2020 11:18:14 a. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Conteo](
	[IdConteo] [nchar](4) NOT NULL,
 CONSTRAINT [PK_Conteo] PRIMARY KEY CLUSTERED 
(
	[IdConteo] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[ConteoDespacho]    Script Date: 7/12/2020 11:18:14 a. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[ConteoDespacho](
	[IdConteoDes] [nchar](4) NOT NULL,
	[IdPropuesta] [nchar](4) NOT NULL,
	[IdProyecto] [nchar](4) NOT NULL,
	[IdEquipo] [nchar](4) NOT NULL,
	[CantEquiProp] [int] NULL,
 CONSTRAINT [PK_ConteoDespacho] PRIMARY KEY CLUSTERED 
(
	[IdConteoDes] ASC,
	[IdPropuesta] ASC,
	[IdProyecto] ASC,
	[IdEquipo] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[ConteoDevolucion]    Script Date: 7/12/2020 11:18:14 a. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[ConteoDevolucion](
	[IdConteoDev] [nchar](4) NOT NULL,
	[IdPropuesta] [nchar](4) NOT NULL,
	[IdProyecto] [nchar](4) NOT NULL,
	[IdEquipo] [nchar](4) NOT NULL,
	[Fecha] [date] NULL,
	[Cantidad] [int] NULL,
 CONSTRAINT [PK_ConteoDevolucion] PRIMARY KEY CLUSTERED 
(
	[IdConteoDev] ASC,
	[IdPropuesta] ASC,
	[IdProyecto] ASC,
	[IdEquipo] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[ConteoVenta]    Script Date: 7/12/2020 11:18:14 a. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[ConteoVenta](
	[IdConteoVenta] [nchar](4) NOT NULL,
	[IdPropuesta] [nchar](4) NOT NULL,
	[IdProyecto] [nchar](4) NOT NULL,
	[IdEquipo] [nchar](4) NOT NULL,
	[Fecha] [date] NULL,
	[Cantidad] [int] NULL,
 CONSTRAINT [PK_ConteoVenta] PRIMARY KEY CLUSTERED 
(
	[IdConteoVenta] ASC,
	[IdPropuesta] ASC,
	[IdProyecto] ASC,
	[IdEquipo] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Documento]    Script Date: 7/12/2020 11:18:14 a. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Documento](
	[IdDocumento] [nchar](4) NOT NULL,
	[Tipo] [nchar](10) NOT NULL,
	[Numeracion] [nchar](11) NOT NULL,
 CONSTRAINT [PK_Documento] PRIMARY KEY CLUSTERED 
(
	[IdDocumento] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Equipo]    Script Date: 7/12/2020 11:18:14 a. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Equipo](
	[IdEquipo] [nchar](4) NOT NULL,
	[Descripcion] [nchar](254) NULL,
	[PrecioAlquiler] [money] NULL,
	[PrecioVenta] [money] NULL,
	[CantExistencia] [int] NOT NULL,
	[CantPrestada] [int] NOT NULL,
	[PorcImpuesto] [float] NULL,
 CONSTRAINT [PK_Equipo] PRIMARY KEY CLUSTERED 
(
	[IdEquipo] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Factura]    Script Date: 7/12/2020 11:18:14 a. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Factura](
	[IdFactura] [nchar](4) NOT NULL,
	[Tipo] [nchar](30) NULL,
 CONSTRAINT [PK_Factura] PRIMARY KEY CLUSTERED 
(
	[IdFactura] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[FacturaContinuidad]    Script Date: 7/12/2020 11:18:14 a. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[FacturaContinuidad](
	[IdFacturaCont] [nchar](4) NOT NULL,
	[IdFacturaDes] [nchar](4) NOT NULL,
	[IdPropuesta] [nchar](4) NOT NULL,
	[IdProyecto] [nchar](4) NOT NULL,
	[IdCliente] [nchar](4) NULL,
	[FechaInicial] [date] NULL,
	[FechaFinal] [date] NULL,
	[CantDias] [int] NULL,
	[TotalAlquiler] [money] NULL,
	[EstaPagada] [bit] NULL,
 CONSTRAINT [PK_FacturaContinuidad] PRIMARY KEY CLUSTERED 
(
	[IdFacturaCont] ASC,
	[IdFacturaDes] ASC,
	[IdPropuesta] ASC,
	[IdProyecto] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[FacturaContinuidadSubtotal]    Script Date: 7/12/2020 11:18:14 a. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[FacturaContinuidadSubtotal](
	[IdFacturaCont] [nchar](4) NOT NULL,
	[IdPropuesta] [nchar](4) NOT NULL,
	[IdEquipo] [nchar](4) NOT NULL,
	[IdConteo] [nchar](4) NOT NULL,
	[SubTotalAlquiler] [money] NULL,
 CONSTRAINT [PK_FacturaContinuidadSubtotal] PRIMARY KEY CLUSTERED 
(
	[IdFacturaCont] ASC,
	[IdPropuesta] ASC,
	[IdEquipo] ASC,
	[IdConteo] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[FacturaDespacho-]    Script Date: 7/12/2020 11:18:14 a. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[FacturaDespacho-](
	[IdFacturaDes] [nchar](4) NOT NULL,
	[IdPropuesta] [nchar](4) NOT NULL,
	[IdProyecto] [nchar](4) NOT NULL,
	[IdCliente] [nchar](4) NOT NULL,
	[FechaInicial] [date] NULL,
	[FechaFinal] [date] NULL,
	[CantDias] [int] NULL,
	[TotalAlquiler] [money] NULL,
 CONSTRAINT [PK_FacturaDespacho-] PRIMARY KEY CLUSTERED 
(
	[IdFacturaDes] ASC,
	[IdPropuesta] ASC,
	[IdProyecto] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[FacturaDespachoSubtotal]    Script Date: 7/12/2020 11:18:14 a. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[FacturaDespachoSubtotal](
	[IdFacturaDes] [nchar](4) NOT NULL,
	[IdPropuesta] [nchar](4) NOT NULL,
	[IdProyecto] [nchar](4) NOT NULL,
	[IdEquipo] [nchar](4) NOT NULL,
	[IdConteoDes] [nchar](4) NOT NULL,
	[PrecioAlquiler] [money] NULL,
	[SubTotalAlquiler] [money] NULL,
 CONSTRAINT [PK_FacturaDespachoSubtotal] PRIMARY KEY CLUSTERED 
(
	[IdFacturaDes] ASC,
	[IdPropuesta] ASC,
	[IdProyecto] ASC,
	[IdEquipo] ASC,
	[IdConteoDes] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[FacturaDevolucion]    Script Date: 7/12/2020 11:18:14 a. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[FacturaDevolucion](
	[IdFacturaDev] [nchar](4) NOT NULL,
	[IdFacturaDes] [nchar](4) NOT NULL,
	[IdPropuesta] [nchar](4) NOT NULL,
	[IdProyecto] [nchar](4) NOT NULL,
	[IdFacturaCont] [nchar](4) NULL,
	[IdCliente] [nchar](4) NULL,
	[FechaInicial] [date] NULL,
	[FechaFinal] [date] NULL,
	[CantDias] [int] NULL,
	[TotalAlquiler] [money] NULL,
 CONSTRAINT [PK_FacturaDevolucion] PRIMARY KEY CLUSTERED 
(
	[IdFacturaDev] ASC,
	[IdFacturaDes] ASC,
	[IdPropuesta] ASC,
	[IdProyecto] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[FacturaDevolucionSubtotal]    Script Date: 7/12/2020 11:18:14 a. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[FacturaDevolucionSubtotal](
	[IdFacturaDev] [nchar](4) NOT NULL,
	[IdFacturaDes] [nchar](4) NOT NULL,
	[IdPropuesta] [nchar](4) NOT NULL,
	[IdProyecto] [nchar](4) NOT NULL,
	[IdEquipo] [nchar](4) NOT NULL,
	[IdConteoDev] [nchar](4) NOT NULL,
	[PrecioAlquiler] [money] NULL,
	[SubTotalAlquiler] [money] NULL,
 CONSTRAINT [PK_FacturaDevolucionSubtotal] PRIMARY KEY CLUSTERED 
(
	[IdFacturaDev] ASC,
	[IdFacturaDes] ASC,
	[IdPropuesta] ASC,
	[IdProyecto] ASC,
	[IdEquipo] ASC,
	[IdConteoDev] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[FacturaVenta]    Script Date: 7/12/2020 11:18:14 a. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[FacturaVenta](
	[IdFacturaVenta] [nchar](4) NOT NULL,
	[IdFacturaDev] [nchar](4) NOT NULL,
	[IdFacturaDes] [nchar](4) NOT NULL,
	[IdPropuesta] [nchar](4) NOT NULL,
	[IdProyecto] [nchar](4) NOT NULL,
	[IdCliente] [nchar](4) NULL,
	[TotalVenta] [money] NULL,
 CONSTRAINT [PK_FacturaVenta_1] PRIMARY KEY CLUSTERED 
(
	[IdFacturaVenta] ASC,
	[IdFacturaDev] ASC,
	[IdFacturaDes] ASC,
	[IdPropuesta] ASC,
	[IdProyecto] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[FacturaVentaSubtotal]    Script Date: 7/12/2020 11:18:14 a. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[FacturaVentaSubtotal](
	[IdFacturaVenta] [nchar](4) NOT NULL,
	[IdFacturaDev] [nchar](4) NOT NULL,
	[IdFacturaDes] [nchar](4) NOT NULL,
	[IdPropuesta] [nchar](4) NOT NULL,
	[IdProyecto] [nchar](4) NOT NULL,
	[IdEquipo] [nchar](4) NOT NULL,
	[IdConteoVenta] [nchar](4) NOT NULL,
	[PrecioVenta] [money] NULL,
	[SubTotalVenta] [money] NULL,
 CONSTRAINT [PK_FacturaVentaSubtotal] PRIMARY KEY CLUSTERED 
(
	[IdFacturaVenta] ASC,
	[IdFacturaDev] ASC,
	[IdFacturaDes] ASC,
	[IdPropuesta] ASC,
	[IdProyecto] ASC,
	[IdEquipo] ASC,
	[IdConteoVenta] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Propuesta]    Script Date: 7/12/2020 11:18:14 a. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Propuesta](
	[IdPropuesta] [nchar](4) NOT NULL,
 CONSTRAINT [PK_Propuesta] PRIMARY KEY CLUSTERED 
(
	[IdPropuesta] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[PropuestaProyecto]    Script Date: 7/12/2020 11:18:14 a. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[PropuestaProyecto](
	[IdPropuesta] [nchar](4) NOT NULL,
	[IdProyecto] [nchar](4) NOT NULL,
	[Descripcion] [nchar](254) NULL,
	[IdCliente] [nchar](4) NULL,
	[Fecha] [date] NULL,
	[Estatus] [bit] NULL,
	[PorcentajeDescuento] [float] NULL,
	[Impuesto] [float] NULL,
	[MontoDeposito] [money] NULL,
 CONSTRAINT [PK_PropuestaProyecto_1] PRIMARY KEY CLUSTERED 
(
	[IdPropuesta] ASC,
	[IdProyecto] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[PropuestaSubTotal]    Script Date: 7/12/2020 11:18:14 a. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[PropuestaSubTotal](
	[IdPropuesta] [nchar](4) NOT NULL,
	[IdProyecto] [nchar](4) NOT NULL,
	[IdEquipo] [nchar](4) NOT NULL,
	[Cantidad] [int] NULL,
	[CantidadDevuelto] [int] NULL,
	[PrecioAlquiler] [money] NULL,
	[PrecioVenta] [money] NULL,
	[SubTotalAlquiler] [money] NULL,
	[SubTotalVenta] [money] NULL,
 CONSTRAINT [PK_PropuestaSubTotal] PRIMARY KEY CLUSTERED 
(
	[IdPropuesta] ASC,
	[IdProyecto] ASC,
	[IdEquipo] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Proyecto]    Script Date: 7/12/2020 11:18:14 a. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Proyecto](
	[IdProyecto] [nchar](4) NOT NULL,
	[Descripcion] [nchar](254) NULL,
	[Direccion] [nchar](254) NULL,
	[IdCliente] [nchar](4) NULL,
	[MontoTotalDeposito] [money] NULL,
	[MontoProyectoAud] [money] NULL,
	[EstaCerrado] [bit] NULL,
 CONSTRAINT [PK_Proyecto] PRIMARY KEY CLUSTERED 
(
	[IdProyecto] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
ALTER TABLE [dbo].[Cliente]  WITH CHECK ADD  CONSTRAINT [FK_Cliente_Documento] FOREIGN KEY([IdDocumento])
REFERENCES [dbo].[Documento] ([IdDocumento])
GO
ALTER TABLE [dbo].[Cliente] CHECK CONSTRAINT [FK_Cliente_Documento]
GO
ALTER TABLE [dbo].[ClienteEquipoAlqui]  WITH CHECK ADD  CONSTRAINT [FK_ClienteEquipoAlqui_Cliente] FOREIGN KEY([IdCliente])
REFERENCES [dbo].[Cliente] ([IdCliente])
GO
ALTER TABLE [dbo].[ClienteEquipoAlqui] CHECK CONSTRAINT [FK_ClienteEquipoAlqui_Cliente]
GO
ALTER TABLE [dbo].[ClienteEquipoAlqui]  WITH CHECK ADD  CONSTRAINT [FK_ClienteEquipoAlqui_Equipo] FOREIGN KEY([IdEquipo])
REFERENCES [dbo].[Equipo] ([IdEquipo])
GO
ALTER TABLE [dbo].[ClienteEquipoAlqui] CHECK CONSTRAINT [FK_ClienteEquipoAlqui_Equipo]
GO
ALTER TABLE [dbo].[ClienteEquipoAlqui]  WITH CHECK ADD  CONSTRAINT [FK_ClienteEquipoAlqui_PropuestaProyecto] FOREIGN KEY([IdPropuesta], [IdProyecto])
REFERENCES [dbo].[PropuestaProyecto] ([IdPropuesta], [IdProyecto])
GO
ALTER TABLE [dbo].[ClienteEquipoAlqui] CHECK CONSTRAINT [FK_ClienteEquipoAlqui_PropuestaProyecto]
GO
ALTER TABLE [dbo].[ConteoDespacho]  WITH CHECK ADD  CONSTRAINT [FK_ConteoDespacho_Conteo] FOREIGN KEY([IdConteoDes])
REFERENCES [dbo].[Conteo] ([IdConteo])
GO
ALTER TABLE [dbo].[ConteoDespacho] CHECK CONSTRAINT [FK_ConteoDespacho_Conteo]
GO
ALTER TABLE [dbo].[ConteoDespacho]  WITH CHECK ADD  CONSTRAINT [FK_ConteoDespacho_ConteoDespacho] FOREIGN KEY([IdPropuesta], [IdProyecto])
REFERENCES [dbo].[PropuestaProyecto] ([IdPropuesta], [IdProyecto])
GO
ALTER TABLE [dbo].[ConteoDespacho] CHECK CONSTRAINT [FK_ConteoDespacho_ConteoDespacho]
GO
ALTER TABLE [dbo].[ConteoDespacho]  WITH CHECK ADD  CONSTRAINT [FK_ConteoDespacho_Equipo] FOREIGN KEY([IdEquipo])
REFERENCES [dbo].[Equipo] ([IdEquipo])
GO
ALTER TABLE [dbo].[ConteoDespacho] CHECK CONSTRAINT [FK_ConteoDespacho_Equipo]
GO
ALTER TABLE [dbo].[ConteoDevolucion]  WITH CHECK ADD  CONSTRAINT [FK_ConteoDevolucion_Conteo] FOREIGN KEY([IdConteoDev])
REFERENCES [dbo].[Conteo] ([IdConteo])
GO
ALTER TABLE [dbo].[ConteoDevolucion] CHECK CONSTRAINT [FK_ConteoDevolucion_Conteo]
GO
ALTER TABLE [dbo].[ConteoDevolucion]  WITH CHECK ADD  CONSTRAINT [FK_ConteoDevolucion_Equipo] FOREIGN KEY([IdEquipo])
REFERENCES [dbo].[Equipo] ([IdEquipo])
GO
ALTER TABLE [dbo].[ConteoDevolucion] CHECK CONSTRAINT [FK_ConteoDevolucion_Equipo]
GO
ALTER TABLE [dbo].[ConteoDevolucion]  WITH CHECK ADD  CONSTRAINT [FK_ConteoDevolucion_PropuestaProyecto] FOREIGN KEY([IdPropuesta], [IdProyecto])
REFERENCES [dbo].[PropuestaProyecto] ([IdPropuesta], [IdProyecto])
GO
ALTER TABLE [dbo].[ConteoDevolucion] CHECK CONSTRAINT [FK_ConteoDevolucion_PropuestaProyecto]
GO
ALTER TABLE [dbo].[ConteoVenta]  WITH CHECK ADD  CONSTRAINT [FK_ConteoVenta_Conteo] FOREIGN KEY([IdConteoVenta])
REFERENCES [dbo].[Conteo] ([IdConteo])
GO
ALTER TABLE [dbo].[ConteoVenta] CHECK CONSTRAINT [FK_ConteoVenta_Conteo]
GO
ALTER TABLE [dbo].[ConteoVenta]  WITH CHECK ADD  CONSTRAINT [FK_ConteoVenta_Equipo] FOREIGN KEY([IdEquipo])
REFERENCES [dbo].[Equipo] ([IdEquipo])
GO
ALTER TABLE [dbo].[ConteoVenta] CHECK CONSTRAINT [FK_ConteoVenta_Equipo]
GO
ALTER TABLE [dbo].[ConteoVenta]  WITH CHECK ADD  CONSTRAINT [FK_ConteoVenta_PropuestaProyecto] FOREIGN KEY([IdPropuesta], [IdProyecto])
REFERENCES [dbo].[PropuestaProyecto] ([IdPropuesta], [IdProyecto])
GO
ALTER TABLE [dbo].[ConteoVenta] CHECK CONSTRAINT [FK_ConteoVenta_PropuestaProyecto]
GO
ALTER TABLE [dbo].[FacturaContinuidad]  WITH CHECK ADD  CONSTRAINT [FK_FacturaContinuidad_Cliente] FOREIGN KEY([IdCliente])
REFERENCES [dbo].[Cliente] ([IdCliente])
GO
ALTER TABLE [dbo].[FacturaContinuidad] CHECK CONSTRAINT [FK_FacturaContinuidad_Cliente]
GO
ALTER TABLE [dbo].[FacturaContinuidad]  WITH CHECK ADD  CONSTRAINT [FK_FacturaContinuidad_Factura] FOREIGN KEY([IdFacturaCont])
REFERENCES [dbo].[Factura] ([IdFactura])
GO
ALTER TABLE [dbo].[FacturaContinuidad] CHECK CONSTRAINT [FK_FacturaContinuidad_Factura]
GO
ALTER TABLE [dbo].[FacturaContinuidad]  WITH CHECK ADD  CONSTRAINT [FK_FacturaContinuidad_FacturaDespacho-] FOREIGN KEY([IdFacturaDes], [IdPropuesta], [IdProyecto])
REFERENCES [dbo].[FacturaDespacho-] ([IdFacturaDes], [IdPropuesta], [IdProyecto])
GO
ALTER TABLE [dbo].[FacturaContinuidad] CHECK CONSTRAINT [FK_FacturaContinuidad_FacturaDespacho-]
GO
ALTER TABLE [dbo].[FacturaDespacho-]  WITH CHECK ADD  CONSTRAINT [FK_FacturaDespacho-_Cliente] FOREIGN KEY([IdCliente])
REFERENCES [dbo].[Cliente] ([IdCliente])
GO
ALTER TABLE [dbo].[FacturaDespacho-] CHECK CONSTRAINT [FK_FacturaDespacho-_Cliente]
GO
ALTER TABLE [dbo].[FacturaDespacho-]  WITH CHECK ADD  CONSTRAINT [FK_FacturaDespacho-_Factura] FOREIGN KEY([IdFacturaDes])
REFERENCES [dbo].[Factura] ([IdFactura])
GO
ALTER TABLE [dbo].[FacturaDespacho-] CHECK CONSTRAINT [FK_FacturaDespacho-_Factura]
GO
ALTER TABLE [dbo].[FacturaDespacho-]  WITH CHECK ADD  CONSTRAINT [FK_FacturaDespacho-_PropuestaProyecto] FOREIGN KEY([IdPropuesta], [IdProyecto])
REFERENCES [dbo].[PropuestaProyecto] ([IdPropuesta], [IdProyecto])
GO
ALTER TABLE [dbo].[FacturaDespacho-] CHECK CONSTRAINT [FK_FacturaDespacho-_PropuestaProyecto]
GO
ALTER TABLE [dbo].[FacturaDespachoSubtotal]  WITH CHECK ADD  CONSTRAINT [FK_FacturaDespachoSubtotal_ConteoDespacho] FOREIGN KEY([IdConteoDes], [IdPropuesta], [IdProyecto], [IdEquipo])
REFERENCES [dbo].[ConteoDespacho] ([IdConteoDes], [IdPropuesta], [IdProyecto], [IdEquipo])
GO
ALTER TABLE [dbo].[FacturaDespachoSubtotal] CHECK CONSTRAINT [FK_FacturaDespachoSubtotal_ConteoDespacho]
GO
ALTER TABLE [dbo].[FacturaDespachoSubtotal]  WITH CHECK ADD  CONSTRAINT [FK_FacturaDespachoSubtotal_FacturaDespacho-] FOREIGN KEY([IdFacturaDes], [IdPropuesta], [IdProyecto])
REFERENCES [dbo].[FacturaDespacho-] ([IdFacturaDes], [IdPropuesta], [IdProyecto])
GO
ALTER TABLE [dbo].[FacturaDespachoSubtotal] CHECK CONSTRAINT [FK_FacturaDespachoSubtotal_FacturaDespacho-]
GO
ALTER TABLE [dbo].[FacturaDevolucion]  WITH CHECK ADD  CONSTRAINT [FK_FacturaDevolucion_Cliente] FOREIGN KEY([IdCliente])
REFERENCES [dbo].[Cliente] ([IdCliente])
GO
ALTER TABLE [dbo].[FacturaDevolucion] CHECK CONSTRAINT [FK_FacturaDevolucion_Cliente]
GO
ALTER TABLE [dbo].[FacturaDevolucion]  WITH CHECK ADD  CONSTRAINT [FK_FacturaDevolucion_Factura] FOREIGN KEY([IdFacturaDev])
REFERENCES [dbo].[Factura] ([IdFactura])
GO
ALTER TABLE [dbo].[FacturaDevolucion] CHECK CONSTRAINT [FK_FacturaDevolucion_Factura]
GO
ALTER TABLE [dbo].[FacturaDevolucion]  WITH CHECK ADD  CONSTRAINT [FK_FacturaDevolucion_FacturaDespacho-] FOREIGN KEY([IdFacturaDes], [IdPropuesta], [IdProyecto])
REFERENCES [dbo].[FacturaDespacho-] ([IdFacturaDes], [IdPropuesta], [IdProyecto])
GO
ALTER TABLE [dbo].[FacturaDevolucion] CHECK CONSTRAINT [FK_FacturaDevolucion_FacturaDespacho-]
GO
ALTER TABLE [dbo].[FacturaDevolucionSubtotal]  WITH CHECK ADD  CONSTRAINT [FK_FacturaDevolucionSubtotal_ConteoDevolucion] FOREIGN KEY([IdConteoDev], [IdPropuesta], [IdProyecto], [IdEquipo])
REFERENCES [dbo].[ConteoDevolucion] ([IdConteoDev], [IdPropuesta], [IdProyecto], [IdEquipo])
GO
ALTER TABLE [dbo].[FacturaDevolucionSubtotal] CHECK CONSTRAINT [FK_FacturaDevolucionSubtotal_ConteoDevolucion]
GO
ALTER TABLE [dbo].[FacturaDevolucionSubtotal]  WITH CHECK ADD  CONSTRAINT [FK_FacturaDevolucionSubtotal_FacturaDevolucion] FOREIGN KEY([IdFacturaDev], [IdFacturaDes], [IdPropuesta], [IdProyecto])
REFERENCES [dbo].[FacturaDevolucion] ([IdFacturaDev], [IdFacturaDes], [IdPropuesta], [IdProyecto])
GO
ALTER TABLE [dbo].[FacturaDevolucionSubtotal] CHECK CONSTRAINT [FK_FacturaDevolucionSubtotal_FacturaDevolucion]
GO
ALTER TABLE [dbo].[FacturaVenta]  WITH CHECK ADD  CONSTRAINT [FK_FacturaVenta_Cliente] FOREIGN KEY([IdCliente])
REFERENCES [dbo].[Cliente] ([IdCliente])
GO
ALTER TABLE [dbo].[FacturaVenta] CHECK CONSTRAINT [FK_FacturaVenta_Cliente]
GO
ALTER TABLE [dbo].[FacturaVenta]  WITH CHECK ADD  CONSTRAINT [FK_FacturaVenta_Factura] FOREIGN KEY([IdFacturaVenta])
REFERENCES [dbo].[Factura] ([IdFactura])
GO
ALTER TABLE [dbo].[FacturaVenta] CHECK CONSTRAINT [FK_FacturaVenta_Factura]
GO
ALTER TABLE [dbo].[FacturaVenta]  WITH CHECK ADD  CONSTRAINT [FK_FacturaVenta_FacturaDevolucion] FOREIGN KEY([IdFacturaDev], [IdFacturaDes], [IdPropuesta], [IdProyecto])
REFERENCES [dbo].[FacturaDevolucion] ([IdFacturaDev], [IdFacturaDes], [IdPropuesta], [IdProyecto])
GO
ALTER TABLE [dbo].[FacturaVenta] CHECK CONSTRAINT [FK_FacturaVenta_FacturaDevolucion]
GO
ALTER TABLE [dbo].[FacturaVentaSubtotal]  WITH CHECK ADD  CONSTRAINT [FK_FacturaVentaSubtotal_ConteoVenta] FOREIGN KEY([IdConteoVenta], [IdPropuesta], [IdProyecto], [IdEquipo])
REFERENCES [dbo].[ConteoVenta] ([IdConteoVenta], [IdPropuesta], [IdProyecto], [IdEquipo])
GO
ALTER TABLE [dbo].[FacturaVentaSubtotal] CHECK CONSTRAINT [FK_FacturaVentaSubtotal_ConteoVenta]
GO
ALTER TABLE [dbo].[FacturaVentaSubtotal]  WITH CHECK ADD  CONSTRAINT [FK_FacturaVentaSubtotal_FacturaVenta] FOREIGN KEY([IdFacturaVenta], [IdFacturaDev], [IdFacturaDes], [IdPropuesta], [IdProyecto])
REFERENCES [dbo].[FacturaVenta] ([IdFacturaVenta], [IdFacturaDev], [IdFacturaDes], [IdPropuesta], [IdProyecto])
GO
ALTER TABLE [dbo].[FacturaVentaSubtotal] CHECK CONSTRAINT [FK_FacturaVentaSubtotal_FacturaVenta]
GO
ALTER TABLE [dbo].[PropuestaProyecto]  WITH CHECK ADD  CONSTRAINT [FK_PropuestaProyecto_Propuesta] FOREIGN KEY([IdPropuesta])
REFERENCES [dbo].[Propuesta] ([IdPropuesta])
GO
ALTER TABLE [dbo].[PropuestaProyecto] CHECK CONSTRAINT [FK_PropuestaProyecto_Propuesta]
GO
ALTER TABLE [dbo].[PropuestaProyecto]  WITH CHECK ADD  CONSTRAINT [FK_PropuestaProyecto_Proyecto] FOREIGN KEY([IdProyecto])
REFERENCES [dbo].[Proyecto] ([IdProyecto])
GO
ALTER TABLE [dbo].[PropuestaProyecto] CHECK CONSTRAINT [FK_PropuestaProyecto_Proyecto]
GO
ALTER TABLE [dbo].[PropuestaSubTotal]  WITH CHECK ADD  CONSTRAINT [FK_PropuestaSubTotal_Equipo] FOREIGN KEY([IdPropuesta], [IdProyecto])
REFERENCES [dbo].[PropuestaProyecto] ([IdPropuesta], [IdProyecto])
GO
ALTER TABLE [dbo].[PropuestaSubTotal] CHECK CONSTRAINT [FK_PropuestaSubTotal_Equipo]
GO
/****** Object:  Trigger [dbo].[TriggerInsertConteoDespacho]    Script Date: 7/12/2020 11:18:14 a. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		Víctor Gómez
-- Create date: 06-12-2020
-- Description:	
-- =============================================
CREATE TRIGGER [dbo].[TriggerInsertConteoDespacho]
   ON  [dbo].[ConteoDespacho]
   AFTER INSERT
AS 
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    -- Insert statements for trigger here
		IF( (SELECT PropuestaProyecto.Estatus FROM PropuestaProyecto, inserted WHERE PropuestaProyecto.IdPropuesta = inserted.IdPropuesta AND 
		PropuestaProyecto.IdProyecto = inserted.IdProyecto) = 0)
		BEGIN
			THROW 70001,'Esta propuesta no ha sido aprobada.',1
			ROLLBACK;
		END
 

END
GO
ALTER TABLE [dbo].[ConteoDespacho] ENABLE TRIGGER [TriggerInsertConteoDespacho]
GO
/****** Object:  Trigger [dbo].[TriggerInsertFacturaContinuidad]    Script Date: 7/12/2020 11:18:14 a. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		Víctor Gómez
-- Create date: 06-12-2020
-- Description:	
-- =============================================
CREATE TRIGGER [dbo].[TriggerInsertFacturaContinuidad]
   ON  [dbo].[FacturaContinuidad]
   AFTER INSERT
AS 
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;
	IF( (SELECT DATEDIFF(day,inserted.FechaInicial,inserted.FechaFinal) FROM inserted) != 30)
	BEGIN
		THROW 70001,'La factura de continuidad debe ser de 30 días.',1
		ROLLBACK;
	END


	DECLARE @IdFacturaCont AS nchar(4) = (SELECT IdFacturaCont FROM inserted)
	DECLARE @IdFacturaDes AS nchar(4) = (SELECT IdFacturaDes FROM inserted)
	DECLARE @IdPropuesta AS nchar(4) = (SELECT IdPropuesta FROM inserted)
	DECLARE @IdProyecto AS nchar(4) = (SELECT IdProyecto FROM inserted)



    -- Insert statements for trigger here
	DECLARE @TotalAlquiler AS nchar(4) = (SELECT [FacturaDespacho-].TotalAlquiler FROM [FacturaDespacho-],inserted WHERE [FacturaDespacho-].IdFacturaDes = inserted.IdFacturaDes
	AND [FacturaDespacho-].IdPropuesta = @IdPropuesta AND [FacturaDespacho-].IdProyecto = @IdProyecto)

	UPDATE FacturaContinuidad
	SET TotalAlquiler = @TotalAlquiler 
	WHERE IdFacturaCont = @IdFacturaCont AND IdFacturaDes = @IdFacturaDes AND IdPropuesta = @IdPropuesta AND IdProyecto =@IdProyecto 

END
GO
ALTER TABLE [dbo].[FacturaContinuidad] ENABLE TRIGGER [TriggerInsertFacturaContinuidad]
GO
/****** Object:  Trigger [dbo].[TriggerInsertFacturaDespachoDespacho]    Script Date: 7/12/2020 11:18:15 a. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		Víctor Gómez
-- Create date: 06-12-2020
-- Description:	
-- =============================================
CREATE TRIGGER [dbo].[TriggerInsertFacturaDespachoDespacho]
   ON  [dbo].[FacturaDespacho-]
   AFTER INSERT
AS 
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;
	IF( (SELECT DATEDIFF(day,inserted.FechaInicial,inserted.FechaFinal) FROM inserted) != 30)
	BEGIN
		THROW 70001,'La factura de despacho debe ser de 30 días.',1
		ROLLBACK;
	END


	DECLARE @IdFacturaDes AS nchar(4) = (SELECT IdFacturaDes FROM inserted)
	DECLARE @IdPropuesta AS nchar(4) = (SELECT IdPropuesta FROM inserted)
	DECLARE @IdProyecto AS nchar(4) = (SELECT IdProyecto FROM inserted)



    -- Insert statements for trigger here
	DECLARE @TotalAlquiler AS nchar(4) = (SELECT SUM(SubTotalAlquiler) FROM [FacturaDespachoSubtotal] WHERE [FacturaDespachoSubtotal].IdFacturaDes = @IdFacturaDes
	AND [FacturaDespachoSubtotal].IdPropuesta = @IdPropuesta AND [FacturaDespachoSubtotal].IdProyecto = @IdProyecto GROUP BY IdFacturaDes,IdPropuesta,IdProyecto)

	UPDATE [FacturaDespacho-]
	SET TotalAlquiler = @TotalAlquiler , CantDias = (SELECT DATEDIFF(day,inserted.FechaInicial,inserted.FechaFinal) FROM inserted)
	WHERE IdFacturaDes = @IdFacturaDes AND IdPropuesta = @IdPropuesta AND IdProyecto =@IdProyecto
	
	UPDATE PropuestaProyecto
	SET MontoDeposito = MontoDeposito + @TotalAlquiler
	WHERE IdPropuesta = @IdPropuesta AND IdProyecto = @IdProyecto

END
GO
ALTER TABLE [dbo].[FacturaDespacho-] ENABLE TRIGGER [TriggerInsertFacturaDespachoDespacho]
GO
/****** Object:  Trigger [dbo].[TriggerInsertFacturaDespachoSubtotal]    Script Date: 7/12/2020 11:18:15 a. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		Víctor Gómez
-- Create date: 06-12-2020
-- Description:	
-- =============================================
CREATE TRIGGER [dbo].[TriggerInsertFacturaDespachoSubtotal]
   ON  [dbo].[FacturaDespachoSubtotal]
   AFTER INSERT
AS 
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;
		IF( (SELECT ConteoDespacho.CantEquiProp FROM inserted,ConteoDespacho WHERE  ConteoDespacho.IdConteoDes = inserted.IdConteoDes) > (SELECT Equipo.CantExistencia FROM Equipo,inserted WHERE Equipo.IdEquipo = inserted.IdEquipo) )
	BEGIN
		THROW 70001,'No se puede generar una factura despacho Subtotal con mas equipos de los que existen en el invertario.',1
		ROLLBACK;
	END

	DECLARE @IdFacturaDes AS nchar(4) = (SELECT IdFacturaDes FROM inserted)
	DECLARE @IdPropuesta AS nchar(4) = (SELECT IdPropuesta FROM inserted)
	DECLARE @IdProyecto AS nchar(4) = (SELECT IdProyecto FROM inserted)
	DECLARE @IdEquipo AS nchar(4) = (SELECT IdEquipo FROM inserted)
	DECLARE @IdConteoDes AS nchar(4) = (SELECT IdConteoDes FROM inserted)

	DECLARE @IdCliente AS nchar(4) = (SELECT [FacturaDespacho-].IdCliente FROM inserted,[FacturaDespacho-] WHERE [FacturaDespacho-].IdFacturaDes = inserted.IdFacturaDes AND
	[FacturaDespacho-].IdPropuesta = inserted.IdPropuesta AND [FacturaDespacho-].IdProyecto = inserted.IdProyecto)


    -- Insert statements for trigger here
	DECLARE @PrecioAlquiler AS nchar(4) = (SELECT Equipo.PrecioAlquiler FROM inserted,equipo WHERE inserted.IdEquipo = Equipo.IdEquipo)

	DECLARE @CantidadAlquilado AS int = (SELECT ConteoDespacho.CantEquiProp FROM inserted,ConteoDespacho WHERE ConteoDespacho.IdConteoDes = inserted.IdConteoDes AND
	ConteoDespacho.IdPropuesta = inserted.IdPropuesta AND ConteoDespacho.IdProyecto = inserted.IdProyecto AND
	ConteoDespacho.IdEquipo = inserted.IdEquipo)

	DECLARE @SubtotalAlquiler AS nchar(4) = @CantidadAlquilado* @PrecioAlquiler

	UPDATE FacturaDespachoSubtotal
	SET PrecioAlquiler = @PrecioAlquiler, SubTotalAlquiler = @SubtotalAlquiler
	WHERE IdFacturaDes = @IdFacturaDes AND IdPropuesta = @IdPropuesta AND IdProyecto =@IdProyecto AND IdEquipo = @IdEquipo AND
	IdConteoDes = @IdConteoDes

	UPDATE Equipo
	SET CantExistencia = CantExistencia - @CantidadAlquilado,CantPrestada = CantPrestada + @CantidadAlquilado
	WHERE IdEquipo = @IdEquipo

	UPDATE ClienteEquipoAlqui
	SET CantidadDisp = @CantidadAlquilado
	WHERE IdPropuesta = @IdPropuesta AND IdProyecto = @IdProyecto AND IdCliente = @IdCliente AND IdEquipo = @IdEquipo

END
GO
ALTER TABLE [dbo].[FacturaDespachoSubtotal] ENABLE TRIGGER [TriggerInsertFacturaDespachoSubtotal]
GO
/****** Object:  Trigger [dbo].[TriggerInsertFacturaDevolucion]    Script Date: 7/12/2020 11:18:15 a. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		Víctor Gómez
-- Create date: 06-12-2020
-- Description:	
-- =============================================
CREATE TRIGGER [dbo].[TriggerInsertFacturaDevolucion]
   ON  [dbo].[FacturaDevolucion]
   AFTER INSERT
AS 
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;
	



	DECLARE @IdFacturaDev AS nchar(4) = (SELECT IdFacturaDev FROM inserted)
	DECLARE @IdFacturaDes AS nchar(4) = (SELECT IdFacturaDes FROM inserted)
	DECLARE @IdPropuesta AS nchar(4) = (SELECT IdPropuesta FROM inserted)
	DECLARE @IdProyecto AS nchar(4) = (SELECT IdProyecto FROM inserted)

	DECLARE @IdFacturaCont AS nchar(4) = (SELECT IdFacturaCont FROM inserted)



    -- Insert statements for trigger here
	DECLARE @TotalAlquiler AS nchar(4) = (SELECT SUM(SubTotalAlquiler) FROM FacturaDevolucionSubtotal WHERE FacturaDevolucionSubtotal.IdFacturaDes = @IdFacturaDes
	AND FacturaDevolucionSubtotal.IdFacturaDev = @IdFacturaDev AND FacturaDevolucionSubtotal.IdPropuesta = @IdPropuesta AND FacturaDevolucionSubtotal.IdProyecto = @IdProyecto
	GROUP BY IdFacturaDes,IdFacturaDev,IdPropuesta,IdProyecto)

	DECLARE @CantDias AS int = (SELECT DATEDIFF(day,inserted.FechaInicial,inserted.FechaFinal) FROM inserted)
	
	IF(@IdFacturaCont != NULL)
	BEGIN
		UPDATE FacturaDevolucion
		SET TotalAlquiler = @TotalAlquiler*(@CantDias/30) , CantDias = @CantDias
		WHERE IdFacturaDev = @IdFacturaDev AND IdFacturaDes = @IdFacturaDes AND IdPropuesta = @IdPropuesta AND IdProyecto =@IdProyecto 
	END
	
	ELSE
	BEGIN
		UPDATE FacturaDevolucion
		SET TotalAlquiler = 0 , CantDias = @CantDias
		WHERE IdFacturaDev = @IdFacturaDev AND IdFacturaDes = @IdFacturaDes AND IdPropuesta = @IdPropuesta AND IdProyecto =@IdProyecto 
	END

END
GO
ALTER TABLE [dbo].[FacturaDevolucion] ENABLE TRIGGER [TriggerInsertFacturaDevolucion]
GO
/****** Object:  Trigger [dbo].[TriggerInsertFacturaDevolucionSubtotal]    Script Date: 7/12/2020 11:18:15 a. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		Víctor Gómez
-- Create date: 06-12-2020
-- Description:	
-- =============================================
CREATE TRIGGER [dbo].[TriggerInsertFacturaDevolucionSubtotal]
   ON [dbo].[FacturaDevolucionSubtotal]
   AFTER INSERT
AS 
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;
			IF( (SELECT ConteoDevolucion.Cantidad FROM inserted,ConteoDevolucion WHERE  ConteoDevolucion.IdConteoDev = inserted.IdConteoDev) < (SELECT Equipo.CantPrestada FROM Equipo,inserted WHERE Equipo.IdEquipo = inserted.IdEquipo) )
	BEGIN
		THROW 70001,'No se puede generar una factura devolucion Subtotal con mas equipos de los que se prestaron en el invertario.',1
		ROLLBACK;
	END


	DECLARE @IdFacturaDev AS nchar(4) = (SELECT IdFacturaDev FROM inserted)
	DECLARE @IdFacturaDes AS nchar(4) = (SELECT IdFacturaDes FROM inserted)
	DECLARE @IdPropuesta AS nchar(4) = (SELECT IdPropuesta FROM inserted)
	DECLARE @IdProyecto AS nchar(4) = (SELECT IdProyecto FROM inserted)
	DECLARE @IdEquipo AS nchar(4) = (SELECT IdEquipo FROM inserted)
	DECLARE @IdConteoDev AS nchar(4) = (SELECT IdConteoDev FROM inserted)

	DECLARE @IdCliente AS nchar(4) = (SELECT FacturaDevolucion.IdCliente FROM inserted,FacturaDevolucion WHERE  FacturaDevolucion.IdFacturaDev = inserted.IdFacturaDev AND FacturaDevolucion.IdFacturaDes = inserted.IdFacturaDes AND
	FacturaDevolucion.IdPropuesta = inserted.IdPropuesta AND FacturaDevolucion.IdProyecto = inserted.IdProyecto)


    -- Insert statements for trigger here
	DECLARE @PrecioAlquiler AS nchar(4) = (SELECT Equipo.PrecioAlquiler FROM inserted,equipo WHERE inserted.IdEquipo = Equipo.IdEquipo)

	DECLARE @CantidadAlquilado AS int = (SELECT ConteoDevolucion.Cantidad FROM inserted,ConteoDevolucion WHERE ConteoDevolucion.IdConteoDev = inserted.IdConteoDev 
	AND ConteoDevolucion.IdPropuesta = inserted.IdPropuesta AND ConteoDevolucion.IdProyecto = inserted.IdProyecto AND
	ConteoDevolucion.IdEquipo = inserted.IdEquipo)

	DECLARE @SubtotalAlquiler AS nchar(4) = @CantidadAlquilado* @PrecioAlquiler

	UPDATE [FacturaDevolucionSubtotal]
	SET PrecioAlquiler = @PrecioAlquiler, SubTotalAlquiler = @SubtotalAlquiler
	WHERE IdFacturaDes = @IdFacturaDes AND IdPropuesta = @IdPropuesta AND IdProyecto =@IdProyecto AND IdEquipo = @IdEquipo AND
	IdConteoDev = @IdConteoDev

	UPDATE Equipo
	SET CantExistencia = CantExistencia + @CantidadAlquilado,CantPrestada = CantPrestada - @CantidadAlquilado
	WHERE IdEquipo = @IdEquipo

	UPDATE ClienteEquipoAlqui
	SET CantidadRetirado = CantidadRetirado + @CantidadAlquilado
	WHERE IdPropuesta = @IdPropuesta AND IdProyecto = @IdProyecto AND IdCliente = @IdCliente AND IdEquipo = @IdEquipo

	IF( (SELECT CantidadRetirado FROM ClienteEquipoAlqui) = (SELECT CantidadDisp FROM ClienteEquipoAlqui) )
	BEGIN 
		UPDATE PropuestaProyecto
		SET Estatus = 0
		WHERE IdPropuesta = @IdPropuesta AND IdProyecto =@IdProyecto
	END

END
GO
ALTER TABLE [dbo].[FacturaDevolucionSubtotal] ENABLE TRIGGER [TriggerInsertFacturaDevolucionSubtotal]
GO
/****** Object:  Trigger [dbo].[TriggerInsertFacturaVenta]    Script Date: 7/12/2020 11:18:15 a. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		Víctor Gómez
-- Create date: 06-12-2020
-- Description:	
-- =============================================
CREATE TRIGGER [dbo].[TriggerInsertFacturaVenta]
   ON  [dbo].[FacturaVenta]
   AFTER INSERT
AS 
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;
	


	DECLARE @IdFacturaVenta AS nchar(4) = (SELECT IdFacturaVenta FROM inserted)
	DECLARE @IdFacturaDev AS nchar(4) = (SELECT IdFacturaDev FROM inserted)
	DECLARE @IdFacturaDes AS nchar(4) = (SELECT IdFacturaDes FROM inserted)
	DECLARE @IdPropuesta AS nchar(4) = (SELECT IdPropuesta FROM inserted)
	DECLARE @IdProyecto AS nchar(4) = (SELECT IdProyecto FROM inserted)




    -- Insert statements for trigger here
	DECLARE @TotalVenta AS nchar(4) = (SELECT SUM(SubTotalVenta) FROM FacturaVentaSubtotal WHERE FacturaVentaSubtotal.IdFacturaVenta = @IdFacturaVenta AND
	FacturaVentaSubtotal.IdFacturaDes = @IdFacturaDes AND FacturaVentaSubtotal.IdFacturaDev = @IdFacturaDev AND 
	FacturaVentaSubtotal.IdPropuesta = @IdPropuesta AND FacturaVentaSubtotal.IdProyecto = @IdProyecto
	GROUP BY IdFacturaDes,IdFacturaDev,IdPropuesta,IdProyecto)

	
	UPDATE FacturaVenta
	SET TotalVenta = @TotalVenta
	WHERE IdFacturaVenta = @IdFacturaVenta AND IdFacturaDev = @IdFacturaDev AND IdFacturaDes = @IdFacturaDes AND IdPropuesta = @IdPropuesta AND IdProyecto =@IdProyecto 

	


END
GO
ALTER TABLE [dbo].[FacturaVenta] ENABLE TRIGGER [TriggerInsertFacturaVenta]
GO
/****** Object:  Trigger [dbo].[TriggerInsertFacturaVentaSubtotal]    Script Date: 7/12/2020 11:18:15 a. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		Víctor Gómez
-- Create date: 06-12-2020
-- Description:	
-- =============================================
CREATE TRIGGER [dbo].[TriggerInsertFacturaVentaSubtotal]
   ON [dbo].[FacturaVentaSubtotal]
   AFTER INSERT
AS 
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

	DECLARE @IdFacturaVenta AS nchar(4) = (SELECT IdFacturaVenta FROM inserted)
	DECLARE @IdFacturaDev AS nchar(4) = (SELECT IdFacturaDev FROM inserted)
	DECLARE @IdFacturaDes AS nchar(4) = (SELECT IdFacturaDes FROM inserted)
	DECLARE @IdPropuesta AS nchar(4) = (SELECT IdPropuesta FROM inserted)
	DECLARE @IdProyecto AS nchar(4) = (SELECT IdProyecto FROM inserted)
	DECLARE @IdEquipo AS nchar(4) = (SELECT IdEquipo FROM inserted)
	DECLARE @IdConteoVenta AS nchar(4) = (SELECT IdConteoVenta FROM inserted)

	DECLARE @IdCliente AS nchar(4) = (SELECT [FacturaVenta].IdCliente FROM inserted,[FacturaVenta] WHERE [FacturaVenta].IdFacturaVenta = inserted.IdFacturaVenta AND [FacturaVenta].IdFacturaDes = inserted.IdFacturaDes AND
	[FacturaVenta].IdPropuesta = inserted.IdPropuesta AND [FacturaVenta].IdProyecto = inserted.IdProyecto AND  [FacturaVenta].IdFacturaDev = inserted.IdFacturaDev)


    -- Insert statements for trigger here
	DECLARE @PrecioVenta AS nchar(4) = (SELECT Equipo.PrecioVenta FROM inserted,equipo WHERE inserted.IdEquipo = Equipo.IdEquipo)

	DECLARE @CantidadVendido AS int =(SELECT ConteoVenta.Cantidad FROM inserted,ConteoVenta WHERE ConteoVenta.IdConteoVenta = inserted.IdConteoVenta
	AND ConteoVenta.IdPropuesta = inserted.IdPropuesta AND ConteoVenta.IdProyecto = inserted.IdProyecto AND
	ConteoVenta.IdEquipo = inserted.IdEquipo)

	DECLARE @SubtotalVenta AS nchar(4) = @CantidadVendido* @PrecioVenta

	UPDATE [FacturaVentaSubtotal]
	SET PrecioVenta = @PrecioVenta, SubTotalVenta = @PrecioVenta
	WHERE IdFacturaVenta = @IdFacturaVenta AND IdFacturaDes = @IdFacturaDes AND IdPropuesta = @IdPropuesta AND IdProyecto =@IdProyecto AND IdEquipo = @IdEquipo AND
	IdConteoVenta = @IdConteoVenta

	UPDATE Equipo
	SET CantExistencia = CantExistencia - @CantidadVendido
	WHERE IdEquipo = @IdEquipo

END
GO
ALTER TABLE [dbo].[FacturaVentaSubtotal] ENABLE TRIGGER [TriggerInsertFacturaVentaSubtotal]
GO
/****** Object:  Trigger [dbo].[TriggerInsertPropuestaProyecto]    Script Date: 7/12/2020 11:18:15 a. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		Víctor Gómez
-- Create date: 06-12-2020
-- Description:	
-- =============================================
CREATE TRIGGER [dbo].[TriggerInsertPropuestaProyecto] 
   ON  [dbo].[PropuestaProyecto]
   AFTER INSERT
AS 
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

	DECLARE @IdPropuesta AS nchar(4) = (SELECT inserted.IdPropuesta FROM inserted)
	DECLARE @IdProyecto AS nchar(4)= (SELECT inserted.IdProyecto FROM inserted)

    -- Insert statements for trigger here
	DECLARE @Total AS money = (SELECT SUM(SubTotalAlquiler)
	FROM PropuestaSubTotal
	WHERE PropuestaSubTotal.IdPropuesta = @IdPropuesta AND PropuestaSubTotal.IdProyecto = @IdProyecto
	GROUP BY IdPropuesta,IdProyecto) + 
	(SELECT SUM(SubTotalVenta)
	FROM PropuestaSubTotal
	WHERE PropuestaSubTotal.IdPropuesta = @IdPropuesta AND PropuestaSubTotal.IdProyecto = @IdProyecto
	GROUP BY IdPropuesta,IdProyecto)


	UPDATE PropuestaProyecto
	SET PropuestaProyecto.MontoDeposito = @Total - @Total*PorcentajeDescuento + @Total*Impuesto
	WHERE PropuestaProyecto.IdPropuesta = @IdPropuesta AND PropuestaProyecto.IdProyecto = @IdProyecto 

END
GO
ALTER TABLE [dbo].[PropuestaProyecto] ENABLE TRIGGER [TriggerInsertPropuestaProyecto]
GO
/****** Object:  Trigger [dbo].[TriggerInsertPropuestaSubTotal]    Script Date: 7/12/2020 11:18:15 a. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		Víctor Gómez
-- Create date: 06-12-2020
-- Description:	
-- =============================================
CREATE TRIGGER [dbo].[TriggerInsertPropuestaSubTotal] 
   ON  [dbo].[PropuestaSubTotal] 
   AFTER INSERT
AS 
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;
	IF( (SELECT inserted.Cantidad FROM inserted) > (SELECT Equipo.CantExistencia FROM Equipo,inserted WHERE Equipo.IdEquipo = inserted.IdEquipo) )
	BEGIN
		THROW 70001,'No se puede generar una propuesta con mas equipos de los existen.',1
		ROLLBACK;
	END

	DECLARE @IdPropuesta AS nchar(4) = (SELECT inserted.IdPropuesta FROM inserted)
	DECLARE @IdProyecto AS nchar(4)= (SELECT inserted.IdProyecto FROM inserted)
	DECLARE @IdEquipo AS nchar(4)= (SELECT inserted.IdEquipo FROM inserted)

    -- Insert statements for trigger here

	UPDATE PropuestaSubTotal
	SET PrecioAlquiler = (	SELECT Equipo.PrecioAlquiler FROM Equipo, inserted WHERE Equipo.IdEquipo = inserted.IdEquipo),
	PrecioVenta = (	SELECT Equipo.PrecioVenta FROM Equipo, inserted WHERE Equipo.IdEquipo = inserted.IdEquipo),
	SubTotalAlquiler = (PrecioAlquiler*Cantidad),
	SubTotalVenta = (PrecioVenta*Cantidad)
	
	WHERE PropuestaSubTotal.IdPropuesta = @IdPropuesta AND PropuestaSubTotal.IdProyecto = @IdProyecto AND PropuestaSubTotal.IdEquipo = @IdEquipo

END
GO
ALTER TABLE [dbo].[PropuestaSubTotal] ENABLE TRIGGER [TriggerInsertPropuestaSubTotal]
GO
/****** Object:  Trigger [dbo].[TriggerInsertProyecto]    Script Date: 7/12/2020 11:18:15 a. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		Víctor Gómez
-- Create date: 06-12-2020
-- Description:	
-- =============================================
CREATE TRIGGER [dbo].[TriggerInsertProyecto]
   ON  [dbo].[Proyecto]
   AFTER INSERT
AS 
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

	DECLARE @IdProyecto AS nchar(4)= (SELECT inserted.IdProyecto FROM inserted)

    -- Insert statements for trigger here
	DECLARE @MontoTotalDeposito AS money = (SELECT SUM(MontoDeposito) FROM PropuestaProyecto WHERE PropuestaProyecto.IdProyecto = @IdProyecto
	GROUP BY IdProyecto)

	DECLARE @Deuda AS money = (SELECT SUM(TotalAlquiler) FROM FacturaContinuidad WHERE FacturaContinuidad.IdProyecto = @IdProyecto
	GROUP BY TotalAlquiler)


	UPDATE Proyecto
	SET MontoTotalDeposito = @MontoTotalDeposito, MontoProyectoAud = @Deuda
	WHERE Proyecto.IdProyecto = @IdProyecto 

END
GO
ALTER TABLE [dbo].[Proyecto] ENABLE TRIGGER [TriggerInsertProyecto]
GO
USE [master]
GO
ALTER DATABASE [EmpresaAlquilerEquipo] SET  READ_WRITE 
GO
