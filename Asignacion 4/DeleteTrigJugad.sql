USE [BasketBall2]
GO
/****** Object:  Trigger [dbo].[DeleteTrigJugad]    Script Date: 13/10/2020 10:47:52 p. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		Víctor Gómez
-- Create date: 11-10-2020
-- Description:	Trigger para auditoria Eliminado
-- =============================================
ALTER TRIGGER [dbo].[DeleteTrigJugad] 
   ON  [dbo].[Jugador] 
   AFTER DELETE
AS 
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    -- Insert statements for trigger here
	IF( (SELECT COUNT(*) FROM deleted WHERE SYSTEM_USER != deleted.Usuario) > 0)
		BEGIN
			THROW 70001,'Usted no esta autorizado para modificar este registro.',1
			ROLLBACK;
		END

	INSERT Auditoria
	VALUES('Jugador','Eliminando','No Aplica',GETDATE(),(suser_sname()))

END
