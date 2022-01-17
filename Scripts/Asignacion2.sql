/*1. Obtener el nombre y apellido de los empleados con su t�tulo de puesto de trabajo y 
la casaeditora para la que trabaja.*/

SELECT employee.fname,employee.lname,jobs.job_desc,publishers.pub_name
FROM employee,jobs,publishers
WHERE employee.job_id = jobs.job_id and employee.pub_id = publishers.pub_id

/*2. Obtener el nombre, el tipo, casa editorial de los t�tulos, sin repetici�n, que han sido vendidos de
contado (�On invoice�).*/


SELECT DISTINCT titles.title,titles.type,publishers.pub_name
FROM titles,publishers,sales
WHERE titles.pub_id = publishers.pub_id and titles.title_id = sales.title_id and sales.payterms = 'On invoice'


/*3. Obtener el nombre y casa editora de los t�tulos que se han vendido m�s de 2 veces.*/

SELECT titles.title,publishers.pub_name
FROM titles,publishers,sales
WHERE titles.pub_id = publishers.pub_id and titles.title_id = sales.title_id
Group by titles.title,publishers.pub_name
Having Count(sales.title_id) > 2


/*4. Obtener nombre del t�tulo, tipo del t�tulo, precio del t�tulo, nombre completo del autor, tel�fono
del autor, ciudad de procedencia del autor, de la relaci�n t�tulo y autor.*/

SELECT titles.title,titles.type,titles.price,authors.au_fname,authors.au_lname,authors.phone,authors.city
FROM titles,titleauthor,authors
WHERE titles.title_id = titleauthor.title_id and titleauthor.au_id = authors.au_id

/*5. Obtener las ventas de la tienda cuyo id es �7067�. Nombre de la tienda, t�tulo vendido, casa
editora, precio.*/


SELECT stores.stor_name,titles.title,publishers.pub_name,titles.price
FROM sales,stores,titles,publishers
WHERE sales.stor_id =7067 and sales.stor_id = stores.stor_id and sales.title_id = titles.title_id and titles.pub_id = publishers.pub_id





