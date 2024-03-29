USE [BasketBall2]
GO
/****** Object:  Trigger [dbo].[UpdateTrigJugad]    Script Date: 13/10/2020 10:49:22 p. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		Víctor Gómez
-- Create date: 05-10-2020
-- Description:	Trigger Update, para verficar que solo el usuario que creo la fila
-- =============================================
ALTER TRIGGER [dbo].[UpdateTrigJugad] 
   ON [dbo].[Jugador]
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
			UPDATE Jugador
				SET Jugador.Actividad = 'Modificado', Jugador.fechahora = GETDATE()
				
				FROM inserted
				WHERE Jugador.CodJugador = inserted.CodJugador  
		END

	--Auditoria.
	IF ((SELECT COUNT(*) FROM inserted,deleted WHERE inserted.CodJugador = deleted.CodJugador) =0)
		BEGIN
			INSERT Auditoria
			VALUES('Jugador','Modificando','CodJugador',GETDATE(),(suser_sname()))
		END

	IF ((SELECT COUNT(*) FROM inserted,deleted WHERE inserted.Nombre1 = deleted.Nombre1) =0)
		BEGIN
			INSERT Auditoria
			VALUES('Jugador','Modificando','Nombre1',GETDATE(),(suser_sname()))
		END

	IF ((SELECT COUNT(*) FROM inserted,deleted WHERE inserted.Nombre2 = deleted.Nombre2) =0)
		BEGIN
			INSERT Auditoria
			VALUES('Jugador','Modificando','Nombre2',GETDATE(),(suser_sname()))
		END

	IF ((SELECT COUNT(*) FROM inserted,deleted WHERE inserted.Apellido1 = deleted.Apellido1) =0)
		BEGIN
			INSERT Auditoria
			VALUES('Jugador','Modificando','Apellido1',GETDATE(),(suser_sname()))
		END

	IF ((SELECT COUNT(*) FROM inserted,deleted WHERE inserted.Apellido2 = deleted.Apellido2) =0)
		BEGIN
			INSERT Auditoria
			VALUES('Jugador','Modificando','Apellido2',GETDATE(),(suser_sname()))
		END

	IF ((SELECT COUNT(*) FROM inserted,deleted WHERE inserted.CiudadNacim = deleted.CiudadNacim) =0)
		BEGIN
			INSERT Auditoria
			VALUES('Jugador','Modificando','CiudadNacim',GETDATE(),(suser_sname()))
		END

	IF ((SELECT COUNT(*) FROM inserted,deleted WHERE inserted.FechaNacim = deleted.FechaNacim) =0)
		BEGIN
			INSERT Auditoria
			VALUES('Jugador','Modificando','FechaNacim',GETDATE(),(suser_sname()))
		END

	IF ((SELECT COUNT(*) FROM inserted,deleted WHERE inserted.Numero = deleted.Numero) =0)
		BEGIN
			INSERT Auditoria
			VALUES('Jugador','Modificando','Numero',GETDATE(),(suser_sname()))
		END

	IF ((SELECT COUNT(*) FROM inserted,deleted WHERE inserted.CodEquipo = deleted.CodEquipo) =0)
		BEGIN
			INSERT Auditoria
			VALUES('Jugador','Modificando','CodEquipo',GETDATE(),(suser_sname()))
		END


END
