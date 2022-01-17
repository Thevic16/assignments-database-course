SELECT * FROM asignatura

INSERT INTO asignatura(c�digo,nombre,cr�ditos,[horas te�ricas],[horas pr�cticas])
VALUES('ISC484P','Laboratorio de ISC484',1,0,2)

INSERT INTO asignatura(c�digo,nombre)
VALUES('ISC102T','ALGORITMOS Y PROGRAMACION')


SELECT asignatura.c�digo,'001',20,'8-0 LMI' 
FROM asignatura

SELECT * FROM grupo

INSERT INTO grupo
SELECT asignatura.c�digo,'001',20,'8-0 LMI' 
FROM asignatura

SELECT * FROM grupo

INSERT INTO grupo
VALUES('ICC101','001',20,NULL) -- Esta materia no se encuentra en asignatura Error. 

SELECT * FROM asignatura

INSERT INTO asignatura(c�digo,nombre)
VALUES('ICC101','EL TEOREMA DEL SUAFASON II')

INSERT INTO grupo
VALUES('ICC101','001',20,NULL) 

SELECT * FROM grupo

UPDATE asignatura
SET cr�ditos = 3, [horas te�ricas] = 3 , [horas pr�cticas] = 3
WHERE asignatura.c�digo = 'ICC101'

SELECT * FROM asignatura

SELECT * FROM asignatura,grupo
WHERE asignatura.c�digo = grupo.[c�digo de la asignatura]

BEGIN TRANSACTION
	DELETE FROM grupo
	WHERE grupo.[c�digo de la asignatura] = 'ISC102T'

	--ROLLBACK TRANSACTION 
	COMMIT TRANSACTION

SELECT * FROM grupo