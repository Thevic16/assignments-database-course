--USE [master]
GO
/****** Object:  Database [BasketBall]    Script Date: 23/09/2020 03:28:51 p.m. ******/
CREATE DATABASE [BasketBall]
 CONTAINMENT = NONE
 ON  PRIMARY 
( NAME = N'BasketBall', FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL15.MSSQLSERVER\MSSQL\DATA\BasketBall.mdf' , SIZE = 5120KB , MAXSIZE = UNLIMITED, FILEGROWTH = 1024KB )
 LOG ON 
( NAME = N'BasketBall_log', FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL15.MSSQLSERVER\MSSQL\DATA\BasketBall_log.ldf' , SIZE = 1024KB , MAXSIZE = 2048GB , FILEGROWTH = 10%)
GO
ALTER DATABASE [BasketBall] SET COMPATIBILITY_LEVEL = 120
GO
IF (1 = FULLTEXTSERVICEPROPERTY('IsFullTextInstalled'))
begin
EXEC [BasketBall].[dbo].[sp_fulltext_database] @action = 'enable'
end
GO
ALTER DATABASE [BasketBall] SET ANSI_NULL_DEFAULT OFF 
GO
ALTER DATABASE [BasketBall] SET ANSI_NULLS OFF 
GO
ALTER DATABASE [BasketBall] SET ANSI_PADDING OFF 
GO
ALTER DATABASE [BasketBall] SET ANSI_WARNINGS OFF 
GO
ALTER DATABASE [BasketBall] SET ARITHABORT OFF 
GO
ALTER DATABASE [BasketBall] SET AUTO_CLOSE OFF 
GO
ALTER DATABASE [BasketBall] SET AUTO_SHRINK OFF 
GO
ALTER DATABASE [BasketBall] SET AUTO_UPDATE_STATISTICS ON 
GO
ALTER DATABASE [BasketBall] SET CURSOR_CLOSE_ON_COMMIT OFF 
GO
ALTER DATABASE [BasketBall] SET CURSOR_DEFAULT  GLOBAL 
GO
ALTER DATABASE [BasketBall] SET CONCAT_NULL_YIELDS_NULL OFF 
GO
ALTER DATABASE [BasketBall] SET NUMERIC_ROUNDABORT OFF 
GO
ALTER DATABASE [BasketBall] SET QUOTED_IDENTIFIER OFF 
GO
ALTER DATABASE [BasketBall] SET RECURSIVE_TRIGGERS OFF 
GO
ALTER DATABASE [BasketBall] SET  DISABLE_BROKER 
GO
ALTER DATABASE [BasketBall] SET AUTO_UPDATE_STATISTICS_ASYNC OFF 
GO
ALTER DATABASE [BasketBall] SET DATE_CORRELATION_OPTIMIZATION OFF 
GO
ALTER DATABASE [BasketBall] SET TRUSTWORTHY OFF 
GO
ALTER DATABASE [BasketBall] SET ALLOW_SNAPSHOT_ISOLATION OFF 
GO
ALTER DATABASE [BasketBall] SET PARAMETERIZATION SIMPLE 
GO
ALTER DATABASE [BasketBall] SET READ_COMMITTED_SNAPSHOT OFF 
GO
ALTER DATABASE [BasketBall] SET HONOR_BROKER_PRIORITY OFF 
GO
ALTER DATABASE [BasketBall] SET RECOVERY FULL 
GO
ALTER DATABASE [BasketBall] SET  MULTI_USER 
GO
ALTER DATABASE [BasketBall] SET PAGE_VERIFY CHECKSUM  
GO
ALTER DATABASE [BasketBall] SET DB_CHAINING OFF 
GO
ALTER DATABASE [BasketBall] SET FILESTREAM( NON_TRANSACTED_ACCESS = OFF ) 
GO
ALTER DATABASE [BasketBall] SET TARGET_RECOVERY_TIME = 0 SECONDS 
GO
ALTER DATABASE [BasketBall] SET DELAYED_DURABILITY = DISABLED 
GO
USE [BasketBall]
GO
/****** Object:  UserDefinedFunction [dbo].[FormatName]    Script Date: 23/09/2020 03:28:51 p.m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date, ,>
-- Description:	<Description, ,>
-- =============================================
CREATE FUNCTION [dbo].[FormatName]
(
	-- Add the parameters for the function here
	@Nomb1 as nchar(30), @nomb2 as nchar(30), @Apel1 as nchar(30), @Apel2 as nchar(30)
)
RETURNS char(67)
AS
BEGIN

	-- Return the result of the function
	RETURN RTRIM(@Nomb1)+' '+
	CASE WHEN @nomb2 IS NULL THEN '' ELSE LEFT(@nomb2,1)+'. ' END
	+RTRIM(@Apel1)+' '+
	CASE WHEN @Apel2 IS NULL THEN '' ELSE LEFT(@Apel2,1)+'.' END
END

GO
/****** Object:  UserDefinedFunction [dbo].[TotalPuntosJuego]    Script Date: 23/09/2020 03:28:51 p.m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		Aliz
-- Create date: <Create Date, ,>
-- Description:	<Description, ,>
-- =============================================
CREATE FUNCTION [dbo].[TotalPuntosJuego] 
(
	-- Add the parameters for the function here
	@codjugador nchar(5), @codjuego nchar(5)
)
RETURNS INT
AS
BEGIN
	-- Declare the return variable here
	DECLARE @PUNTOS INT

	-- Add the T-SQL statements to compute the return value here
	SELECT @PUNTOS = (SELECT SUM(E.Valor * EJ.Cantidad) as Puntos
	  FROM EstadisticaJuego EJ, Jugador J, Estadistica E
	WHERE E.CodEstadistica = EJ.CodEstadistica
	  AND J.CodJugador = EJ.CodJugador
	  AND E.CodEstadistica IN ('01','02')
	  AND EJ.CodJuego = @codjuego
	  AND J.CodJugador = @codjugador)

	-- Return the result of the function
	RETURN @PUNTOS

END

GO
/****** Object:  Table [dbo].[Ciudad]    Script Date: 23/09/2020 03:28:51 p.m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Ciudad](
	[CodCiudad] [nchar](5) NOT NULL,
	[Nombre] [nchar](40) NULL,
 CONSTRAINT [PK_Ciudad] PRIMARY KEY CLUSTERED 
(
	[CodCiudad] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[Equipo]    Script Date: 23/09/2020 03:28:51 p.m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Equipo](
	[CodEquipo] [nchar](5) NOT NULL,
	[Nombre] [nchar](40) NULL,
	[CodCiudad] [nchar](5) NULL,
 CONSTRAINT [PK_Equipo] PRIMARY KEY CLUSTERED 
(
	[CodEquipo] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[Estadistica]    Script Date: 23/09/2020 03:28:51 p.m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Estadistica](
	[CodEstadistica] [nchar](5) NOT NULL,
	[Descripcion] [nchar](45) NULL,
	[Valor] [smallint] NOT NULL,
 CONSTRAINT [PK_Estadistica] PRIMARY KEY CLUSTERED 
(
	[CodEstadistica] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[EstadisticaJuego]    Script Date: 23/09/2020 03:28:51 p.m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[EstadisticaJuego](
	[CodJuego] [nchar](5) NOT NULL,
	[CodEstadistica] [nchar](5) NOT NULL,
	[CodJugador] [nchar](5) NOT NULL,
	[Cantidad] [smallint] NULL,
 CONSTRAINT [PK_EstadisticaJuego_1] PRIMARY KEY CLUSTERED 
(
	[CodJuego] ASC,
	[CodEstadistica] ASC,
	[CodJugador] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[Juego]    Script Date: 23/09/2020 03:28:51 p.m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Juego](
	[codjuego] [nchar](5) NOT NULL,
	[Descripcion] [nchar](30) NULL,
	[Equipo1] [nchar](5) NULL,
	[Equipo2] [nchar](5) NULL,
	[Fecha] [datetime] NULL,
 CONSTRAINT [PK_Juego] PRIMARY KEY CLUSTERED 
(
	[codjuego] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[Jugador]    Script Date: 23/09/2020 03:28:51 p.m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Jugador](
	[CodJugador] [nchar](5) NOT NULL,
	[Nombre1] [nchar](30) NULL,
	[Nombre2] [nchar](30) NULL,
	[Apellido1] [nchar](30) NULL,
	[Apellido2] [nchar](30) NULL,
	[CiudadNacim] [nchar](5) NULL,
	[FechaNacim] [date] NULL,
	[Numero] [nchar](3) NULL,
	[CodEquipo] [nchar](5) NULL,
 CONSTRAINT [PK_Jugador] PRIMARY KEY CLUSTERED 
(
	[CodJugador] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  UserDefinedFunction [dbo].[EquiposCiudad]    Script Date: 23/09/2020 03:28:51 p.m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE FUNCTION [dbo].[EquiposCiudad]
(	
	-- Add the parameters for the function here
	@CodCiudad NCHAR(5)
)
RETURNS TABLE 
AS
RETURN 
(
	-- Add the SELECT statement with parameter references here
	-- a. Muestre los equipos por ciudades ordenados por nombre de ciudad ascendentemente, nombre de equipo descendentemente.
	SELECT C.CodCiudad, C.Nombre as NombreCiudad, E.Nombre as NombreEquipo
	FROM Equipo E, Ciudad C
	WHERE C.CodCiudad = E.CodCiudad
	  AND C.CodCiudad like rtrim(@CodCiudad)
)

GO
/****** Object:  View [dbo].[View_EquipoCiudad]    Script Date: 23/09/2020 03:28:51 p.m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE VIEW [dbo].[View_EquipoCiudad]
AS
SELECT        dbo.Equipo.Nombre, dbo.Ciudad.Nombre AS NombreCiudad
FROM            dbo.Ciudad INNER JOIN
                         dbo.Equipo ON dbo.Ciudad.CodCiudad = dbo.Equipo.CodCiudad

GO
INSERT [dbo].[Ciudad] ([CodCiudad], [Nombre]) VALUES (N'00001', N'Santiago                                ')
GO
INSERT [dbo].[Ciudad] ([CodCiudad], [Nombre]) VALUES (N'AZ   ', N'Azua                                    ')
GO
INSERT [dbo].[Ciudad] ([CodCiudad], [Nombre]) VALUES (N'LA   ', N'La Altagracia                           ')
GO
INSERT [dbo].[Ciudad] ([CodCiudad], [Nombre]) VALUES (N'NG   ', N'Nagua                                   ')
GO
INSERT [dbo].[Ciudad] ([CodCiudad], [Nombre]) VALUES (N'PED  ', N'Pedernales                              ')
GO
INSERT [dbo].[Ciudad] ([CodCiudad], [Nombre]) VALUES (N'POP  ', N'Puerto Plata                            ')
GO
INSERT [dbo].[Ciudad] ([CodCiudad], [Nombre]) VALUES (N'SC   ', N'San Cristobal                           ')
GO
INSERT [dbo].[Ciudad] ([CodCiudad], [Nombre]) VALUES (N'SFM  ', N'San Francisco                           ')
GO
INSERT [dbo].[Ciudad] ([CodCiudad], [Nombre]) VALUES (N'SJM  ', N'San Juan de la Maguana                  ')
GO
INSERT [dbo].[Ciudad] ([CodCiudad], [Nombre]) VALUES (N'SPM  ', N'San Pedro de Macoris                    ')
GO
INSERT [dbo].[Ciudad] ([CodCiudad], [Nombre]) VALUES (N'ST   ', N'Santiago                                ')
GO
INSERT [dbo].[Ciudad] ([CodCiudad], [Nombre]) VALUES (N'STD  ', N'Santo Domingo                           ')
GO
INSERT [dbo].[Equipo] ([CodEquipo], [Nombre], [CodCiudad]) VALUES (N'00001', N'Cavaliers                               ', N'AZ   ')
GO
INSERT [dbo].[Equipo] ([CodEquipo], [Nombre], [CodCiudad]) VALUES (N'00002', N'Heat                                    ', N'PED  ')
GO
INSERT [dbo].[Equipo] ([CodEquipo], [Nombre], [CodCiudad]) VALUES (N'00003', N'Lakers                                  ', N'POP  ')
GO
INSERT [dbo].[Equipo] ([CodEquipo], [Nombre], [CodCiudad]) VALUES (N'00004', N'Kings                                   ', N'ST   ')
GO
INSERT [dbo].[Equipo] ([CodEquipo], [Nombre], [CodCiudad]) VALUES (N'00005', N'Raptors                                 ', N'STD  ')
GO
INSERT [dbo].[Equipo] ([CodEquipo], [Nombre], [CodCiudad]) VALUES (N'00006', N'Warriors                                ', N'NG   ')
GO
INSERT [dbo].[Estadistica] ([CodEstadistica], [Descripcion], [Valor]) VALUES (N'01   ', N'Puntos de Dos                                ', 2)
GO
INSERT [dbo].[Estadistica] ([CodEstadistica], [Descripcion], [Valor]) VALUES (N'02   ', N'Puntos de Tres                               ', 3)
GO
INSERT [dbo].[Estadistica] ([CodEstadistica], [Descripcion], [Valor]) VALUES (N'03   ', N'Asistencias                                  ', 1)
GO
INSERT [dbo].[Estadistica] ([CodEstadistica], [Descripcion], [Valor]) VALUES (N'04   ', N'Rebotes                                      ', 1)
GO
INSERT [dbo].[Estadistica] ([CodEstadistica], [Descripcion], [Valor]) VALUES (N'05   ', N'Bolas Robadas                                ', 1)
GO
INSERT [dbo].[Estadistica] ([CodEstadistica], [Descripcion], [Valor]) VALUES (N'06   ', N'Faltas Personales                            ', 1)
GO
INSERT [dbo].[Estadistica] ([CodEstadistica], [Descripcion], [Valor]) VALUES (N'07   ', N'Faltas Tecnicas                              ', 1)
GO
INSERT [dbo].[Estadistica] ([CodEstadistica], [Descripcion], [Valor]) VALUES (N'08   ', N'Bolas Perdidas                               ', 1)
GO
INSERT [dbo].[Estadistica] ([CodEstadistica], [Descripcion], [Valor]) VALUES (N'09   ', N'Tiros Libres                                 ', 1)
GO
INSERT [dbo].[EstadisticaJuego] ([CodJuego], [CodEstadistica], [CodJugador], [Cantidad]) VALUES (N'01   ', N'01   ', N'00001', 5)
GO
INSERT [dbo].[EstadisticaJuego] ([CodJuego], [CodEstadistica], [CodJugador], [Cantidad]) VALUES (N'01   ', N'02   ', N'00008', 7)
GO
INSERT [dbo].[EstadisticaJuego] ([CodJuego], [CodEstadistica], [CodJugador], [Cantidad]) VALUES (N'02   ', N'02   ', N'00023', 6)
GO
INSERT [dbo].[EstadisticaJuego] ([CodJuego], [CodEstadistica], [CodJugador], [Cantidad]) VALUES (N'02   ', N'03   ', N'00028', 2)
GO
INSERT [dbo].[EstadisticaJuego] ([CodJuego], [CodEstadistica], [CodJugador], [Cantidad]) VALUES (N'03   ', N'03   ', N'00011', 2)
GO
INSERT [dbo].[EstadisticaJuego] ([CodJuego], [CodEstadistica], [CodJugador], [Cantidad]) VALUES (N'03   ', N'04   ', N'00017', 1)
GO
INSERT [dbo].[EstadisticaJuego] ([CodJuego], [CodEstadistica], [CodJugador], [Cantidad]) VALUES (N'04   ', N'01   ', N'00014', 9)
GO
INSERT [dbo].[EstadisticaJuego] ([CodJuego], [CodEstadistica], [CodJugador], [Cantidad]) VALUES (N'04   ', N'05   ', N'00024', 2)
GO
INSERT [dbo].[EstadisticaJuego] ([CodJuego], [CodEstadistica], [CodJugador], [Cantidad]) VALUES (N'05   ', N'01   ', N'00009', 19)
GO
INSERT [dbo].[EstadisticaJuego] ([CodJuego], [CodEstadistica], [CodJugador], [Cantidad]) VALUES (N'05   ', N'01   ', N'00012', 20)
GO
INSERT [dbo].[EstadisticaJuego] ([CodJuego], [CodEstadistica], [CodJugador], [Cantidad]) VALUES (N'05   ', N'02   ', N'00009', 15)
GO
INSERT [dbo].[EstadisticaJuego] ([CodJuego], [CodEstadistica], [CodJugador], [Cantidad]) VALUES (N'05   ', N'02   ', N'00012', 13)
GO
INSERT [dbo].[EstadisticaJuego] ([CodJuego], [CodEstadistica], [CodJugador], [Cantidad]) VALUES (N'05   ', N'09   ', N'00009', 10)
GO
INSERT [dbo].[EstadisticaJuego] ([CodJuego], [CodEstadistica], [CodJugador], [Cantidad]) VALUES (N'05   ', N'09   ', N'00012', 11)
GO
INSERT [dbo].[EstadisticaJuego] ([CodJuego], [CodEstadistica], [CodJugador], [Cantidad]) VALUES (N'06   ', N'01   ', N'00002', 10)
GO
INSERT [dbo].[EstadisticaJuego] ([CodJuego], [CodEstadistica], [CodJugador], [Cantidad]) VALUES (N'06   ', N'02   ', N'00002', 8)
GO
INSERT [dbo].[EstadisticaJuego] ([CodJuego], [CodEstadistica], [CodJugador], [Cantidad]) VALUES (N'06   ', N'03   ', N'00002', 6)
GO
INSERT [dbo].[EstadisticaJuego] ([CodJuego], [CodEstadistica], [CodJugador], [Cantidad]) VALUES (N'06   ', N'03   ', N'00016', 5)
GO
INSERT [dbo].[EstadisticaJuego] ([CodJuego], [CodEstadistica], [CodJugador], [Cantidad]) VALUES (N'06   ', N'09   ', N'00002', 6)
GO
INSERT [dbo].[EstadisticaJuego] ([CodJuego], [CodEstadistica], [CodJugador], [Cantidad]) VALUES (N'07   ', N'03   ', N'00006', 2)
GO
INSERT [dbo].[EstadisticaJuego] ([CodJuego], [CodEstadistica], [CodJugador], [Cantidad]) VALUES (N'07   ', N'03   ', N'00030', 2)
GO
INSERT [dbo].[EstadisticaJuego] ([CodJuego], [CodEstadistica], [CodJugador], [Cantidad]) VALUES (N'08   ', N'01   ', N'00026', 6)
GO
INSERT [dbo].[EstadisticaJuego] ([CodJuego], [CodEstadistica], [CodJugador], [Cantidad]) VALUES (N'08   ', N'02   ', N'00020', 4)
GO
INSERT [dbo].[EstadisticaJuego] ([CodJuego], [CodEstadistica], [CodJugador], [Cantidad]) VALUES (N'09   ', N'03   ', N'00002', 15)
GO
INSERT [dbo].[EstadisticaJuego] ([CodJuego], [CodEstadistica], [CodJugador], [Cantidad]) VALUES (N'09   ', N'03   ', N'00015', 8)
GO
INSERT [dbo].[EstadisticaJuego] ([CodJuego], [CodEstadistica], [CodJugador], [Cantidad]) VALUES (N'11   ', N'01   ', N'00010', 10)
GO
INSERT [dbo].[EstadisticaJuego] ([CodJuego], [CodEstadistica], [CodJugador], [Cantidad]) VALUES (N'11   ', N'02   ', N'00007', 5)
GO
INSERT [dbo].[EstadisticaJuego] ([CodJuego], [CodEstadistica], [CodJugador], [Cantidad]) VALUES (N'11   ', N'02   ', N'00010', 10)
GO
INSERT [dbo].[EstadisticaJuego] ([CodJuego], [CodEstadistica], [CodJugador], [Cantidad]) VALUES (N'11   ', N'03   ', N'00010', 10)
GO
INSERT [dbo].[EstadisticaJuego] ([CodJuego], [CodEstadistica], [CodJugador], [Cantidad]) VALUES (N'11   ', N'04   ', N'00010', 10)
GO
INSERT [dbo].[EstadisticaJuego] ([CodJuego], [CodEstadistica], [CodJugador], [Cantidad]) VALUES (N'11   ', N'06   ', N'00021', 2)
GO
INSERT [dbo].[EstadisticaJuego] ([CodJuego], [CodEstadistica], [CodJugador], [Cantidad]) VALUES (N'11   ', N'09   ', N'00010', 10)
GO
INSERT [dbo].[EstadisticaJuego] ([CodJuego], [CodEstadistica], [CodJugador], [Cantidad]) VALUES (N'12   ', N'01   ', N'00010', 10)
GO
INSERT [dbo].[EstadisticaJuego] ([CodJuego], [CodEstadistica], [CodJugador], [Cantidad]) VALUES (N'12   ', N'01   ', N'00027', 12)
GO
INSERT [dbo].[EstadisticaJuego] ([CodJuego], [CodEstadistica], [CodJugador], [Cantidad]) VALUES (N'12   ', N'02   ', N'00010', 10)
GO
INSERT [dbo].[EstadisticaJuego] ([CodJuego], [CodEstadistica], [CodJugador], [Cantidad]) VALUES (N'12   ', N'03   ', N'00010', 10)
GO
INSERT [dbo].[EstadisticaJuego] ([CodJuego], [CodEstadistica], [CodJugador], [Cantidad]) VALUES (N'12   ', N'04   ', N'00010', 10)
GO
INSERT [dbo].[EstadisticaJuego] ([CodJuego], [CodEstadistica], [CodJugador], [Cantidad]) VALUES (N'12   ', N'07   ', N'00011', 1)
GO
INSERT [dbo].[EstadisticaJuego] ([CodJuego], [CodEstadistica], [CodJugador], [Cantidad]) VALUES (N'12   ', N'09   ', N'00010', 10)
GO
INSERT [dbo].[EstadisticaJuego] ([CodJuego], [CodEstadistica], [CodJugador], [Cantidad]) VALUES (N'13   ', N'08   ', N'00001', 1)
GO
INSERT [dbo].[EstadisticaJuego] ([CodJuego], [CodEstadistica], [CodJugador], [Cantidad]) VALUES (N'13   ', N'09   ', N'00029', 1)
GO
INSERT [dbo].[EstadisticaJuego] ([CodJuego], [CodEstadistica], [CodJugador], [Cantidad]) VALUES (N'14   ', N'01   ', N'00018', 13)
GO
INSERT [dbo].[EstadisticaJuego] ([CodJuego], [CodEstadistica], [CodJugador], [Cantidad]) VALUES (N'14   ', N'09   ', N'00022', 3)
GO
INSERT [dbo].[EstadisticaJuego] ([CodJuego], [CodEstadistica], [CodJugador], [Cantidad]) VALUES (N'15   ', N'01   ', N'00020', 10)
GO
INSERT [dbo].[EstadisticaJuego] ([CodJuego], [CodEstadistica], [CodJugador], [Cantidad]) VALUES (N'15   ', N'02   ', N'00006', 9)
GO
INSERT [dbo].[Juego] ([codjuego], [Descripcion], [Equipo1], [Equipo2], [Fecha]) VALUES (N'01   ', N'Cavaliers vs Heat. Arena A    ', N'00001', N'00002', CAST(N'2017-01-09 00:00:00.000' AS DateTime))
GO
INSERT [dbo].[Juego] ([codjuego], [Descripcion], [Equipo1], [Equipo2], [Fecha]) VALUES (N'02   ', N'Raptors vs Warriors. Arena B  ', N'00005', N'00006', CAST(N'2017-01-11 00:00:00.000' AS DateTime))
GO
INSERT [dbo].[Juego] ([codjuego], [Descripcion], [Equipo1], [Equipo2], [Fecha]) VALUES (N'03   ', N'Lakers vs Kings. Arena C      ', N'00003', N'00004', CAST(N'2017-01-12 00:00:00.000' AS DateTime))
GO
INSERT [dbo].[Juego] ([codjuego], [Descripcion], [Equipo1], [Equipo2], [Fecha]) VALUES (N'04   ', N'Lakers vs Raptors. Arena A    ', N'00003', N'00005', CAST(N'2017-01-15 00:00:00.000' AS DateTime))
GO
INSERT [dbo].[Juego] ([codjuego], [Descripcion], [Equipo1], [Equipo2], [Fecha]) VALUES (N'05   ', N'Heat vs Lakers. Arena B       ', N'00002', N'00003', CAST(N'2017-01-17 00:00:00.000' AS DateTime))
GO
INSERT [dbo].[Juego] ([codjuego], [Descripcion], [Equipo1], [Equipo2], [Fecha]) VALUES (N'06   ', N'Cavaliers vs Kings. Arena C   ', N'00001', N'00004', CAST(N'2017-01-21 00:00:00.000' AS DateTime))
GO
INSERT [dbo].[Juego] ([codjuego], [Descripcion], [Equipo1], [Equipo2], [Fecha]) VALUES (N'07   ', N'Heat vs Warriors. Arena A     ', N'00002', N'00006', CAST(N'2017-01-25 00:00:00.000' AS DateTime))
GO
INSERT [dbo].[Juego] ([codjuego], [Descripcion], [Equipo1], [Equipo2], [Fecha]) VALUES (N'08   ', N'Kings vs Warriors. Arena B    ', N'00004', N'00006', CAST(N'2017-02-01 00:00:00.000' AS DateTime))
GO
INSERT [dbo].[Juego] ([codjuego], [Descripcion], [Equipo1], [Equipo2], [Fecha]) VALUES (N'09   ', N'Cavaliers vs Lakers. Arena C  ', N'00001', N'00003', CAST(N'2017-02-03 00:00:00.000' AS DateTime))
GO
INSERT [dbo].[Juego] ([codjuego], [Descripcion], [Equipo1], [Equipo2], [Fecha]) VALUES (N'10   ', N'Heat vs Raptors. Arena A      ', N'00002', N'00005', CAST(N'2017-02-05 00:00:00.000' AS DateTime))
GO
INSERT [dbo].[Juego] ([codjuego], [Descripcion], [Equipo1], [Equipo2], [Fecha]) VALUES (N'11   ', N'Cavaliers vs Raptors. Arena B ', N'00001', N'00005', CAST(N'2017-02-07 00:00:00.000' AS DateTime))
GO
INSERT [dbo].[Juego] ([codjuego], [Descripcion], [Equipo1], [Equipo2], [Fecha]) VALUES (N'12   ', N'Lakers vs Warriors. Arena C   ', N'00003', N'00006', CAST(N'2017-02-11 00:00:00.000' AS DateTime))
GO
INSERT [dbo].[Juego] ([codjuego], [Descripcion], [Equipo1], [Equipo2], [Fecha]) VALUES (N'13   ', N'Cavaliers vs Warriors. Arena A', N'00001', N'00006', CAST(N'2017-02-15 00:00:00.000' AS DateTime))
GO
INSERT [dbo].[Juego] ([codjuego], [Descripcion], [Equipo1], [Equipo2], [Fecha]) VALUES (N'14   ', N'Kings vs Raptors. Arena B     ', N'00004', N'00005', CAST(N'2017-02-18 00:00:00.000' AS DateTime))
GO
INSERT [dbo].[Juego] ([codjuego], [Descripcion], [Equipo1], [Equipo2], [Fecha]) VALUES (N'15   ', N'Heat vs Kings. Arena C        ', N'00002', N'00004', CAST(N'2017-02-22 00:00:00.000' AS DateTime))
GO
INSERT [dbo].[Jugador] ([CodJugador], [Nombre1], [Nombre2], [Apellido1], [Apellido2], [CiudadNacim], [FechaNacim], [Numero], [CodEquipo]) VALUES (N'00001', N'Juan                          ', N'Francisco                     ', N'Perez                         ', N'Diaz                          ', N'AZ   ', CAST(N'1975-10-12' AS Date), N'012', N'00001')
GO
INSERT [dbo].[Jugador] ([CodJugador], [Nombre1], [Nombre2], [Apellido1], [Apellido2], [CiudadNacim], [FechaNacim], [Numero], [CodEquipo]) VALUES (N'00002', N'Pedro                         ', N'Manuel                        ', N'Estevez                       ', N'Disla                         ', N'POP  ', CAST(N'1980-09-05' AS Date), N'005', N'00001')
GO
INSERT [dbo].[Jugador] ([CodJugador], [Nombre1], [Nombre2], [Apellido1], [Apellido2], [CiudadNacim], [FechaNacim], [Numero], [CodEquipo]) VALUES (N'00003', N'Jose                          ', N'Fernando                      ', N'Rodriguez                     ', N'Tejeda                        ', N'STD  ', CAST(N'1978-05-16' AS Date), N'016', N'00001')
GO
INSERT [dbo].[Jugador] ([CodJugador], [Nombre1], [Nombre2], [Apellido1], [Apellido2], [CiudadNacim], [FechaNacim], [Numero], [CodEquipo]) VALUES (N'00004', N'Carlos                        ', N'Manuel                        ', N'Jimenez                       ', N'Bencosme                      ', N'ST   ', CAST(N'1983-01-13' AS Date), N'013', N'00001')
GO
INSERT [dbo].[Jugador] ([CodJugador], [Nombre1], [Nombre2], [Apellido1], [Apellido2], [CiudadNacim], [FechaNacim], [Numero], [CodEquipo]) VALUES (N'00005', N'John                          ', N'Michael                       ', N'Hernandez                     ', N'Contreras                     ', N'NG   ', CAST(N'1976-12-14' AS Date), N'014', N'00001')
GO
INSERT [dbo].[Jugador] ([CodJugador], [Nombre1], [Nombre2], [Apellido1], [Apellido2], [CiudadNacim], [FechaNacim], [Numero], [CodEquipo]) VALUES (N'00006', N'Edward                        ', N'Miguel                        ', N'Marte                         ', N'Ventura                       ', N'STD  ', CAST(N'1984-03-10' AS Date), N'010', N'00002')
GO
INSERT [dbo].[Jugador] ([CodJugador], [Nombre1], [Nombre2], [Apellido1], [Apellido2], [CiudadNacim], [FechaNacim], [Numero], [CodEquipo]) VALUES (N'00007', N'Juan                          ', N'Carlos                        ', N'Sanchez                       ', N'Perez                         ', N'STD  ', CAST(N'1979-04-19' AS Date), N'019', N'00002')
GO
INSERT [dbo].[Jugador] ([CodJugador], [Nombre1], [Nombre2], [Apellido1], [Apellido2], [CiudadNacim], [FechaNacim], [Numero], [CodEquipo]) VALUES (N'00008', N'Lebron                        ', N'Edwin                         ', N'James                         ', N'Jerez                         ', N'ST   ', CAST(N'1977-07-07' AS Date), N'007', N'00002')
GO
INSERT [dbo].[Jugador] ([CodJugador], [Nombre1], [Nombre2], [Apellido1], [Apellido2], [CiudadNacim], [FechaNacim], [Numero], [CodEquipo]) VALUES (N'00009', N'Gabriel                       ', N'Jose                          ', N'Almonte                       ', N'Mejia                         ', N'NG   ', CAST(N'1981-11-09' AS Date), N'009', N'00002')
GO
INSERT [dbo].[Jugador] ([CodJugador], [Nombre1], [Nombre2], [Apellido1], [Apellido2], [CiudadNacim], [FechaNacim], [Numero], [CodEquipo]) VALUES (N'00010', N'Ricardo                       ', N'Emil                          ', N'Bermudez                      ', N'Sosa                          ', N'AZ   ', CAST(N'1980-10-01' AS Date), N'001', N'00002')
GO
INSERT [dbo].[Jugador] ([CodJugador], [Nombre1], [Nombre2], [Apellido1], [Apellido2], [CiudadNacim], [FechaNacim], [Numero], [CodEquipo]) VALUES (N'00011', N'Mario                         ', N'Emilio                        ', N'Vargas                        ', N'Gonzalez                      ', N'SPM  ', CAST(N'1980-08-03' AS Date), N'003', N'00003')
GO
INSERT [dbo].[Jugador] ([CodJugador], [Nombre1], [Nombre2], [Apellido1], [Apellido2], [CiudadNacim], [FechaNacim], [Numero], [CodEquipo]) VALUES (N'00012', N'Richard                       ', N'Jesus                         ', N'Ortega                        ', N'Perez                         ', N'SFM  ', CAST(N'1976-04-26' AS Date), N'026', N'00003')
GO
INSERT [dbo].[Jugador] ([CodJugador], [Nombre1], [Nombre2], [Apellido1], [Apellido2], [CiudadNacim], [FechaNacim], [Numero], [CodEquipo]) VALUES (N'00013', N'Roberto                       ', N'LLoid                         ', N'Alcantara                     ', N'Fernandez                     ', N'SC   ', CAST(N'1979-02-17' AS Date), N'017', N'00003')
GO
INSERT [dbo].[Jugador] ([CodJugador], [Nombre1], [Nombre2], [Apellido1], [Apellido2], [CiudadNacim], [FechaNacim], [Numero], [CodEquipo]) VALUES (N'00014', N'Luis                          ', N'Isaac                         ', N'Cruz                          ', N'Santana                       ', N'PED  ', CAST(N'1985-10-30' AS Date), N'009', N'00003')
GO
INSERT [dbo].[Jugador] ([CodJugador], [Nombre1], [Nombre2], [Apellido1], [Apellido2], [CiudadNacim], [FechaNacim], [Numero], [CodEquipo]) VALUES (N'00015', N'Marcos                        ', N'Alexander                     ', N'Cabral                        ', N'Rodriguez                     ', N'POP  ', CAST(N'1983-06-24' AS Date), N'024', N'00003')
GO
INSERT [dbo].[Jugador] ([CodJugador], [Nombre1], [Nombre2], [Apellido1], [Apellido2], [CiudadNacim], [FechaNacim], [Numero], [CodEquipo]) VALUES (N'00016', N'Raul                          ', N'Raymundo                      ', N'Montaner                      ', N'Abreu                         ', N'POP  ', CAST(N'1977-02-06' AS Date), N'006', N'00004')
GO
INSERT [dbo].[Jugador] ([CodJugador], [Nombre1], [Nombre2], [Apellido1], [Apellido2], [CiudadNacim], [FechaNacim], [Numero], [CodEquipo]) VALUES (N'00017', N'Jose                          ', N'Andres                        ', N'Saint                         ', N'Cespedes                      ', N'ST   ', CAST(N'1984-09-25' AS Date), N'025', N'00004')
GO
INSERT [dbo].[Jugador] ([CodJugador], [Nombre1], [Nombre2], [Apellido1], [Apellido2], [CiudadNacim], [FechaNacim], [Numero], [CodEquipo]) VALUES (N'00018', N'Angel                         ', N'Josh                          ', N'Llaverias                     ', N'Hernandez                     ', N'SJM  ', CAST(N'1980-04-21' AS Date), N'021', N'00004')
GO
INSERT [dbo].[Jugador] ([CodJugador], [Nombre1], [Nombre2], [Apellido1], [Apellido2], [CiudadNacim], [FechaNacim], [Numero], [CodEquipo]) VALUES (N'00019', N'Albert                        ', N'Derek                         ', N'Blanco                        ', N'Diaz                          ', N'PED  ', CAST(N'1981-12-05' AS Date), N'005', N'00004')
GO
INSERT [dbo].[Jugador] ([CodJugador], [Nombre1], [Nombre2], [Apellido1], [Apellido2], [CiudadNacim], [FechaNacim], [Numero], [CodEquipo]) VALUES (N'00020', N'Pedro                         ', N'Alvaro                        ', N'Peralta                       ', N'Montana                       ', N'AZ   ', CAST(N'1978-06-12' AS Date), N'012', N'00004')
GO
INSERT [dbo].[Jugador] ([CodJugador], [Nombre1], [Nombre2], [Apellido1], [Apellido2], [CiudadNacim], [FechaNacim], [Numero], [CodEquipo]) VALUES (N'00021', N'Luis                          ', N'Jose                          ', N'Henriquez                     ', N'Baez                          ', N'STD  ', CAST(N'1983-09-28' AS Date), N'028', N'00005')
GO
INSERT [dbo].[Jugador] ([CodJugador], [Nombre1], [Nombre2], [Apellido1], [Apellido2], [CiudadNacim], [FechaNacim], [Numero], [CodEquipo]) VALUES (N'00022', N'Juan                          ', N'Gabriel                       ', N'Ramirez                       ', N'Medrano                       ', N'ST   ', CAST(N'1986-02-08' AS Date), N'008', N'00005')
GO
INSERT [dbo].[Jugador] ([CodJugador], [Nombre1], [Nombre2], [Apellido1], [Apellido2], [CiudadNacim], [FechaNacim], [Numero], [CodEquipo]) VALUES (N'00023', N'Alex                          ', N'Daniel                        ', N'Santiago                      ', N'Martinez                      ', N'SPM  ', CAST(N'1979-10-11' AS Date), N'011', N'00005')
GO
INSERT [dbo].[Jugador] ([CodJugador], [Nombre1], [Nombre2], [Apellido1], [Apellido2], [CiudadNacim], [FechaNacim], [Numero], [CodEquipo]) VALUES (N'00024', N'Steven                        ', N'Lorenzo                       ', N'Savater                       ', N'Castro                        ', N'NG   ', CAST(N'1988-01-04' AS Date), N'004', N'00005')
GO
INSERT [dbo].[Jugador] ([CodJugador], [Nombre1], [Nombre2], [Apellido1], [Apellido2], [CiudadNacim], [FechaNacim], [Numero], [CodEquipo]) VALUES (N'00025', N'Josue                         ', N'Jean                          ', N'Suarez                        ', N'Flix                          ', N'SFM  ', CAST(N'1978-11-27' AS Date), N'027', N'00005')
GO
INSERT [dbo].[Jugador] ([CodJugador], [Nombre1], [Nombre2], [Apellido1], [Apellido2], [CiudadNacim], [FechaNacim], [Numero], [CodEquipo]) VALUES (N'00026', N'Leandro                       ', N'Jorge                         ', N'Cabrera                       ', N'Marte                         ', N'NG   ', CAST(N'1980-03-23' AS Date), N'023', N'00006')
GO
INSERT [dbo].[Jugador] ([CodJugador], [Nombre1], [Nombre2], [Apellido1], [Apellido2], [CiudadNacim], [FechaNacim], [Numero], [CodEquipo]) VALUES (N'00027', N'Julio                         ', N'Enrique                       ', N'Ortiz                         ', N'Duran                         ', N'AZ   ', CAST(N'1981-01-17' AS Date), N'017', N'00006')
GO
INSERT [dbo].[Jugador] ([CodJugador], [Nombre1], [Nombre2], [Apellido1], [Apellido2], [CiudadNacim], [FechaNacim], [Numero], [CodEquipo]) VALUES (N'00028', N'Anderson                      ', N'Ismael                        ', N'Pujols                        ', N'Gomez                         ', N'SJM  ', CAST(N'1985-07-10' AS Date), N'010', N'00006')
GO
INSERT [dbo].[Jugador] ([CodJugador], [Nombre1], [Nombre2], [Apellido1], [Apellido2], [CiudadNacim], [FechaNacim], [Numero], [CodEquipo]) VALUES (N'00029', N'Omar                          ', N'Peter                         ', N'Bautista                      ', N'Guzman                        ', N'SC   ', CAST(N'1976-06-15' AS Date), N'015', N'00006')
GO
INSERT [dbo].[Jugador] ([CodJugador], [Nombre1], [Nombre2], [Apellido1], [Apellido2], [CiudadNacim], [FechaNacim], [Numero], [CodEquipo]) VALUES (N'00030', N'Xavier                        ', N'David                         ', N'Perez                         ', N'Mena                          ', N'LA   ', CAST(N'1984-05-26' AS Date), N'026', N'00006')
GO
ALTER TABLE [dbo].[Equipo]  WITH CHECK ADD  CONSTRAINT [FK_Equipo_Equipo] FOREIGN KEY([CodCiudad])
REFERENCES [dbo].[Ciudad] ([CodCiudad])
GO
ALTER TABLE [dbo].[Equipo] CHECK CONSTRAINT [FK_Equipo_Equipo]
GO
ALTER TABLE [dbo].[EstadisticaJuego]  WITH CHECK ADD  CONSTRAINT [FK_EstadisticaJuego_Estadistica] FOREIGN KEY([CodEstadistica])
REFERENCES [dbo].[Estadistica] ([CodEstadistica])
GO
ALTER TABLE [dbo].[EstadisticaJuego] CHECK CONSTRAINT [FK_EstadisticaJuego_Estadistica]
GO
ALTER TABLE [dbo].[EstadisticaJuego]  WITH CHECK ADD  CONSTRAINT [FK_EstadisticaJuego_Juego] FOREIGN KEY([CodJuego])
REFERENCES [dbo].[Juego] ([codjuego])
GO
ALTER TABLE [dbo].[EstadisticaJuego] CHECK CONSTRAINT [FK_EstadisticaJuego_Juego]
GO
ALTER TABLE [dbo].[EstadisticaJuego]  WITH CHECK ADD  CONSTRAINT [FK_EstadisticaJuego_Jugador] FOREIGN KEY([CodJugador])
REFERENCES [dbo].[Jugador] ([CodJugador])
GO
ALTER TABLE [dbo].[EstadisticaJuego] CHECK CONSTRAINT [FK_EstadisticaJuego_Jugador]
GO
ALTER TABLE [dbo].[Juego]  WITH CHECK ADD  CONSTRAINT [FK_Juego_Equipo1] FOREIGN KEY([Equipo1])
REFERENCES [dbo].[Equipo] ([CodEquipo])
GO
ALTER TABLE [dbo].[Juego] CHECK CONSTRAINT [FK_Juego_Equipo1]
GO
ALTER TABLE [dbo].[Juego]  WITH CHECK ADD  CONSTRAINT [FK_Juego_Equipo2] FOREIGN KEY([Equipo2])
REFERENCES [dbo].[Equipo] ([CodEquipo])
GO
ALTER TABLE [dbo].[Juego] CHECK CONSTRAINT [FK_Juego_Equipo2]
GO
ALTER TABLE [dbo].[Jugador]  WITH CHECK ADD  CONSTRAINT [FK_Jugador_Equipo] FOREIGN KEY([CodEquipo])
REFERENCES [dbo].[Equipo] ([CodEquipo])
GO
ALTER TABLE [dbo].[Jugador] CHECK CONSTRAINT [FK_Jugador_Equipo]
GO
/****** Object:  StoredProcedure [dbo].[LideresGral]    Script Date: 23/09/2020 03:28:51 p.m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		Aliz
-- Create date: <Create Date,,>
-- Description:	<DescriAlption,,>
-- =============================================
CREATE PROCEDURE [dbo].[LideresGral]
	-- Add the parameters for the stored procedure here
	@TOPE tinyint
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

	IF @TOPE <= 0 
	BEGIN
		SET @TOPE = 1
	END

	CREATE TABLE #DATOS(Orden tinyint, COL1 CHAR(67) NULL ,COL2 tinyint NULL)

	INSERT #DATOS
	VALUES (1,'Líderes por renglones',0)


	INSERT #DATOS
	VALUES (2,'Asistencias',0)
 
	INSERT #DATOS 
	SELECT 3,[dbo].[FormatName](J.Nombre1,J.Nombre2,J.Apellido1,J.Apellido2) AS JUGADOR,SUM(ej.Cantidad) As Asistencias
	FROM EstadisticaJuego Ej, Jugador J
	WHERE J.CodJugador = EJ.CodJugador
	  AND CodEstadistica = '03'
	Group by [dbo].[FormatName](J.Nombre1,J.Nombre2,J.Apellido1,J.Apellido2)
	ORDER BY 2 DESC
  
	INSERT #DATOS
	VALUES (4,'Puntos',0)

	INSERT #DATOS
	SELECT 5,[dbo].[FormatName](J.Nombre1,J.Nombre2,J.Apellido1,J.Apellido2) AS JUGADOR,SUM(E.Valor * EJ.Cantidad) as "TotalPuntos"
	FROM EstadisticaJuego Ej, Jugador J, Estadistica E
	WHERE J.CodJugador = EJ.CodJugador
	  AND E.CodEstadistica = EJ.CodEstadistica
	  AND EJ.CodEstadistica in ('01','02','09')
	Group by [dbo].[FormatName](J.Nombre1,J.Nombre2,J.Apellido1,J.Apellido2)
	ORDER BY 2 DESC


/*****************************************************/
/* INICIO Eliminando las filas mayores a @Tope       */  
/*****************************************************/
DECLARE @ORDEN tinyint, @Renglon char(67), @valor tinyint, @contador tinyint

DECLARE lideres CURSOR FOR   
	SELECT Orden, rtrim(COL1) Renglon , COL2 Valor
	FROM #DATOS
	WHERE ORDEN = 3
	ORDER BY 1,3 DESC;

OPEN lideres  

SET @contador = 0

FETCH NEXT FROM lideres   
INTO @ORDEN, @Renglon, @valor;

WHILE @@FETCH_STATUS = 0  
BEGIN  
	
	SET @CONTADOR = @CONTADOR + 1

	IF ( @CONTADOR > @TOPE )
	BEGIN
		DELETE FROM #DATOS
		WHERE #DATOS.ORDEN = @ORDEN 
		  AND #DATOS.COL1 = @Renglon
		  AND #DATOS.COL2 = @VALOR;

	END

	FETCH NEXT FROM lideres   
	INTO @ORDEN, @Renglon, @valor ;
END   
CLOSE lideres;  
DEALLOCATE lideres;  

/*****************************************************/
/* FIN Eliminando las filas mayores a @Tope       */  
/*****************************************************/

/*****************************************************/
/* INICIO Eliminando las filas mayores a @Tope       */  
/*****************************************************/

DECLARE lideres CURSOR FOR   
	SELECT Orden, rtrim(COL1) Renglon , COL2 Valor
	FROM #DATOS
	WHERE ORDEN = 5
	ORDER BY 1,3 DESC;

OPEN lideres  

SET @contador = 0

FETCH NEXT FROM lideres   
INTO @ORDEN, @Renglon, @valor;

WHILE @@FETCH_STATUS = 0  
BEGIN  
	
	SET @CONTADOR = @CONTADOR + 1

	IF ( @CONTADOR > @TOPE )
	BEGIN
		DELETE FROM #DATOS
		WHERE #DATOS.ORDEN = @ORDEN 
		  AND #DATOS.COL1 = @Renglon
		  AND #DATOS.COL2 = @VALOR;

	END

	FETCH NEXT FROM lideres   
	INTO @ORDEN, @Renglon, @valor ;
END   
CLOSE lideres;  
DEALLOCATE lideres;  

/*****************************************************/
/* FIN Eliminando las filas mayores a @Tope       */  
/*****************************************************/

	SELECT Orden, rtrim(COL1) Renglon , COL2 Valor
	FROM #DATOS
	ORDER BY 1,3 DESC

	/*SELECT Orden, rtrim(COL1) Renglon , CASE COL2 WHEN 0 THEN '' ELSE convert(char(5), COL2) END Valor
	FROM #DATOS
	ORDER BY 1,3 DESC*/

	DELETE #DATOS
	
END

GO
/****** Object:  StoredProcedure [dbo].[SP_PromJuegEquipo]    Script Date: 23/09/2020 03:28:51 p.m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		Alejandro Liz
-- Create date: 30-10-2019
-- Description:	
-- =============================================
CREATE PROCEDURE [dbo].[SP_PromJuegEquipo] 
	-- Add the parameters for the stored procedure here
	@idequipo char(10) = NULL
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    -- Insert statements for procedure here
	SELECT @idequipo
END

GO
EXEC sys.sp_addextendedproperty @name=N'MS_DiagramPane1', @value=N'[0E232FF0-B466-11cf-A24F-00AA00A3EFFF, 1.00]
Begin DesignProperties = 
   Begin PaneConfigurations = 
      Begin PaneConfiguration = 0
         NumPanes = 4
         Configuration = "(H (1[59] 4[6] 2[21] 3) )"
      End
      Begin PaneConfiguration = 1
         NumPanes = 3
         Configuration = "(H (1 [50] 4 [25] 3))"
      End
      Begin PaneConfiguration = 2
         NumPanes = 3
         Configuration = "(H (1 [50] 2 [25] 3))"
      End
      Begin PaneConfiguration = 3
         NumPanes = 3
         Configuration = "(H (4 [30] 2 [40] 3))"
      End
      Begin PaneConfiguration = 4
         NumPanes = 2
         Configuration = "(H (1 [56] 3))"
      End
      Begin PaneConfiguration = 5
         NumPanes = 2
         Configuration = "(H (2 [66] 3))"
      End
      Begin PaneConfiguration = 6
         NumPanes = 2
         Configuration = "(H (4 [50] 3))"
      End
      Begin PaneConfiguration = 7
         NumPanes = 1
         Configuration = "(V (3))"
      End
      Begin PaneConfiguration = 8
         NumPanes = 3
         Configuration = "(H (1[56] 4[18] 2) )"
      End
      Begin PaneConfiguration = 9
         NumPanes = 2
         Configuration = "(H (1 [75] 4))"
      End
      Begin PaneConfiguration = 10
         NumPanes = 2
         Configuration = "(H (1[66] 2) )"
      End
      Begin PaneConfiguration = 11
         NumPanes = 2
         Configuration = "(H (4 [60] 2))"
      End
      Begin PaneConfiguration = 12
         NumPanes = 1
         Configuration = "(H (1) )"
      End
      Begin PaneConfiguration = 13
         NumPanes = 1
         Configuration = "(V (4))"
      End
      Begin PaneConfiguration = 14
         NumPanes = 1
         Configuration = "(V (2))"
      End
      ActivePaneConfig = 0
   End
   Begin DiagramPane = 
      Begin Origin = 
         Top = 0
         Left = 0
      End
      Begin Tables = 
         Begin Table = "Ciudad"
            Begin Extent = 
               Top = 6
               Left = 38
               Bottom = 101
               Right = 208
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "Equipo"
            Begin Extent = 
               Top = 102
               Left = 38
               Bottom = 214
               Right = 208
            End
            DisplayFlags = 280
            TopColumn = 0
         End
      End
   End
   Begin SQLPane = 
   End
   Begin DataPane = 
      Begin ParameterDefaults = ""
      End
   End
   Begin CriteriaPane = 
      Begin ColumnWidths = 11
         Column = 1440
         Alias = 900
         Table = 1170
         Output = 720
         Append = 1400
         NewValue = 1170
         SortType = 1350
         SortOrder = 1410
         GroupBy = 1350
         Filter = 1350
         Or = 1350
         Or = 1350
         Or = 1350
      End
   End
End
' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'VIEW',@level1name=N'View_EquipoCiudad'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DiagramPaneCount', @value=1 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'VIEW',@level1name=N'View_EquipoCiudad'
GO
USE [master]
GO
ALTER DATABASE [BasketBall] SET  READ_WRITE 
GO