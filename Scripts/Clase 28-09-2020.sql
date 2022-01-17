SELECT * FROM asignatura

INSERT INTO asignatura(código,nombre,créditos,[horas teóricas],[horas prácticas])
VALUES('ISC484P','Laboratorio de ISC484',1,0,2)

INSERT INTO asignatura(código,nombre)
VALUES('ISC102T','ALGORITMOS Y PROGRAMACION')


SELECT asignatura.código,'001',20,'8-0 LMI' 
FROM asignatura

SELECT * FROM grupo

INSERT INTO grupo
SELECT asignatura.código,'001',20,'8-0 LMI' 
FROM asignatura

SELECT * FROM grupo

INSERT INTO grupo
VALUES('ICC101','001',20,NULL) -- Esta materia no se encuentra en asignatura Error. 

SELECT * FROM asignatura

INSERT INTO asignatura(código,nombre)
VALUES('ICC101','EL TEOREMA DEL SUAFASON II')

INSERT INTO grupo
VALUES('ICC101','001',20,NULL) 

SELECT * FROM grupo

UPDATE asignatura
SET créditos = 3, [horas teóricas] = 3 , [horas prácticas] = 3
WHERE asignatura.código = 'ICC101'

SELECT * FROM asignatura

SELECT * FROM asignatura,grupo
WHERE asignatura.código = grupo.[código de la asignatura]

BEGIN TRANSACTION
	DELETE FROM grupo
	WHERE grupo.[código de la asignatura] = 'ISC102T'

	--ROLLBACK TRANSACTION 
	COMMIT TRANSACTION

SELECT * FROM grupo