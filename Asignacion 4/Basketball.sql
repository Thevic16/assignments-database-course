USE [master]
GO
/****** Object:  Database [BasketBall2]    Script Date: 13/10/2020 10:18:36 p. m. ******/
CREATE DATABASE [BasketBall2]
 CONTAINMENT = NONE
 ON  PRIMARY 
( NAME = N'BasketBall2', FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL15.MSSQLSERVER\MSSQL\DATA\BasketBall2.mdf' , SIZE = 8192KB , MAXSIZE = UNLIMITED, FILEGROWTH = 1024KB )
 LOG ON 
( NAME = N'BasketBall2_log', FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL15.MSSQLSERVER\MSSQL\DATA\BasketBall2_log.ldf' , SIZE = 1280KB , MAXSIZE = 2048GB , FILEGROWTH = 10%)
 WITH CATALOG_COLLATION = DATABASE_DEFAULT
GO
ALTER DATABASE [BasketBall2] SET COMPATIBILITY_LEVEL = 120
GO
IF (1 = FULLTEXTSERVICEPROPERTY('IsFullTextInstalled'))
begin
EXEC [BasketBall2].[dbo].[sp_fulltext_database] @action = 'enable'
end
GO
ALTER DATABASE [BasketBall2] SET ANSI_NULL_DEFAULT OFF 
GO
ALTER DATABASE [BasketBall2] SET ANSI_NULLS OFF 
GO
ALTER DATABASE [BasketBall2] SET ANSI_PADDING OFF 
GO
ALTER DATABASE [BasketBall2] SET ANSI_WARNINGS OFF 
GO
ALTER DATABASE [BasketBall2] SET ARITHABORT OFF 
GO
ALTER DATABASE [BasketBall2] SET AUTO_CLOSE OFF 
GO
ALTER DATABASE [BasketBall2] SET AUTO_SHRINK OFF 
GO
ALTER DATABASE [BasketBall2] SET AUTO_UPDATE_STATISTICS ON 
GO
ALTER DATABASE [BasketBall2] SET CURSOR_CLOSE_ON_COMMIT OFF 
GO
ALTER DATABASE [BasketBall2] SET CURSOR_DEFAULT  GLOBAL 
GO
ALTER DATABASE [BasketBall2] SET CONCAT_NULL_YIELDS_NULL OFF 
GO
ALTER DATABASE [BasketBall2] SET NUMERIC_ROUNDABORT OFF 
GO
ALTER DATABASE [BasketBall2] SET QUOTED_IDENTIFIER OFF 
GO
ALTER DATABASE [BasketBall2] SET RECURSIVE_TRIGGERS OFF 
GO
ALTER DATABASE [BasketBall2] SET  DISABLE_BROKER 
GO
ALTER DATABASE [BasketBall2] SET AUTO_UPDATE_STATISTICS_ASYNC OFF 
GO
ALTER DATABASE [BasketBall2] SET DATE_CORRELATION_OPTIMIZATION OFF 
GO
ALTER DATABASE [BasketBall2] SET TRUSTWORTHY OFF 
GO
ALTER DATABASE [BasketBall2] SET ALLOW_SNAPSHOT_ISOLATION OFF 
GO
ALTER DATABASE [BasketBall2] SET PARAMETERIZATION SIMPLE 
GO
ALTER DATABASE [BasketBall2] SET READ_COMMITTED_SNAPSHOT OFF 
GO
ALTER DATABASE [BasketBall2] SET HONOR_BROKER_PRIORITY OFF 
GO
ALTER DATABASE [BasketBall2] SET RECOVERY FULL 
GO
ALTER DATABASE [BasketBall2] SET  MULTI_USER 
GO
ALTER DATABASE [BasketBall2] SET PAGE_VERIFY CHECKSUM  
GO
ALTER DATABASE [BasketBall2] SET DB_CHAINING OFF 
GO
ALTER DATABASE [BasketBall2] SET FILESTREAM( NON_TRANSACTED_ACCESS = OFF ) 
GO
ALTER DATABASE [BasketBall2] SET TARGET_RECOVERY_TIME = 0 SECONDS 
GO
ALTER DATABASE [BasketBall2] SET DELAYED_DURABILITY = DISABLED 
GO
EXEC sys.sp_db_vardecimal_storage_format N'BasketBall2', N'ON'
GO
ALTER DATABASE [BasketBall2] SET QUERY_STORE = OFF
GO
USE [BasketBall2]
GO
/****** Object:  UserDefinedFunction [dbo].[FormatName]    Script Date: 13/10/2020 10:18:36 p. m. ******/
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
/****** Object:  UserDefinedFunction [dbo].[TotalPuntosJuego]    Script Date: 13/10/2020 10:18:36 p. m. ******/
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
/****** Object:  Table [dbo].[Ciudad]    Script Date: 13/10/2020 10:18:36 p. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Ciudad](
	[CodCiudad] [nchar](5) NOT NULL,
	[Nombre] [nchar](40) NULL,
	[Actividad] [nchar](30) NULL,
	[Usuario] [nchar](50) NULL,
	[fechahora] [datetime] NULL,
 CONSTRAINT [PK_Ciudad] PRIMARY KEY CLUSTERED 
(
	[CodCiudad] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Equipo]    Script Date: 13/10/2020 10:18:36 p. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Equipo](
	[CodEquipo] [nchar](5) NOT NULL,
	[Nombre] [nchar](40) NULL,
	[CodCiudad] [nchar](5) NULL,
	[Actividad] [nchar](30) NULL,
	[Usuario] [nchar](50) NULL,
	[fechahora] [datetime] NULL,
 CONSTRAINT [PK_Equipo] PRIMARY KEY CLUSTERED 
(
	[CodEquipo] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  UserDefinedFunction [dbo].[EquiposCiudad]    Script Date: 13/10/2020 10:18:37 p. m. ******/
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
/****** Object:  View [dbo].[View_EquipoCiudad]    Script Date: 13/10/2020 10:18:37 p. m. ******/
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
/****** Object:  Table [dbo].[Auditoria]    Script Date: 13/10/2020 10:18:37 p. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Auditoria](
	[tabla] [nchar](40) NOT NULL,
	[actividad] [nchar](30) NOT NULL,
	[columna] [nchar](15) NOT NULL,
	[fechahora] [datetime] NOT NULL,
	[usuario] [nchar](50) NOT NULL,
 CONSTRAINT [PK_Auditoria] PRIMARY KEY CLUSTERED 
(
	[tabla] ASC,
	[actividad] ASC,
	[columna] ASC,
	[fechahora] ASC,
	[usuario] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Estadistica]    Script Date: 13/10/2020 10:18:37 p. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Estadistica](
	[CodEstadistica] [nchar](5) NOT NULL,
	[Descripcion] [nchar](45) NULL,
	[Valor] [smallint] NOT NULL,
	[Actividad] [nchar](30) NULL,
	[Usuario] [nchar](50) NULL,
	[fechahora] [datetime] NULL,
 CONSTRAINT [PK_Estadistica] PRIMARY KEY CLUSTERED 
(
	[CodEstadistica] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[EstadisticaJuego]    Script Date: 13/10/2020 10:18:37 p. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[EstadisticaJuego](
	[CodJuego] [nchar](5) NOT NULL,
	[CodEstadistica] [nchar](5) NOT NULL,
	[CodJugador] [nchar](5) NOT NULL,
	[Cantidad] [smallint] NULL,
	[Actividad] [nchar](30) NULL,
	[Usuario] [nchar](50) NULL,
	[fechahora] [datetime] NULL,
 CONSTRAINT [PK_EstadisticaJuego_1] PRIMARY KEY CLUSTERED 
(
	[CodJuego] ASC,
	[CodEstadistica] ASC,
	[CodJugador] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Juego]    Script Date: 13/10/2020 10:18:37 p. m. ******/
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
	[Actividad] [nchar](30) NULL,
	[Usuario] [nchar](50) NULL,
	[fechahora] [datetime] NULL,
 CONSTRAINT [PK_Juego] PRIMARY KEY CLUSTERED 
(
	[codjuego] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Jugador]    Script Date: 13/10/2020 10:18:37 p. m. ******/
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
	[Actividad] [nchar](30) NULL,
	[Usuario] [nchar](50) NULL,
	[fechahora] [datetime] NULL,
 CONSTRAINT [PK_Jugador] PRIMARY KEY CLUSTERED 
(
	[CodJugador] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
ALTER TABLE [dbo].[Ciudad] ADD  CONSTRAINT [DF_Ciudad_Actividad]  DEFAULT ('Insertado') FOR [Actividad]
GO
ALTER TABLE [dbo].[Ciudad] ADD  CONSTRAINT [DF_Ciudad_Usuario]  DEFAULT (suser_sname()) FOR [Usuario]
GO
ALTER TABLE [dbo].[Ciudad] ADD  CONSTRAINT [DF_Ciudad_fechahora]  DEFAULT (getdate()) FOR [fechahora]
GO
ALTER TABLE [dbo].[Equipo] ADD  CONSTRAINT [DF_Equipo_Actividad]  DEFAULT ('Insertado') FOR [Actividad]
GO
ALTER TABLE [dbo].[Equipo] ADD  CONSTRAINT [DF_Equipo_Usuario]  DEFAULT (suser_sname()) FOR [Usuario]
GO
ALTER TABLE [dbo].[Equipo] ADD  CONSTRAINT [DF_Equipo_fechahora]  DEFAULT (getdate()) FOR [fechahora]
GO
ALTER TABLE [dbo].[Estadistica] ADD  CONSTRAINT [DF_Estadistica_Actividad]  DEFAULT ('Insertado') FOR [Actividad]
GO
ALTER TABLE [dbo].[Estadistica] ADD  CONSTRAINT [DF_Estadistica_Usuario]  DEFAULT (suser_sname()) FOR [Usuario]
GO
ALTER TABLE [dbo].[Estadistica] ADD  CONSTRAINT [DF_Estadistica_fechahora]  DEFAULT (getdate()) FOR [fechahora]
GO
ALTER TABLE [dbo].[EstadisticaJuego] ADD  CONSTRAINT [DF_EstadisticaJuego_Actividad]  DEFAULT ('Insertado') FOR [Actividad]
GO
ALTER TABLE [dbo].[EstadisticaJuego] ADD  CONSTRAINT [DF_EstadisticaJuego_Usuario]  DEFAULT (suser_sname()) FOR [Usuario]
GO
ALTER TABLE [dbo].[EstadisticaJuego] ADD  CONSTRAINT [DF_EstadisticaJuego_fechahora]  DEFAULT (getdate()) FOR [fechahora]
GO
ALTER TABLE [dbo].[Juego] ADD  CONSTRAINT [DF_Juego_Actividad]  DEFAULT ('Insertado') FOR [Actividad]
GO
ALTER TABLE [dbo].[Juego] ADD  CONSTRAINT [DF_Juego_Usuario]  DEFAULT (suser_sname()) FOR [Usuario]
GO
ALTER TABLE [dbo].[Juego] ADD  CONSTRAINT [DF_Juego_fechahora]  DEFAULT (getdate()) FOR [fechahora]
GO
ALTER TABLE [dbo].[Jugador] ADD  CONSTRAINT [DF_Jugador_Actividad]  DEFAULT ('Insertado') FOR [Actividad]
GO
ALTER TABLE [dbo].[Jugador] ADD  CONSTRAINT [DF_Jugador_Usuario]  DEFAULT (suser_sname()) FOR [Usuario]
GO
ALTER TABLE [dbo].[Jugador] ADD  CONSTRAINT [DF_Jugador_fechahora]  DEFAULT (getdate()) FOR [fechahora]
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
/****** Object:  StoredProcedure [dbo].[LideresGral]    Script Date: 13/10/2020 10:18:37 p. m. ******/
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
/****** Object:  StoredProcedure [dbo].[SP_PromJuegEquipo]    Script Date: 13/10/2020 10:18:37 p. m. ******/
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
ALTER DATABASE [BasketBall2] SET  READ_WRITE 
GO
