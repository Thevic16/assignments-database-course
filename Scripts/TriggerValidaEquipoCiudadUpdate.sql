USE [BasketBall2]
GO
/****** Object:  Trigger [dbo].[IT_ValEquipoCiudad]    Script Date: 2/10/2020 11:54:01 p. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		Victor Gomez
-- Create date: 2-10-2020
-- Description:	Trigger de insert para controolar un equipo por ciudad
-- =============================================
CREATE TRIGGER [dbo].[UT_ValEquipoCiudad] 
   ON  [dbo].[Equipo] 
   AFTER UPDATE
AS 
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    -- Insert statements for trigger here
	IF(SELECT COUNT(*)
		FROM inserted I,Equipo E
		WHERE I.CodCiudad = E.CodCiudad) > 1

	BEGIN
		THROW 60200,'No puede agredar mas de un equipo a una ciudad',1;
	END
END