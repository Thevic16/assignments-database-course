/*1. Muestre los equipos por ciudades (código de la ciudad, nombre de la ciudad y
nombre del equipo) ordenados por nombre de ciudad ascendentemente, nombre
de equipo descendentemente.*/

SELECT C.CodCiudad,C.Nombre,E.Nombre
FROM Ciudad C, Equipo E
WHERE C.CodCiudad = E.CodCiudad
ORDER BY C.CodCiudad ASC, E.Nombre DESC


/*2. Muestre los miembros (nombre1, apellido1, numero) de los equipos de la ciudad
de Santiago (‘ST’), ordenado por apellido1 ascendentemente.*/

SELECT J.Nombre1,J.Apellido1,J.Numero
FROM Equipo E,jugador J
WHERE E.CodEquipo = J.CodEquipo AND E.CodCiudad = 'ST'
ORDER BY J.Apellido1 ASC

/*3. Muestre los juegos jugados en lo que va de año, indicando los equipos
participantes (código de juego, descripción de juego, código equipo 1 y código del
equipo 2).*/

SELECT J.codjuego,J.Descripcion,J.Equipo1,J.Equipo2
FROM Juego J
WHERE J.Fecha BETWEEN '2017-01-01' AND '2017-12-31'

/*4. Muestre el total de puntos por jugador para el juego ‘05’. (código del jugador,
nombre del jugador, apellido del jugador y el total de puntos anotados).*/

SELECT J.CodJugador,J.Nombre1+' '+J.Nombre2 AS [Nombre del jugador],
J.Apellido1+' '+J.Apellido2 AS [Apellido del jugador], SUM(E.Valor*EJ.Cantidad) AS [Total de puntos]
FROM Jugador J, EstadisticaJuego EJ, Estadistica E
WHERE J.CodJugador = EJ.CodJugador AND E.CodEstadistica = EJ.CodEstadistica
AND EJ.CodEstadistica in ('01','02','09') AND EJ.CodJuego = '05'
GROUP BY J.CodJugador,J.Nombre1+' '+J.Nombre2 ,J.Apellido1+' '+J.Apellido2 


/*5. Muestre el jugador (nombre1, apellido1, numero) que obtuvo mayor número de
asistencias en el juego ‘09’.*/

SELECT TOP 1 J.Nombre1,J.Apellido1,J.Numero
FROM Jugador J, EstadisticaJuego EJ, Estadistica E
WHERE J.CodJugador = EJ.CodJugador AND E.CodEstadistica = EJ.CodEstadistica
AND EJ.CodEstadistica = '03' AND Ej.CodJuego = '09'
GROUP BY J.Nombre1,J.Apellido1,J.Numero 
ORDER BY SUM(E.Valor*EJ.Cantidad) DESC

/*6. Muestre el nombre1, apellido1, numero y cantidad de asistencias de los jugadores
con más de 3 asistencias en el juego ‘06’.*/

SELECT J.Nombre1,J.Apellido1,J.Numero, SUM(E.Valor*EJ.Cantidad) AS [Cantidad de asistencias]
FROM Jugador J, EstadisticaJuego EJ, Estadistica E
WHERE J.CodJugador = EJ.CodJugador AND E.CodEstadistica = EJ.CodEstadistica
AND EJ.CodEstadistica = '03' AND Ej.CodJuego = '06'
GROUP BY J.Nombre1,J.Apellido1,J.Numero 
HAVING SUM(E.Valor*EJ.Cantidad) > 3

/*7. Muestre nombre del equipo, nombre1, apellido1 de los jugadores que nacieron
en la ciudad del equipo para que juegan.*/

SELECT E.Nombre as [Nombre equipo],J.Nombre1,J.Apellido1
FROM Equipo E, Jugador J
WHERE E.CodEquipo = J.CodEquipo AND E.CodCiudad = J.CiudadNacim

/*8. Muestre nombre del equipo, nombre1, apellido1 de los jugadores que no
anotaron en el juego ‘06’, pero dieron 3 o más asistencias.*/

SELECT Equ.Nombre,Jug.Nombre1,Jug.Apellido1
FROM Jugador Jug ,EstadisticaJuego EJ, Estadistica Est , Equipo Equ
WHERE Jug.CodJugador = EJ.CodJugador AND Est.CodEstadistica = EJ.CodEstadistica AND
Jug.CodEquipo = Equ.CodEquipo AND EJ.CodJuego = '06' AND 
NOT EXISTS (SELECT * FROM  EstadisticaJuego EJ1 WHERE EJ1.CodEstadistica  
in ('01','02','09') AND EJ1.CodJuego = '06' AND EJ1.CodJugador = Jug.CodJugador) 
AND EJ.CodEstadistica = '03' AND (EJ.Cantidad*Est.Valor)>=3


/*9. Muestre nombre del equipo, nombre1, apellido1 de los jugadores que hicieron un
triple doble (10 o más asistencias, 10 o más puntos, 10 o más rebotes en un juego)
en 3 juegos o más.*/

SELECT Equ.Nombre, TabAsist.Nombre1,TabAsist.Apellido1
FROM (SELECT Jug.Nombre1,Jug.Apellido1,Jug.CodJugador,EJ.CodJuego,Jug.CodEquipo
FROM Jugador Jug, EstadisticaJuego EJ, Estadistica Est
WHERE Jug.CodJugador = EJ.CodJugador AND EJ.CodEstadistica = Est.CodEstadistica
AND EJ.CodEstadistica = '03' AND (Est.Valor*EJ.Cantidad) >= 10) AS TabAsist,

