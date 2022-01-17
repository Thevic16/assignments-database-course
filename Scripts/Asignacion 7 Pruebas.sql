DECLARE @Concadenar varchar(50) = 'Hola mundo',  @texto nchar(50) = ' Manolo'

PRINT @Concadenar

SET @Concadenar =  @Concadenar + ' El pepe ' + @texto

PRINT @Concadenar


SELECT Dia, HoraInicial,HoraFinal
FROM GrupoHorario
WHERE CodPeriodoAcad = '201620172' AND CodAsignatura = 'ISC484T' AND NumGrupo = '001'
ORDER BY HoraInicial ASC , HoraFinal DESC



SELECT Nombre
FROM DiaSemana
WHERE Dia = 1
 

DECLARE @Time time = '12:00:00'
SELECT @Time

SELECT SUBSTRING(CONVERT(nchar, @Time, 8), 1, 2)

EXEC [dbo].[getHorario] @CodPeridoAcad = '201620172',@CodAsignatura= 'ISC484T',@NumGrupo = '001'


SELECT Dia, HoraInicial,HoraFinal
FROM GrupoHorario
WHERE CodPeriodoAcad = '201620172' AND CodAsignatura = 'ISC484T' AND NumGrupo = '001'
ORDER BY HoraInicial ASC , HoraFinal DESC


SELECT *
FROM Grupo

SELECT *
FROM GrupoHorario

EXEC [dbo].[getHorario] @CodPeridoAcad = '201620172',@CodAsignatura= 'ITT480T',@NumGrupo = '002'

EXEC [dbo].[getHorario] @CodPeridoAcad = '201620172',@CodAsignatura= 'ILL220T',@NumGrupo = '003'


UPDATE GrupoHorario
SET HoraInicial = '10:00:01', HoraFinal = '13:00:00'
WHERE CodPeriodoAcad = '201620172' AND CodAsignatura = 'ILL220T' AND NumGrupo = '003' AND HoraInicial = '10:00:00'

BEGIN TRANSACTION;
	DELETE FROM GrupoHorario
ROLLBACK;  