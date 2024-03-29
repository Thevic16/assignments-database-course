USE [master]
GO
/****** Object:  Database [academica]    Script Date: 19/10/2020 5:11:14 p. m. ******/
CREATE DATABASE [academica]
 CONTAINMENT = NONE
 ON  PRIMARY 
( NAME = N'academica', FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL15.MSSQLSERVER\MSSQL\DATA\academica.mdf' , SIZE = 8192KB , MAXSIZE = UNLIMITED, FILEGROWTH = 65536KB )
 LOG ON 
( NAME = N'academica_log', FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL15.MSSQLSERVER\MSSQL\DATA\academica_log.ldf' , SIZE = 8192KB , MAXSIZE = 2048GB , FILEGROWTH = 65536KB )
 WITH CATALOG_COLLATION = DATABASE_DEFAULT
GO
ALTER DATABASE [academica] SET COMPATIBILITY_LEVEL = 150
GO
IF (1 = FULLTEXTSERVICEPROPERTY('IsFullTextInstalled'))
begin
EXEC [academica].[dbo].[sp_fulltext_database] @action = 'enable'
end
GO
ALTER DATABASE [academica] SET ANSI_NULL_DEFAULT OFF 
GO
ALTER DATABASE [academica] SET ANSI_NULLS OFF 
GO
ALTER DATABASE [academica] SET ANSI_PADDING OFF 
GO
ALTER DATABASE [academica] SET ANSI_WARNINGS OFF 
GO
ALTER DATABASE [academica] SET ARITHABORT OFF 
GO
ALTER DATABASE [academica] SET AUTO_CLOSE OFF 
GO
ALTER DATABASE [academica] SET AUTO_SHRINK OFF 
GO
ALTER DATABASE [academica] SET AUTO_UPDATE_STATISTICS ON 
GO
ALTER DATABASE [academica] SET CURSOR_CLOSE_ON_COMMIT OFF 
GO
ALTER DATABASE [academica] SET CURSOR_DEFAULT  GLOBAL 
GO
ALTER DATABASE [academica] SET CONCAT_NULL_YIELDS_NULL OFF 
GO
ALTER DATABASE [academica] SET NUMERIC_ROUNDABORT OFF 
GO
ALTER DATABASE [academica] SET QUOTED_IDENTIFIER OFF 
GO
ALTER DATABASE [academica] SET RECURSIVE_TRIGGERS OFF 
GO
ALTER DATABASE [academica] SET  DISABLE_BROKER 
GO
ALTER DATABASE [academica] SET AUTO_UPDATE_STATISTICS_ASYNC OFF 
GO
ALTER DATABASE [academica] SET DATE_CORRELATION_OPTIMIZATION OFF 
GO
ALTER DATABASE [academica] SET TRUSTWORTHY OFF 
GO
ALTER DATABASE [academica] SET ALLOW_SNAPSHOT_ISOLATION OFF 
GO
ALTER DATABASE [academica] SET PARAMETERIZATION SIMPLE 
GO
ALTER DATABASE [academica] SET READ_COMMITTED_SNAPSHOT OFF 
GO
ALTER DATABASE [academica] SET HONOR_BROKER_PRIORITY OFF 
GO
ALTER DATABASE [academica] SET RECOVERY FULL 
GO
ALTER DATABASE [academica] SET  MULTI_USER 
GO
ALTER DATABASE [academica] SET PAGE_VERIFY CHECKSUM  
GO
ALTER DATABASE [academica] SET DB_CHAINING OFF 
GO
ALTER DATABASE [academica] SET FILESTREAM( NON_TRANSACTED_ACCESS = OFF ) 
GO
ALTER DATABASE [academica] SET TARGET_RECOVERY_TIME = 60 SECONDS 
GO
ALTER DATABASE [academica] SET DELAYED_DURABILITY = DISABLED 
GO
EXEC sys.sp_db_vardecimal_storage_format N'academica', N'ON'
GO
ALTER DATABASE [academica] SET QUERY_STORE = OFF
GO
USE [academica]
GO
/****** Object:  UserDefinedFunction [dbo].[CheckFechaClase]    Script Date: 19/10/2020 5:11:14 p. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		Victor Gomez
-- Create date: 18-10-2020
-- Description:	Comprobar fecha clases
-- =============================================
CREATE FUNCTION [dbo].[CheckFechaClase] 
(
	-- Add the parameters for the function here
	@FechaInicioClase date, @FechaFinClase date
)
RETURNS int
AS
BEGIN
	-- Declare the return variable here
	DECLARE @Result int = 0

	-- Add the T-SQL statements to compute the return value here
	IF(DATEDIFF(wk,@FechaInicioClase, @FechaFinClase) >= 10)
		BEGIN
			SET @Result = 1
		END

	-- Return the result of the function
	RETURN @Result

END
GO
/****** Object:  UserDefinedFunction [dbo].[CheckFechas]    Script Date: 19/10/2020 5:11:14 p. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		Victor Gomez
-- Create date: 18-10-2020
-- Description:	Verifica que las fechas sean ingresadas correctamente. 
-- =============================================
CREATE FUNCTION [dbo].[CheckFechas] 
(
	-- Add the parameters for the function here
	@FechaInicio date,@FechaFin date, @FechaInicioClases date,@FechaFinClases date,@FechaPrematricula date, @FechaLimiteRetiro date,@FechaLimitePublicacionCalif date
)
RETURNS int
AS
BEGIN
	-- Declare the return variable here
	DECLARE @Result int =0

	-- Add the T-SQL statements to compute the return value here
	IF( (@FechaInicioClases BETWEEN @FechaInicio AND @FechaFin) AND (@FechaFinClases BETWEEN @FechaInicio AND @FechaFin) AND (@FechaPrematricula BETWEEN @FechaInicio AND @FechaFin) AND 
	(@FechaLimiteRetiro BETWEEN @FechaInicio AND @FechaFin) AND (@FechaLimitePublicacionCalif BETWEEN @FechaInicio AND @FechaFin) )
	BEGIN
		SET @Result =1
	END

	-- Return the result of the function
	RETURN @Result

END
GO
/****** Object:  UserDefinedFunction [dbo].[EsPeriodoClases]    Script Date: 19/10/2020 5:11:14 p. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		Víctor Gómez
-- Create date: 10-10-2020
-- Description:	Que retorne 1 si estamos en período de clases para el período actual y 0 si no estamos en período de clases para el período actual.
-- =============================================
CREATE FUNCTION [dbo].[EsPeriodoClases] 
(
	-- Add the parameters for the function here
)
RETURNS int
AS
BEGIN
	-- Declare the return variable here
	--DECLARE @Result int = 0

	-- Add the T-SQL statements to compute the return value here
	IF (SELECT COUNT([Periodo Academico].[Cod PeriodoAcad])
		FROM [Periodo Academico]
		WHERE GETDATE() >= [Periodo Academico].FechaInicioClases  AND GETDATE() <= [Periodo Academico].FechaFinClases AND [Periodo Academico].[Cod PeriodoAcad] = [dbo].PeriodoActual())>0 
		BEGIN
			 RETURN 1
		END

	-- Return the result of the function
	RETURN 0

END
GO
/****** Object:  UserDefinedFunction [dbo].[OcupacionGrupo]    Script Date: 19/10/2020 5:11:14 p. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		Vìctor Gòmez
-- Create date: 10-10-2020
-- Description:	OcupacionGrupo: Que retorne la cantidad de estudiantes inscritos en un grupo.
-- =============================================
CREATE FUNCTION [dbo].[OcupacionGrupo] 
(
	-- Add the parameters for the function here
	@CodPeridAcad nchar(9),@CodAsignatura nchar(7), @NumGrupo nchar(3)
)
RETURNS int
AS
BEGIN
	-- Declare the return variable here
	DECLARE @Result int = 0

	-- Add the T-SQL statements to compute the return value here
	SELECT @Result = COUNT(Matricula)
	FROM Inscripcion
	WHERE NumGrupo = @NumGrupo AND [Cod Asignatura] = @CodAsignatura AND [código PeridoAcad] = @CodPeridAcad
	GROUP BY [código PeridoAcad],[Cod Asignatura],NumGrupo

	-- Return the result of the function
	RETURN @Result

END
GO
/****** Object:  UserDefinedFunction [dbo].[PeriodoActual]    Script Date: 19/10/2020 5:11:14 p. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		Víctor Gómez
-- Create date: 10-10-2020
-- Description:	PeriodoActual: Que retorne en una cadena de caracteres el Período Actual.Esto partiendo de la fechainicio y FechaFin del Período.
-- =============================================
CREATE FUNCTION [dbo].[PeriodoActual] 
(
	-- Add the parameters for the function here
	
)
RETURNS nchar(9)
AS
BEGIN
	-- Declare the return variable here
	DECLARE @Result nchar(9)

	-- Add the T-SQL statements to compute the return value here
	SELECT @Result = [Periodo Academico].[Cod PeriodoAcad]
	FROM [Periodo Academico]
	WHERE  GETDATE() >= [Periodo Academico].FechaInicio  AND GETDATE() <= [Periodo Academico].FechaFin 

	-- Return the result of the function
	RETURN @Result

END
GO
/****** Object:  UserDefinedFunction [dbo].[Solapar]    Script Date: 19/10/2020 5:11:14 p. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		Victor Gomez
-- Create date: 17-10-2020
-- Description:	Verifica si la fecha de inicio del periodo no se solapa con otro perido
-- =============================================
CREATE FUNCTION [dbo].[Solapar] 
(
	-- Add the parameters for the function here
	@FechaInicio date
)
RETURNS int
AS
BEGIN
	-- Declare the return variable here
	DECLARE @Result int = 0

	-- Add the T-SQL statements to compute the return value here
	IF(SELECT COUNT(*) FROM [Periodo Academico]
	 WHERE @FechaInicio >= [Periodo Academico].FechaInicio AND @FechaInicio <= [Periodo Academico].FechaFin) >0
		BEGIN
			SET @Result =1
		END

	-- Return the result of the function
	RETURN @Result

END
GO
/****** Object:  Table [dbo].[Estudiante]    Script Date: 19/10/2020 5:11:14 p. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Estudiante](
	[matricula] [nchar](8) NOT NULL,
	[nombre1] [nchar](30) NULL,
	[nombre2] [nchar](35) NULL,
	[apellido1] [nchar](25) NULL,
	[apellido2] [nchar](25) NULL,
	[carrera] [nchar](4) NULL,
	[pago] [nchar](3) NULL,
	[nacionalidad] [nchar](3) NULL,
	[dirección] [nchar](256) NULL,
 CONSTRAINT [PK_estudiante] PRIMARY KEY CLUSTERED 
(
	[matricula] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Inscripcion]    Script Date: 19/10/2020 5:11:14 p. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Inscripcion](
	[código PeridoAcad] [nchar](9) NOT NULL,
	[Matricula] [nchar](8) NOT NULL,
	[Cod Asignatura] [nchar](7) NOT NULL,
	[NumGrupo] [nchar](3) NOT NULL,
 CONSTRAINT [PK_inscripción] PRIMARY KEY CLUSTERED 
(
	[código PeridoAcad] ASC,
	[Matricula] ASC,
	[Cod Asignatura] ASC,
	[NumGrupo] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Grupo]    Script Date: 19/10/2020 5:11:14 p. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Grupo](
	[CodPeridoAcad] [nchar](9) NOT NULL,
	[Cod Asignatura] [nchar](7) NOT NULL,
	[NumGrupo] [nchar](3) NOT NULL,
	[CupoGrupo] [int] NULL,
	[Horario] [nchar](50) NULL,
 CONSTRAINT [PK_Grupo] PRIMARY KEY CLUSTERED 
(
	[CodPeridoAcad] ASC,
	[Cod Asignatura] ASC,
	[NumGrupo] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  View [dbo].[View_Grup_InscEst]    Script Date: 19/10/2020 5:11:14 p. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE VIEW [dbo].[View_Grup_InscEst]
AS
SELECT        I.[código PeridoAcad], E.matrícula, I.[Cod Asignatura], I.NumGrupo, G.Horario
FROM            dbo.Inscripcion AS I INNER JOIN
                         dbo.Estudiante AS E ON I.Matricula = E.matrícula INNER JOIN
                         dbo.Grupo AS G ON I.[código PeridoAcad] = G.CodPeridoAcad AND I.[Cod Asignatura] = G.[Cod Asignatura] AND I.NumGrupo = G.NumGrupo
GO
/****** Object:  Table [dbo].[Periodo Academico]    Script Date: 19/10/2020 5:11:14 p. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Periodo Academico](
	[Cod PeriodoAcad] [nchar](9) NOT NULL,
	[Descripcion] [nchar](30) NULL,
	[FechaInicio] [date] NULL,
	[FechaFin] [date] NULL,
	[FechaInicioClases] [date] NULL,
	[FechaFinClases] [date] NULL,
	[FechaLimitePago] [date] NULL,
	[FechaLimitePrematricula] [date] NULL,
	[FechaLimiteRetiro] [date] NULL,
	[FechalimitePublicacion] [date] NULL,
 CONSTRAINT [PK_período académico] PRIMARY KEY CLUSTERED 
(
	[Cod PeriodoAcad] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  View [dbo].[View_Grup_Perid_Act]    Script Date: 19/10/2020 5:11:14 p. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE VIEW [dbo].[View_Grup_Perid_Act]
AS
SELECT        P.[Cod PeriodoAcad], G.[Cod Asignatura], G.NumGrupo, G.CupoGrupo, dbo.OcupacionGrupo(G.CodPeridoAcad, G.[Cod Asignatura], G.NumGrupo) AS Ocupación, G.CupoGrupo - dbo.OcupacionGrupo(G.CodPeridoAcad, 
                         G.[Cod Asignatura], G.NumGrupo) AS Disponibilidad, G.Horario
FROM            dbo.[Periodo Academico] AS P INNER JOIN
                         dbo.Grupo AS G ON P.[Cod PeriodoAcad] = G.CodPeridoAcad
WHERE        (P.[Cod PeriodoAcad] = dbo.PeriodoActual())
GO
/****** Object:  Table [dbo].[Asignatura]    Script Date: 19/10/2020 5:11:14 p. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Asignatura](
	[Cod Asignatura] [nchar](7) NOT NULL,
	[nombre] [nchar](60) NULL,
	[creditos] [int] NULL,
	[HorasTeoricas] [int] NULL,
	[HorasPracticas] [int] NULL,
 CONSTRAINT [PK_asignatura] PRIMARY KEY CLUSTERED 
(
	[Cod Asignatura] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[DiaSemana]    Script Date: 19/10/2020 5:11:14 p. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[DiaSemana](
	[Dia] [int] NOT NULL,
	[Nombre] [nchar](10) NULL,
 CONSTRAINT [PK_DiaSemana] PRIMARY KEY CLUSTERED 
(
	[Dia] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[GrupoHorario]    Script Date: 19/10/2020 5:11:14 p. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[GrupoHorario](
	[CodPeriodoAcad] [nchar](9) NOT NULL,
	[CodAsignatura] [nchar](7) NOT NULL,
	[NumGrupo] [nchar](3) NOT NULL,
	[Dia] [int] NULL,
	[HoraInicial] [time](7) NULL,
	[HoraFinal] [time](7) NULL,
 CONSTRAINT [PK_GrupoHorario] PRIMARY KEY CLUSTERED 
(
	[CodPeriodoAcad] ASC,
	[CodAsignatura] ASC,
	[NumGrupo] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
ALTER TABLE [dbo].[Grupo]  WITH CHECK ADD  CONSTRAINT [FK_Grupo_Asignatura] FOREIGN KEY([Cod Asignatura])
REFERENCES [dbo].[Asignatura] ([Cod Asignatura])
GO
ALTER TABLE [dbo].[Grupo] CHECK CONSTRAINT [FK_Grupo_Asignatura]
GO
ALTER TABLE [dbo].[Grupo]  WITH CHECK ADD  CONSTRAINT [FK_Grupo_Periodo Academico] FOREIGN KEY([CodPeridoAcad])
REFERENCES [dbo].[Periodo Academico] ([Cod PeriodoAcad])
GO
ALTER TABLE [dbo].[Grupo] CHECK CONSTRAINT [FK_Grupo_Periodo Academico]
GO
ALTER TABLE [dbo].[GrupoHorario]  WITH CHECK ADD  CONSTRAINT [FK_GrupoHorario_DiaSemana] FOREIGN KEY([CodPeriodoAcad], [CodAsignatura], [NumGrupo])
REFERENCES [dbo].[Grupo] ([CodPeridoAcad], [Cod Asignatura], [NumGrupo])
GO
ALTER TABLE [dbo].[GrupoHorario] CHECK CONSTRAINT [FK_GrupoHorario_DiaSemana]
GO
ALTER TABLE [dbo].[GrupoHorario]  WITH CHECK ADD  CONSTRAINT [FK_GrupoHorario_DiaSemana1] FOREIGN KEY([Dia])
REFERENCES [dbo].[DiaSemana] ([Dia])
GO
ALTER TABLE [dbo].[GrupoHorario] CHECK CONSTRAINT [FK_GrupoHorario_DiaSemana1]
GO
ALTER TABLE [dbo].[Inscripcion]  WITH CHECK ADD  CONSTRAINT [FK_Inscripcion_Estudiante] FOREIGN KEY([Matricula])
REFERENCES [dbo].[Estudiante] ([matricula])
GO
ALTER TABLE [dbo].[Inscripcion] CHECK CONSTRAINT [FK_Inscripcion_Estudiante]
GO
ALTER TABLE [dbo].[Inscripcion]  WITH CHECK ADD  CONSTRAINT [FK_Inscripcion_Grupo] FOREIGN KEY([código PeridoAcad], [Cod Asignatura], [NumGrupo])
REFERENCES [dbo].[Grupo] ([CodPeridoAcad], [Cod Asignatura], [NumGrupo])
GO
ALTER TABLE [dbo].[Inscripcion] CHECK CONSTRAINT [FK_Inscripcion_Grupo]
GO
ALTER TABLE [dbo].[Inscripcion]  WITH CHECK ADD  CONSTRAINT [FK_Inscripcion_Periodo Academico] FOREIGN KEY([código PeridoAcad])
REFERENCES [dbo].[Periodo Academico] ([Cod PeriodoAcad])
GO
ALTER TABLE [dbo].[Inscripcion] CHECK CONSTRAINT [FK_Inscripcion_Periodo Academico]
GO
ALTER TABLE [dbo].[Asignatura]  WITH CHECK ADD  CONSTRAINT [CK_CodAsignatura] CHECK  (([Cod Asignatura] like '[A-Z][A-Z][A-Z][0-9][0-9][0-9][T]' OR [Cod Asignatura] like '[A-Z][A-Z][A-Z][0-9][0-9][0-9][P]'))
GO
ALTER TABLE [dbo].[Asignatura] CHECK CONSTRAINT [CK_CodAsignatura]
GO
ALTER TABLE [dbo].[DiaSemana]  WITH CHECK ADD  CONSTRAINT [CK_RestriccionDia] CHECK  (([dia] like '[0-6]'))
GO
ALTER TABLE [dbo].[DiaSemana] CHECK CONSTRAINT [CK_RestriccionDia]
GO
ALTER TABLE [dbo].[Estudiante]  WITH CHECK ADD  CONSTRAINT [CK_Matricula] CHECK  (([matricula] like '[0-9][0-9][0-9][0-9][0-9][0-9][0-9][0-9]'))
GO
ALTER TABLE [dbo].[Estudiante] CHECK CONSTRAINT [CK_Matricula]
GO
ALTER TABLE [dbo].[GrupoHorario]  WITH CHECK ADD  CONSTRAINT [CK_GrupoHorario] CHECK  (([HoraInicial]<[HoraFinal]))
GO
ALTER TABLE [dbo].[GrupoHorario] CHECK CONSTRAINT [CK_GrupoHorario]
GO
ALTER TABLE [dbo].[Periodo Academico]  WITH CHECK ADD  CONSTRAINT [CK_Cod_Periodo_Aca] CHECK  (([Cod PeriodoAcad] like '[0-9][0-9][0-9][0-9][0-9][0-9][0-9][0-9][0-9]' AND CONVERT([int],substring([Cod PeriodoAcad],(1),(4)))=(CONVERT([int],substring([Cod PeriodoAcad],(5),(4)))-(1)) AND substring([Cod PeriodoAcad],(9),(1)) like '[1-3]'))
GO
ALTER TABLE [dbo].[Periodo Academico] CHECK CONSTRAINT [CK_Cod_Periodo_Aca]
GO
ALTER TABLE [dbo].[Periodo Academico]  WITH CHECK ADD  CONSTRAINT [CK_Periodo Academico] CHECK  (([dbo].[Solapar]([FechaInicio])=(0) AND [dbo].[CheckFechaClase]([FechaInicioClases],[FechaFinClases])=(1) AND [dbo].[CheckFechas]([FechaInicio],[FechaFin],[FechaInicioClases],[FechaFinClases],[FechaLimitePrematricula],[FechaLimiteRetiro],[FechalimitePublicacion])=(1)))
GO
ALTER TABLE [dbo].[Periodo Academico] CHECK CONSTRAINT [CK_Periodo Academico]
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Verifica que el codigo de la asignatura sea ingresado correctamente.' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Asignatura', @level2type=N'CONSTRAINT',@level2name=N'CK_CodAsignatura'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Restringe el valor que puede tener dia en el rango de 0 a 6.' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'DiaSemana', @level2type=N'CONSTRAINT',@level2name=N'CK_RestriccionDia'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Confirma que la matricula del estudiante solo tenga valores numericos. ' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Estudiante', @level2type=N'CONSTRAINT',@level2name=N'CK_Matricula'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Verificar que HoraInicial sea menor que la HoraFinal.' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'GrupoHorario', @level2type=N'CONSTRAINT',@level2name=N'CK_GrupoHorario'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Verifica el periodo academico.' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Periodo Academico', @level2type=N'CONSTRAINT',@level2name=N'CK_Cod_Periodo_Aca'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Verificar que las fechas sean ingresadas de la manera correcta.' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Periodo Academico', @level2type=N'CONSTRAINT',@level2name=N'CK_Periodo Academico'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DiagramPane1', @value=N'[0E232FF0-B466-11cf-A24F-00AA00A3EFFF, 1.00]
Begin DesignProperties = 
   Begin PaneConfigurations = 
      Begin PaneConfiguration = 0
         NumPanes = 4
         Configuration = "(H (1[40] 4[20] 2[20] 3) )"
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
         Begin Table = "I"
            Begin Extent = 
               Top = 6
               Left = 38
               Bottom = 136
               Right = 228
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "E"
            Begin Extent = 
               Top = 6
               Left = 266
               Bottom = 136
               Right = 436
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "G"
            Begin Extent = 
               Top = 6
               Left = 474
               Bottom = 136
               Right = 646
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
' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'VIEW',@level1name=N'View_Grup_InscEst'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DiagramPaneCount', @value=1 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'VIEW',@level1name=N'View_Grup_InscEst'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DiagramPane1', @value=N'[0E232FF0-B466-11cf-A24F-00AA00A3EFFF, 1.00]
Begin DesignProperties = 
   Begin PaneConfigurations = 
      Begin PaneConfiguration = 0
         NumPanes = 4
         Configuration = "(H (1[40] 4[20] 2[20] 3) )"
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
         Begin Table = "P"
            Begin Extent = 
               Top = 6
               Left = 38
               Bottom = 136
               Right = 258
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "G"
            Begin Extent = 
               Top = 6
               Left = 296
               Bottom = 136
               Right = 468
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
' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'VIEW',@level1name=N'View_Grup_Perid_Act'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DiagramPaneCount', @value=1 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'VIEW',@level1name=N'View_Grup_Perid_Act'
GO
USE [master]
GO
ALTER DATABASE [academica] SET  READ_WRITE 
GO
