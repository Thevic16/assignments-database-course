USE [BasketBall2]
GO
/****** Object:  Trigger [dbo].[UpdateTrigEqu]    Script Date: 13/10/2020 10:37:20 p. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		Víctor Gómez
-- Create date: 05-10-2020
-- Description:	Trigger Update, para verficar que solo el usuario que creo la fila
-- =============================================
ALTER TRIGGER [dbo].[UpdateTrigEqu]  
   ON [dbo].[Equipo] 
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
			UPDATE Equipo
				SET Equipo.Actividad = 'Modificado', Equipo.fechahora = GETDATE()
				
				FROM inserted
				WHERE Equipo.CodEquipo = inserted.CodEquipo
		END

		--Auditoria.

	IF ((SELECT COUNT(*) FROM inserted,deleted WHERE inserted.CodEquipo = deleted.CodEquipo ) =0)
		BEGIN
			INSERT Auditoria
			VALUES('Equipo','Modificando','CodEquipo',GETDATE(),(suser_sname()))
		END

	IF ((SELECT COUNT(*) FROM inserted,deleted WHERE inserted.Nombre = deleted.Nombre ) =0)
		BEGIN
			INSERT Auditoria
			VALUES('Equipo','Modificando','Nombre',GETDATE(),(suser_sname()))
		END

	IF ((SELECT COUNT(*) FROM inserted,deleted WHERE inserted.CodCiudad = deleted.CodCiudad ) =0)
		BEGIN
			INSERT Auditoria
			VALUES('Equipo','Modificando','CodCiudad',GETDATE(),(suser_sname()))
		END

END
