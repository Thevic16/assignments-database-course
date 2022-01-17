SELECT dbo.Equipo.Nombre,dbo.Ciudad.Nombre AS NombreCiudad
FROM dbo.Ciudad
INNER JOIN dbo.Equipo ON dbo.Ciudad.CodCiudad = dbo.Equipo.CodCiudad


SELECT dbo.Equipo.Nombre,dbo.Ciudad.Nombre AS NombreCiudad
FROM dbo.Ciudad,dbo.Equipo
WHERE dbo.Ciudad.CodCiudad = dbo.Equipo.CodCiudad

--Realizando un select del view.

SELECT *
FROM dbo.View_EquipoCiudad

SELECT *
FROM dbo.View_Equipos_Juego

--Generar query para usarlo en el siguiente view. 
SELECT TOP 1 J.codjuego,J.Equipo1,J.Equipo2,EJ.CodJugador, SUM(EJ.Cantidad*E.Valor) AS ValorTotal
	FROM EstadisticaJuego EJ, Estadistica E, Juego J
  WHERE J.codjuego = EJ.CodJuego AND E.CodEstadistica IN ('01','02','09')
	AND E.CodEstadistica = EJ.CodEstadistica
	AND J.codjuego = '05'
GROUP BY J.codjuego,J.Equipo1,J.Equipo2,EJ.CodJugador
ORDER BY ValorTotal Desc

--Para el view. 
SELECT TOP 1 J.codjuego,J.Equipo1,J.Equipo2,EJ.CodJugador, SUM(EJ.Cantidad*E.Valor) AS ValorTotal
	FROM EstadisticaJuego EJ, Estadistica E, Juego J
  WHERE J.codjuego = EJ.CodJuego AND E.CodEstadistica IN ('01','02','09')
	AND E.CodEstadistica = EJ.CodEstadistica
GROUP BY J.codjuego,J.Equipo1,J.Equipo2,EJ.CodJugador


SELECT *
FROM dbo.View_PuntosXJuego AS PXJ
WHERE PXJ.codjuego = '05'
ORDER BY ValorTotal DESC

--Maximo anotador del torneo
SELECT TOP 1 *
FROM dbo.View_PuntosXJuego AS PXJ
ORDER BY ValorTotal DESC


--Usando las funciones

--Escalar
SELECT CodJugador,dbo.FormatName(nombre1,nombre2,Apellido1,Apellido2) as [Nombre Completo],CiudadNacim
FROM Jugador


--Funcion que retorna una tabla.

SELECT * 
FROM [dbo].[EquiposCiudad]('%')