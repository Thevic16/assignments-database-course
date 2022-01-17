-- Realice las funciones:
/*1. PeriodoActual: Que retorne en una cadena de caracteres el Período Actual. Esto partiendo de la fechainicio y FechaFin del Período. */
SELECT * FROM [Periodo Academico]


INSERT [Periodo Academico]([Cod PeriodoAcad],Descripcion,FechaInicio,FechaFin,FechaLimitePago,FechaLimitePrematricula,FechaLimiteRetiro,FechaLimitePublicacion)
VALUES('120202021','Cuatrimestre agosto-diciembre','2020-08-24','2020-12-07','2020-09-23','2020-11-18','2020-11-24','2020-12-07')

INSERT [Periodo Academico]([Cod PeriodoAcad],Descripcion,FechaInicio,FechaFin,FechaLimitePago,FechaLimitePrematricula,FechaLimiteRetiro,FechaLimitePublicacion)
VALUES('120192020','Cuatrimestre agosto-diciembre','2019-08-24','2019-12-07','2019-09-23','2019-11-18','2019-11-24','2019-12-07')

SELECT [dbo].PeriodoActual() AS [Cod Periodo Academico]


/*2. EsPeriodoClases: Que retorne 1 si estamos en período de clases para el período actual y 0 si no estamos en período de clases para el período actual.*/
SELECT COUNT([Periodo Academico].[Cod PeriodoAcad])
	FROM [Periodo Academico]
WHERE GETDATE() >= [Periodo Academico].FechaInicioClases  AND GETDATE() <= [Periodo Academico].FechaFinClases AND [Periodo Academico].[Cod PeriodoAcad] = [dbo].PeriodoActual()

SELECT [dbo].EsPeriodoClases() AS [EsPeriodoClases]


/*3. OcupacionGrupo: Que retorne la cantidad de estudiantes inscritos en un grupo.*/

SELECT *
FROM Asignatura

INSERT Asignatura
VALUES('ICC202','Algoritmo para novatos I',4,2,2)

INSERT Asignatura
VALUES('ITT478','REDES INFERENCIALES 2',4,2,2)

INSERT Asignatura
VALUES('ITT280','Estadistica I',4,2,2)

INSERT Asignatura
VALUES('ITT570','Electromagnetismo',4,2,2)

INSERT Grupo
VALUES('120192020','ICC202','001',21,'10-12 LMI')

INSERT Grupo
VALUES('120202021','ITT478','002',16,'8-10 LMI')

SELECT COUNT(Matricula)
FROM Inscripcion
WHERE NumGrupo = '003'
GROUP BY (NumGrupo)

SELECT *
FROM Grupo

SELECT *
FROM Inscripcion

SELECT [dbo].OcupacionGrupo('120192020','ICC202','001') AS OcupacionGrupo

SELECT [dbo].OcupacionGrupo('120202021','ITT478','002') AS OcupacionGrupo

SELECT [dbo].OcupacionGrupo('120202021','ITT280','003') AS OcupacionGrupo

SELECT [dbo].OcupacionGrupo('120202021','ITT570','004') AS OcupacionGrupo


--Realice los views:
/*1. Grupos del Período Actual: Que liste los grupos para el período actual. Debe indicar los
campos:
CodPeriodoAcad,
CodAsignatura,
NumGrupo,
CupoGrupo,
Ocupación,
Disponibilidad, Horario.*/


--Pruebas para realizar la funcion.
SELECT P.[Cod PeriodoAcad],G.[Cod Asignatura],G.NumGrupo,G.CupoGrupo,[dbo].OcupacionGrupo(G.CodPeridoAcad,G.[Cod Asignatura],G.NumGrupo) AS Ocupación,(G.CupoGrupo - [dbo].OcupacionGrupo(G.CodPeridoAcad,G.[Cod Asignatura],G.NumGrupo)) AS Disponibilidad,G.Horario
FROM [Periodo Academico] P
INNER JOIN Grupo G ON P.[Cod PeriodoAcad] = G.CodPeridoAcad
WHERE P.[Cod PeriodoAcad] =  [dbo].PeriodoActual()       

SELECT *
FROM [dbo].View_Grup_Perid_Act AS GrupoPeriodoActual

/*2. Grupos Inscritos del Estudiante: Que liste los grupos que un estudiante tiene inscritos por
período. Debe incluir los campos: codperiodoacad, matricula, codasignatura, numgrupo,
horario.*/

INSERT Estudiante(matrícula,nombre1,apellido1)
VALUES('20171408','Victor','Gomez')

INSERT Estudiante(matrícula,nombre1,apellido1)
VALUES('20181036','Victor','Gomez')

INSERT Estudiante(matrícula,nombre1,apellido1)
VALUES('20191418','Manolo','Justo')

--20171408
INSERT Inscripcion
VALUES('120192020','20171408','ICC202','001')

INSERT Inscripcion
VALUES('120202021','20171408','ITT280','003')

INSERT Inscripcion
VALUES('120202021','20171408','ITT478','002')

INSERT Inscripcion
VALUES('120202021','20171408','ITT570','004')

--20181036
INSERT Inscripcion
VALUES('120192020','20181036','ICC202','001')

INSERT Inscripcion
VALUES('120202021','20181036','ITT280','003')

--20191418
INSERT Inscripcion
VALUES('120202021','20191418','ITT570','004')

INSERT Inscripcion
VALUES('120202021','20191418','ITT280','003')

INSERT Inscripcion
VALUES('120192020','20191418','ICC202','001')

SELECT *
FROM Estudiante

SELECT *
FROM Grupo

SELECT *
FROM Inscripcion


SELECT I.[código PeridoAcad],E.matrícula,I.[Cod Asignatura],I.NumGrupo,G.Horario
FROM Inscripcion I, Estudiante E, Grupo G
WHERE I.Matricula = E.matrícula AND I.[código PeridoAcad] = G.CodPeridoAcad AND I.[Cod Asignatura] = G.[Cod Asignatura] AND I.NumGrupo = G.NumGrupo

SELECT *
FROM dbo.View_Grup_InscEst AS GruposInscEst






