USE [BasketBall2]
GO
/****** Object:  Trigger [dbo].[UpdateTrigEst]    Script Date: 13/10/2020 10:40:15 p. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		Víctor Gómez
-- Create date: 05-10-2020
-- Description:	Trigger Update, para verficar que solo el usuario que creo la fila
-- =============================================
ALTER TRIGGER [dbo].[UpdateTrigEst]  
   ON [dbo].[Estadistica] 
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
			UPDATE Estadistica
				SET Estadistica.Actividad = 'Modificado', Estadistica.fechahora = GETDATE()
				
				FROM inserted
				WHERE Estadistica.CodEstadistica = inserted.CodEstadistica
		END
	
	--Auditoria.
	IF ((SELECT COUNT(*) FROM inserted,deleted WHERE inserted.CodEstadistica = deleted.CodEstadistica) =0)
		BEGIN
			INSERT Auditoria
			VALUES('Estadistica','Modificando','CodEstadistica',GETDATE(),(suser_sname()))
		END

	IF ((SELECT COUNT(*) FROM inserted,deleted WHERE inserted.Descripcion = deleted.Descripcion) =0)
		BEGIN
			INSERT Auditoria
			VALUES('Estadistica','Modificando','Descripcion',GETDATE(),(suser_sname()))
		END

	IF ((SELECT COUNT(*) FROM inserted,deleted WHERE inserted.Valor = deleted.Valor) =0)
		BEGIN
			INSERT Auditoria
			VALUES('Estadistica','Modificando','Valor',GETDATE(),(suser_sname()))
		END
END
