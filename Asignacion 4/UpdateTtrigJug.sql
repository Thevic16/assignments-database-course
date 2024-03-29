USE [BasketBall2]
GO
/****** Object:  Trigger [dbo].[UpdateTtrigJug]    Script Date: 13/10/2020 10:46:28 p. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		Víctor Gómez
-- Create date: 05-10-2020
-- Description:	Trigger Update, para verficar que solo el usuario que creo la fila
-- =============================================
ALTER TRIGGER [dbo].[UpdateTtrigJug]  
   ON [dbo].[Juego]
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
			UPDATE Juego
				SET Juego.Actividad = 'Modificado', Juego.fechahora = GETDATE()
				
				FROM inserted
				WHERE Juego.codjuego = inserted.CodJuego  
		END

	--Auditoria.
	IF ((SELECT COUNT(*) FROM inserted,deleted WHERE inserted.CodJuego = deleted.CodJuego) =0)
		BEGIN
			INSERT Auditoria
			VALUES('Juego','Modificando','CodJuego',GETDATE(),(suser_sname()))
		END
	
	IF ((SELECT COUNT(*) FROM inserted INNER JOIN deleted ON inserted.Descripcion = deleted.Descripcion) =0)
		BEGIN
			INSERT Auditoria
			VALUES('Juego','Modificando','Descripcion',GETDATE(),(suser_sname()))
		END
	
	IF ((SELECT COUNT(*) FROM inserted,deleted WHERE inserted.Equipo1 = deleted.Equipo1) =0)
		BEGIN
			INSERT Auditoria
			VALUES('Juego','Modificando','Equipo1',GETDATE(),(suser_sname()))
		END

	IF ((SELECT COUNT(*) FROM inserted,deleted WHERE inserted.Equipo2 = deleted.Equipo2) =0)
		BEGIN
			INSERT Auditoria
			VALUES('Juego','Modificando','Equipo2',GETDATE(),(suser_sname()))
		END

	IF ((SELECT COUNT(*) FROM inserted,deleted WHERE inserted.Fecha = deleted.Fecha) =0)
		BEGIN
			INSERT Auditoria
			VALUES('Juego','Modificando','Fecha',GETDATE(),(suser_sname()))
		END

END
