USE [BasketBall2]
GO
/****** Object:  Trigger [dbo].[UpdateTrigEstJ]    Script Date: 13/10/2020 10:42:43 p. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		Víctor Gómez
-- Create date: 05-10-2020
-- Description:	Trigger Update, para verficar que solo el usuario que creo la fila
-- =============================================
ALTER TRIGGER [dbo].[UpdateTrigEstJ]  
   ON [dbo].[EstadisticaJuego] 
   AFTER UPDATE
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

	ELSE
		BEGIN
			UPDATE EstadisticaJuego
				SET EstadisticaJuego.Actividad = 'Modificado', EstadisticaJuego.fechahora = GETDATE()
				
				FROM inserted
				WHERE EstadisticaJuego.CodJuego = inserted.CodJuego AND 
				EstadisticaJuego.CodEstadistica = inserted.CodEstadistica AND 
				EstadisticaJuego.CodJuego = inserted.CodJuego
		END

	--Auditoria.
	IF ((SELECT COUNT(*) FROM inserted,deleted WHERE inserted.CodJuego = deleted.CodJuego) =0)
		BEGIN
			INSERT Auditoria
			VALUES('EstadisticaJuego','Modificando','CodJuego',GETDATE(),(suser_sname()))
		END

	IF ((SELECT COUNT(*) FROM inserted,deleted WHERE inserted.CodEstadistica = deleted.CodEstadistica) =0)
		BEGIN
			INSERT Auditoria
			VALUES('EstadisticaJuego','Modificando','CodEstadistica',GETDATE(),(suser_sname()))
		END

	IF ((SELECT COUNT(*) FROM inserted,deleted WHERE inserted.CodJugador = deleted.CodJugador) =0)
		BEGIN
			INSERT Auditoria
			VALUES('EstadisticaJuego','Modificando','CodJugador',GETDATE(),(suser_sname()))
		END

	IF ((SELECT COUNT(*) FROM inserted,deleted WHERE inserted.Cantidad = deleted.Cantidad) =0)
		BEGIN
			INSERT Auditoria
			VALUES('EstadisticaJuego','Modificando','Cantidad',GETDATE(),(suser_sname()))
		END

END
