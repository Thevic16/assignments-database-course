SELECT * FROM Equipo

INSERT Equipo
VALUES ('00007','LA JOYA','ST')

SELECT *
FROM Ciudad C
WHERE NOT EXISTS (SELECT *
					FROM Equipo	E
					WHERE E.CodCiudad = C.CodCiudad)



INSERT Equipo
VALUES ('00008','lA bAHIA','LA')

UPDATE Equipo
SET CodCiudad = 'SFM'
WHERE CodEquipo ='00008'

UPDATE Equipo
SET CodCiudad = 'SC'
WHERE CodEquipo ='00008'

SELECT *
FROM Juego

INSERT Juego(codjuego,Equipo1,Equipo2)
VALUES ('16','00001','00001')

INSERT Juego(codjuego,Equipo1,Equipo2)
VALUES ('17','00002','00002')

SELECT *
FROM Juego
WHERE Equipo1 = Equipo2

SELECT RTRIM(eq1.Nombre)+' vs '+RTRIM(eq2.Nombre) as Descripcion
FROM Juego j, Equipo eq1, Equipo eq2
WHERE j.Equipo1 = eq1.CodEquipo AND J.Equipo2 = eq2.CodEquipo
AND J.codjuego = '01'

INSERT Juego(codjuego,Equipo1,Equipo2)
VALUES ('17','00001','00002')

INSERT Juego(codjuego,Descripcion,Equipo1,Equipo2)
VALUES ('20','El suafason','00004','00006')

SELECT *
FROM Juego

INSERT Equipo(CodEquipo,Nombre,CodCiudad)
VALUES ('00009','La Bahia','LA')

SELECT *
FROM Ciudad

INSERT INTO Ciudad(CodCiudad,Nombre)
VALUES ('LV','La Vega')
