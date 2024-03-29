USE [master]
GO
/****** Object:  Database [TiendaDepartamento]    Script Date: 3/11/2020 10:55:56 p. m. ******/
CREATE DATABASE [TiendaDepartamento]
 CONTAINMENT = NONE
 ON  PRIMARY 
( NAME = N'TiendaDepartamento', FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL15.MSSQLSERVER\MSSQL\DATA\TiendaDepartamento.mdf' , SIZE = 8192KB , MAXSIZE = UNLIMITED, FILEGROWTH = 65536KB )
 LOG ON 
( NAME = N'TiendaDepartamento_log', FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL15.MSSQLSERVER\MSSQL\DATA\TiendaDepartamento_log.ldf' , SIZE = 8192KB , MAXSIZE = 2048GB , FILEGROWTH = 65536KB )
 WITH CATALOG_COLLATION = DATABASE_DEFAULT
GO
ALTER DATABASE [TiendaDepartamento] SET COMPATIBILITY_LEVEL = 150
GO
IF (1 = FULLTEXTSERVICEPROPERTY('IsFullTextInstalled'))
begin
EXEC [TiendaDepartamento].[dbo].[sp_fulltext_database] @action = 'enable'
end
GO
ALTER DATABASE [TiendaDepartamento] SET ANSI_NULL_DEFAULT OFF 
GO
ALTER DATABASE [TiendaDepartamento] SET ANSI_NULLS OFF 
GO
ALTER DATABASE [TiendaDepartamento] SET ANSI_PADDING OFF 
GO
ALTER DATABASE [TiendaDepartamento] SET ANSI_WARNINGS OFF 
GO
ALTER DATABASE [TiendaDepartamento] SET ARITHABORT OFF 
GO
ALTER DATABASE [TiendaDepartamento] SET AUTO_CLOSE OFF 
GO
ALTER DATABASE [TiendaDepartamento] SET AUTO_SHRINK OFF 
GO
ALTER DATABASE [TiendaDepartamento] SET AUTO_UPDATE_STATISTICS ON 
GO
ALTER DATABASE [TiendaDepartamento] SET CURSOR_CLOSE_ON_COMMIT OFF 
GO
ALTER DATABASE [TiendaDepartamento] SET CURSOR_DEFAULT  GLOBAL 
GO
ALTER DATABASE [TiendaDepartamento] SET CONCAT_NULL_YIELDS_NULL OFF 
GO
ALTER DATABASE [TiendaDepartamento] SET NUMERIC_ROUNDABORT OFF 
GO
ALTER DATABASE [TiendaDepartamento] SET QUOTED_IDENTIFIER OFF 
GO
ALTER DATABASE [TiendaDepartamento] SET RECURSIVE_TRIGGERS OFF 
GO
ALTER DATABASE [TiendaDepartamento] SET  DISABLE_BROKER 
GO
ALTER DATABASE [TiendaDepartamento] SET AUTO_UPDATE_STATISTICS_ASYNC OFF 
GO
ALTER DATABASE [TiendaDepartamento] SET DATE_CORRELATION_OPTIMIZATION OFF 
GO
ALTER DATABASE [TiendaDepartamento] SET TRUSTWORTHY OFF 
GO
ALTER DATABASE [TiendaDepartamento] SET ALLOW_SNAPSHOT_ISOLATION OFF 
GO
ALTER DATABASE [TiendaDepartamento] SET PARAMETERIZATION SIMPLE 
GO
ALTER DATABASE [TiendaDepartamento] SET READ_COMMITTED_SNAPSHOT OFF 
GO
ALTER DATABASE [TiendaDepartamento] SET HONOR_BROKER_PRIORITY OFF 
GO
ALTER DATABASE [TiendaDepartamento] SET RECOVERY FULL 
GO
ALTER DATABASE [TiendaDepartamento] SET  MULTI_USER 
GO
ALTER DATABASE [TiendaDepartamento] SET PAGE_VERIFY CHECKSUM  
GO
ALTER DATABASE [TiendaDepartamento] SET DB_CHAINING OFF 
GO
ALTER DATABASE [TiendaDepartamento] SET FILESTREAM( NON_TRANSACTED_ACCESS = OFF ) 
GO
ALTER DATABASE [TiendaDepartamento] SET TARGET_RECOVERY_TIME = 60 SECONDS 
GO
ALTER DATABASE [TiendaDepartamento] SET DELAYED_DURABILITY = DISABLED 
GO
EXEC sys.sp_db_vardecimal_storage_format N'TiendaDepartamento', N'ON'
GO
ALTER DATABASE [TiendaDepartamento] SET QUERY_STORE = OFF
GO
USE [TiendaDepartamento]
GO
/****** Object:  Table [dbo].[Articulo]    Script Date: 3/11/2020 10:55:57 p. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Articulo](
	[ID] [nchar](4) NOT NULL,
	[Nombre] [nchar](15) NULL,
	[Clasificacion] [nchar](15) NULL,
	[PorceDeduITBIS] [float] NULL,
	[PuntoDeReorden] [int] NULL,
 CONSTRAINT [PK_Articulo] PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[ArticuloOrden]    Script Date: 3/11/2020 10:55:57 p. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[ArticuloOrden](
	[NumOrden] [nchar](4) NOT NULL,
	[IDArticulo] [nchar](4) NOT NULL,
	[Cantidad] [int] NULL,
	[Precio] [float] NULL,
	[Importe] [float] NULL,
	[Descuento] [float] NULL,
	[ITBIS] [float] NULL,
	[NumProveedor] [nchar](4) NOT NULL,
 CONSTRAINT [PK_ArticuloOrden] PRIMARY KEY CLUSTERED 
(
	[NumOrden] ASC,
	[IDArticulo] ASC,
	[NumProveedor] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[ArticuloProveedor]    Script Date: 3/11/2020 10:55:57 p. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[ArticuloProveedor](
	[IDArticulo] [nchar](4) NOT NULL,
	[Precio] [float] NULL,
	[NumProveedor] [nchar](4) NOT NULL,
 CONSTRAINT [PK_ArticuloProveedor_1] PRIMARY KEY CLUSTERED 
(
	[IDArticulo] ASC,
	[NumProveedor] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Cliente]    Script Date: 3/11/2020 10:55:57 p. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Cliente](
	[NumCliente] [nchar](4) NOT NULL,
	[Pnombre] [nchar](15) NULL,
	[Snombre] [nchar](15) NULL,
	[FechaNacimiento] [date] NULL,
	[Descuento] [float] NULL,
	[BalancePendiente] [float] NULL,
	[PosibilidadCompra] [nchar](1) NULL,
	[Indentificador] [nchar](13) NULL,
 CONSTRAINT [PK_Cliente] PRIMARY KEY CLUSTERED 
(
	[NumCliente] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Contacto]    Script Date: 3/11/2020 10:55:57 p. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Contacto](
	[Descripcion] [nchar](15) NOT NULL,
	[Informacion] [nchar](30) NOT NULL,
	[NumProveedor] [nchar](4) NOT NULL,
 CONSTRAINT [PK_Contacto] PRIMARY KEY CLUSTERED 
(
	[Descripcion] ASC,
	[Informacion] ASC,
	[NumProveedor] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Orden]    Script Date: 3/11/2020 10:55:57 p. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Orden](
	[NumOrden] [nchar](4) NOT NULL,
	[FechaRealizacion] [datetime] NULL,
	[NumCliente] [nchar](4) NULL,
	[CantidadArticulos] [int] NULL,
	[ImporteTotal] [float] NULL,
	[ITBISTotal] [float] NULL,
	[TiempoPago] [int] NULL,
 CONSTRAINT [PK_Orden] PRIMARY KEY CLUSTERED 
(
	[NumOrden] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Proveedor]    Script Date: 3/11/2020 10:55:57 p. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Proveedor](
	[NumProveedor] [nchar](4) NOT NULL,
	[NombreCompleto] [nchar](40) NULL,
 CONSTRAINT [PK_Proveedor] PRIMARY KEY CLUSTERED 
(
	[NumProveedor] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
ALTER TABLE [dbo].[ArticuloOrden]  WITH CHECK ADD  CONSTRAINT [FK_ArticuloOrden_ArticuloProveedor] FOREIGN KEY([IDArticulo], [NumProveedor])
REFERENCES [dbo].[ArticuloProveedor] ([IDArticulo], [NumProveedor])
GO
ALTER TABLE [dbo].[ArticuloOrden] CHECK CONSTRAINT [FK_ArticuloOrden_ArticuloProveedor]
GO
ALTER TABLE [dbo].[ArticuloOrden]  WITH CHECK ADD  CONSTRAINT [FK_ArticuloOrden_Orden1] FOREIGN KEY([NumOrden])
REFERENCES [dbo].[Orden] ([NumOrden])
GO
ALTER TABLE [dbo].[ArticuloOrden] CHECK CONSTRAINT [FK_ArticuloOrden_Orden1]
GO
ALTER TABLE [dbo].[ArticuloProveedor]  WITH CHECK ADD  CONSTRAINT [FK_ArticuloProveedor_Articulo] FOREIGN KEY([IDArticulo])
REFERENCES [dbo].[Articulo] ([ID])
GO
ALTER TABLE [dbo].[ArticuloProveedor] CHECK CONSTRAINT [FK_ArticuloProveedor_Articulo]
GO
ALTER TABLE [dbo].[ArticuloProveedor]  WITH CHECK ADD  CONSTRAINT [FK_ArticuloProveedor_Proveedor] FOREIGN KEY([NumProveedor])
REFERENCES [dbo].[Proveedor] ([NumProveedor])
GO
ALTER TABLE [dbo].[ArticuloProveedor] CHECK CONSTRAINT [FK_ArticuloProveedor_Proveedor]
GO
ALTER TABLE [dbo].[Contacto]  WITH CHECK ADD  CONSTRAINT [FK_Contacto_Proveedor] FOREIGN KEY([NumProveedor])
REFERENCES [dbo].[Proveedor] ([NumProveedor])
GO
ALTER TABLE [dbo].[Contacto] CHECK CONSTRAINT [FK_Contacto_Proveedor]
GO
ALTER TABLE [dbo].[Orden]  WITH CHECK ADD  CONSTRAINT [FK_Orden_Cliente] FOREIGN KEY([NumCliente])
REFERENCES [dbo].[Cliente] ([NumCliente])
GO
ALTER TABLE [dbo].[Orden] CHECK CONSTRAINT [FK_Orden_Cliente]
GO
USE [master]
GO
ALTER DATABASE [TiendaDepartamento] SET  READ_WRITE 
GO
