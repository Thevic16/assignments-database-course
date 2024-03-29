USE [BasketBall2]
GO
/****** Object:  Trigger [dbo].[InsertTrigEstJ]    Script Date: 13/10/2020 10:42:23 p. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		Víctor Gómez
-- Create date: 11-10-2020
-- Description:	Trigger para auditoria insecion
-- =============================================
ALTER TRIGGER [dbo].[InsertTrigEstJ] 
   ON  [dbo].[EstadisticaJuego] 
   AFTER INSERT
AS 
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    -- Insert statements for trigger here
	INSERT Auditoria
	VALUES('EstadisticaJuego','Insertando','No Aplica',GETDATE(),(suser_sname()))

END