(SELECT Jug.Nombre1,Jug.Apellido1,Jug.CodJugador,EJ.CodJuego,Jug.CodEquipo
FROM Jugador Jug, EstadisticaJuego EJ, Estadistica Est
WHERE Jug.CodJugador = EJ.CodJugador AND EJ.CodEstadistica = Est.CodEstadistica
AND EJ.CodEstadistica IN ('01','02','09')
GROUP BY Jug.Nombre1,Jug.Apellido1,Jug.CodJugador,EJ.CodJuego,Jug.CodEquipo
HAVING SUM(Est.Valor*EJ.Cantidad) >= 10) AS TabPuntos,

(SELECT Jug.Nombre1,Jug.Apellido1,Jug.CodJugador,EJ.CodJuego,Jug.CodEquipo
FROM Jugador Jug, EstadisticaJuego EJ, Estadistica Est
WHERE Jug.CodJugador = EJ.CodJugador AND EJ.CodEstadistica = Est.CodEstadistica
AND EJ.CodEstadistica = '04' AND (Est.Valor*EJ.Cantidad) >= 10) AS TabRebotes,

Equipo Equ

WHERE TabAsist.CodJugador = TabPuntos.CodJugador AND TabAsist.CodJugador = TabRebotes.CodJugador 
AND TabAsist.CodJuego = TabPuntos.CodJuego AND TabAsist.CodJuego = TabRebotes.CodJuego 
AND TabAsist.CodEquipo = Equ.CodEquipo

GROUP BY Equ.Nombre, TabAsist.Nombre1,TabAsist.Apellido1
HAVING COUNT(TabAsist.CodJuego) >= 3


--Tabla asistencias
/*
SELECT Jug.Nombre1,Jug.Apellido1,Jug.CodJugador,EJ.CodJuego, (Est.Valor*EJ.Cantidad) AS [Total Asistencias]
FROM Jugador Jug, EstadisticaJuego EJ, Estadistica Est
WHERE Jug.CodJugador = EJ.CodJugador AND EJ.CodEstadistica = Est.CodEstadistica
AND EJ.CodEstadistica = '03' AND (Est.Valor*EJ.Cantidad) >= 10
*/

-- Tabla Puntos
/*
SELECT Jug.Nombre1,Jug.Apellido1,Jug.CodJugador,EJ.CodJuego, SUM(Est.Valor*EJ.Cantidad) AS [Total Puntos] 
FROM Jugador Jug, EstadisticaJuego EJ, Estadistica Est
WHERE Jug.CodJugador = EJ.CodJugador AND EJ.CodEstadistica = Est.CodEstadistica
AND EJ.CodEstadistica IN ('01','02','09')
GROUP BY Jug.Nombre1,Jug.Apellido1,Jug.CodJugador,EJ.CodJuego
HAVING SUM(Est.Valor*EJ.Cantidad) >= 10
*/

-- Tabla Rebotes
/*
SELECT Jug.Nombre1,Jug.Apellido1,Jug.CodJugador,EJ.CodJuego, (Est.Valor*EJ.Cantidad) AS [Total Rebotes] 
FROM Jugador Jug, EstadisticaJuego EJ, Estadistica Est
WHERE Jug.CodJugador = EJ.CodJugador AND EJ.CodEstadistica = Est.CodEstadistica
AND EJ.CodEstadistica = '04' AND (Est.Valor*EJ.Cantidad) >= 10
*/

/*10. Muestre nombre del equipo, nombre1, apellido1, promedio de puntos por
partido, de los primeros 10 jugadores con mejor promedio de puntos por partido.*/

SELECT TOP 10 Equ.Nombre,Jug.Nombre1,Jug.Apellido1, SUM(Est.Valor*EJ.Cantidad)/TablJuegos.[Cantidad de juegos] AS [Promedio de puntos por part]
FROM Jugador Jug, EstadisticaJuego EJ, Estadistica Est ,Equipo Equ,

(SELECT Equipo.CodEquipo, COUNT(Equipo.CodEquipo) AS [Cantidad de juegos]
FROM Juego ,Equipo WHERE Juego.Equipo1 = Equipo.CodEquipo OR Juego.Equipo2 = Equipo.CodEquipo
GROUP BY Equipo.CodEquipo) AS TablJuegos

WHERE Jug.CodJugador = EJ.CodJugador AND Jug.CodEquipo = Equ.CodEquipo AND TablJuegos.CodEquipo = Jug.CodEquipo
AND EJ.CodEstadistica = Est.CodEstadistica AND EJ.CodEstadistica IN ('01','02','09') 
GROUP BY Equ.Nombre,Jug.Nombre1,Jug.Apellido1,TablJuegos.[Cantidad de juegos]
ORDER BY [Promedio de puntos por part] DESC


--Tabla Juegos.
/*
SELECT Equipo.CodEquipo, COUNT(Equipo.CodEquipo) AS [Cantidad de juegos]
FROM Juego ,Equipo
WHERE Juego.Equipo1 = Equipo.CodEquipo OR Juego.Equipo2 = Equipo.CodEquipo
GROUP BY Equipo.CodEquipo
*/
