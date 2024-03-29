USE [BasketBall2]
GO
/****** Object:  Trigger [dbo].[IT_Juego]    Script Date: 3/10/2020 12:27:26 a. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		Victor gomez
-- Create date: 03-10-2020
-- Description:	
-- =============================================
ALTER TRIGGER  [dbo].[IT_Juego] 
   ON  [dbo].[Juego] 
   AFTER INSERT
AS 
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    -- Insert statements for trigger here
	IF(SELECT COUNT(*)
		FROM inserted
		WHERE equipo1 = equipo2) > 0
	BEGIN 
		THROW 70001,'El juego se debe dar entre 2 equipos diferentes',1
		ROLLBACK;
	END

	UPDATE Juego
		SET Descripcion =(SELECT RTRIM(eq1.Nombre)+' vs '+RTRIM(eq2.Nombre) as Descripcion
		FROM Juego j, Equipo eq1, Equipo eq2,inserted
		WHERE j.Equipo1 = eq1.CodEquipo AND J.Equipo2 = eq2.CodEquipo
		AND J.codjuego = inserted.codjuego)
	
	FROM inserted
	WHERE Juego.codjuego = inserted.codjuego

END
