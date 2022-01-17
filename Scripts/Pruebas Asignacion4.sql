SELECT * FROM Ciudad


UPDATE Ciudad
	SET Ciudad.Nombre = 'Sosua'
	WHERE Ciudad.CodCiudad = '00001'


INSERT Ciudad(CodCiudad,Nombre)
	VALUES('NY','NEW YORK')

UPDATE Ciudad
	SET Ciudad.Nombre = 'New York'
	WHERE Ciudad.CodCiudad = 'NY'

INSERT Ciudad(CodCiudad,Nombre)
	VALUES('LR','La Romana')

UPDATE Ciudad
	SET Ciudad.Nombre = '-La Romana'
	WHERE Ciudad.CodCiudad = 'LR'


SELECT * FROM Equipo


INSERT Equipo(CodEquipo,Nombre,CodCiudad)
	VALUES('00014','Clippers','LR')


UPDATE Equipo
	SET Nombre = 'Clippers'
	WHERE CodEquipo = '00014'

SELECT * FROM Estadistica

INSERT Estadistica(CodEstadistica,Descripcion,Valor)
	VALUES('10','flopping',1)

UPDATE Estadistica
	SET Valor = 2
	WHERE CodEstadistica = '10'

SELECT * FROM EstadisticaJuego

INSERT EstadisticaJuego(CodJuego,CodEstadistica,CodJugador,Cantidad)
	VALUES('15','10','00011',4)

UPDATE EstadisticaJuego
	SET CodJuego = 15
	WHERE CodJuego = '15' AND CodEstadistica = '10' AND CodJugador = '00011'

SELECT * FROM Juego


INSERT Juego(codjuego,Equipo1,Equipo2)
VALUES(23,'00006','00003')

UPDATE Juego
	SET Descripcion = 'Yankess vs Boston'
	WHERE codjuego = '23'

SELECT * FROM Jugador

INSERT Jugador(codjugador,Nombre1,Apellido1)
VALUES('00031','Victor','Gomez')

UPDATE Jugador
	SET Nombre2 = 'Jhoan'
	WHERE CodJugador = '00031'


SELECT *
FROM Auditoria

SELECT *
FROM Ciudad

DELETE 
FROM Ciudad
WHERE CodCiudad = 'MIA'

INSERT INTO Ciudad(CodCiudad,Nombre)
VALUES('MIA','MIAMI')

UPDATE Ciudad
SET Ciudad.Nombre = '--La Romana'
WHERE Ciudad.CodCiudad = 'LR'

SELECT *
FROM Equipo

DELETE 
FROM Equipo
WHERE CodEquipo = '00015'

INSERT INTO Equipo(CodEquipo,CodCiudad)
VALUES('00016','LR')


UPDATE Equipo
SET Equipo.CodEquipo = '00015',Equipo.Nombre = '-Clippers'
WHERE Equipo.CodEquipo = '00014'

SELECT *
FROM Estadistica

INSERT Estadistica(CodEstadistica,Valor)
VALUES('12',0)

DELETE 
FROM Estadistica
WHERE CodEstadistica = '12'

UPDATE Estadistica
SET Descripcion = 'Flopping',Valor = 5
WHERE CodEstadistica = '10'


INSERT Estadistica(CodEstadistica,Descripcion,Valor)
VALUES('11','Minutos',2)

UPDATE Estadistica
SET  Valor = 1
WHERE CodEstadistica = '11'

SELECT *
FROM Auditoria

SELECT *
FROM EstadisticaJuego

INSERT EstadisticaJuego(CodJuego,CodEstadistica,CodJugador,Cantidad)
VALUES('15','10','00010',1)

UPDATE EstadisticaJuego
SET  Cantidad = 15
WHERE CodEstadistica = '10' AND CodJuego = '15' AND CodJugador = '00011'

DELETE 
FROM EstadisticaJuego
WHERE CodJuego = '15' AND CodEstadistica = '10' AND CodJugador = '00010'

SELECT *
FROM Juego

INSERT INTO Juego(codjuego,Descripcion)
VALUES('26   ','Lackers vs Heat1 GAME 7       ')

DELETE 
FROM Juego
WHERE CodJuego = '26' 

UPDATE Juego
SET  Equipo1 = '00003',Equipo2 = '00002', Fecha = GETDATE(),Descripcion = 'Lackers vs Heat1 GAME 6       '
WHERE codjuego = '15   '

UPDATE Juego
SET Equipo2 = '00002',Equipo1 = '00003',Fecha = GETDATE()
WHERE codjuego = '20'


SELECT *
FROM Jugador

SELECT *
FROM Equipo

INSERT INTO Jugador(CodJugador,CodEquipo)
VALUES('00033','00016')

UPDATE Jugador
SET Nombre1 = 'Pedro', Nombre2 = 'Manuel', Apellido1 = 'Gomez', Apellido2 = 'Perez', CiudadNacim = 'SFM' , FechaNacim = GETDATE() , Numero ='016' , CodEquipo ='00001' 
WHERE CodJugador = '00031'


DELETE 
FROM Jugador
WHERE CodJugador = '00031'

SELECT *
FROM Auditoria