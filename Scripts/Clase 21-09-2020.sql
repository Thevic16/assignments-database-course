SELECT DISTINCT Employees.EmployeeID, Employees.FirstName, Employees.LastName, Employees.Title 
FROM Orders , Employees
WHERE OrderDate BETWEEN '1996-07-05' AND '1996-07-15' 
AND Orders.EmployeeID = Employees.EmployeeID
ORDER BY EmployeeID desc 

SELECT DISTINCT Employees.EmployeeID, Employees.FirstName, Employees.LastName, Employees.Title 
FROM Orders , Employees
WHERE OrderDate BETWEEN '1996-07-05' AND '1996-07-15' 
AND Orders.EmployeeID = Employees.EmployeeID
ORDER BY EmployeeID asc 

SELECT DISTINCT Employees.EmployeeID, Employees.FirstName, Employees.LastName, Employees.Title 
FROM Orders , Employees
WHERE OrderDate BETWEEN '1996-07-05' AND '1996-07-15' 
AND Orders.EmployeeID = Employees.EmployeeID
ORDER BY 3 desc

SELECT DISTINCT Employees.EmployeeID, Employees.FirstName, Employees.LastName, Employees.Title 
FROM Orders , Employees
WHERE OrderDate BETWEEN '1996-07-05' AND '1996-07-15' 
AND Orders.EmployeeID = Employees.EmployeeID
ORDER BY 1 asc

SELECT  Employees.EmployeeID, Employees.FirstName, Employees.LastName, Employees.Title, count(Orders.OrderID) as [Total Ordenes]
FROM Orders , Employees
WHERE OrderDate BETWEEN '1996-07-05' AND '1996-07-15' 
AND Orders.EmployeeID = Employees.EmployeeID
GROUP BY Employees.EmployeeID, Employees.FirstName, Employees.LastName, Employees.Title 
Having count(Orders.OrderID) > 1
