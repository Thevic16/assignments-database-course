SELECT Employees.FirstName, Employees.LastName , Employees.Title, Employees.ReportsTo as "Reporta A"
FROM Employees

SELECT Empl.FirstName, Empl.LastName , Empl.Title, Jefes.FirstName+' '+Jefes.LastName as "Reporta A" , Jefes.EmployeeID as "Jefe ID" 
FROM Employees Empl , Employees Jefes
WHERE Empl.ReportsTo = Jefes.EmployeeID

SELECT O.OrderID, C.CompanyName,C.ContactName,O.OrderDate, E.FirstName+' '+E.LastName as "Empleado"
FROM Orders O, Employees E, Customers C
WHERE O.EmployeeID = E.EmployeeID AND O.CustomerID = C.CustomerID

SELECT O.OrderID,O.OrderDate, P.ProductName,(OD.Quantity * OD.UnitPrice * (1 - OD.Discount)) Subtotal
FROM [Order Details] OD, Orders O, Products P
WHERE OD.OrderID = O.OrderID AND P.ProductID = OD.ProductID
ORDER BY O.OrderID

SELECT O.OrderID, sum(OD.Quantity * OD.UnitPrice * (1 - OD.Discount)) Subtotal
FROM [Order Details] OD, Orders O, Products P
WHERE OD.OrderID = O.OrderID AND P.ProductID = OD.ProductID
GROUP BY O.OrderID
ORDER BY O.OrderID


SELECT O.OrderID, (OD.Quantity * OD.UnitPrice * (1 - OD.Discount)) Subtotal, Totalcost.Total
FROM [Order Details] OD, Orders O, Products P,

(SELECT O.OrderID, sum(OD.Quantity * OD.UnitPrice * (1 - OD.Discount)) Total
FROM [Order Details] OD, Orders O, Products P
WHERE OD.OrderID = O.OrderID AND P.ProductID = OD.ProductID
GROUP BY O.OrderID) as Totalcost

WHERE OD.OrderID = O.OrderID AND P.ProductID = OD.ProductID AND Totalcost.OrderID = O.OrderID
ORDER BY O.OrderID


-- IN , EXISTS, NOT IN, NOT EXISTS

SELECT *
FROM Products
WHERE Products.ProductID NOT IN (SELECT  OD.ProductID
									FROM [Order Details] OD)

SELECT *
FROM Products
WHERE Products.ProductID IN (SELECT  OD.ProductID
									FROM [Order Details] OD)

SELECT OD.ProductID
FROM Orders O, [Order Details] OD
WHERE O.OrderDate BETWEEN '1996-08-01' AND '1996-08-31' AND O.OrderID = OD.OrderID

SELECT *
FROM Products
WHERE Products.ProductID  IN (SELECT OD.ProductID
								 FROM Orders O, [Order Details] OD
								 WHERE O.OrderDate BETWEEN '1996-08-01' AND '1996-08-31' AND O.OrderID = OD.OrderID)

SELECT *
FROM Products P
WHERE Exists (SELECT OD.ProductID
				FROM Orders O, [Order Details] OD
				WHERE O.OrderDate BETWEEN '1996-08-01' AND '1996-08-31' AND O.OrderID = OD.OrderID AND 
					  OD.ProductID = P.ProductID)



SELECT *
FROM Products
WHERE Products.ProductID NOT IN (SELECT OD.ProductID
								 FROM Orders O, [Order Details] OD
								 WHERE O.OrderDate BETWEEN '1996-08-01' AND '1996-08-31' AND O.OrderID = OD.OrderID)



SELECT *
FROM Products P
WHERE Exists (SELECT OD.ProductID
FROM Orders O, [Order Details] OD
WHERE O.OrderDate BETWEEN '1996-08-01' AND '1996-08-31' AND O.OrderID = OD.OrderID AND OD.ProductID = P.ProductID)

SELECT *
FROM Products p, [Order Details] od
WHERE od.ProductID = p.ProductID and p.ProductID IN (1,3,5)

SELECT P.ProductID,OD.ProductID,OrderID
FROM Products p, [Order Details] od

SELECT P.ProductID,OD.ProductID,OrderID
FROM Products p, [Order Details] od
WHERE od.ProductID = P.ProductID

SELECT P.ProductID,OD.ProductID,OrderID
FROM Products p, [Order Details] od
WHERE od.ProductID <> P.ProductID


-- SORT

SELECT TOP 1 O.OrderID, sum(OD.Quantity * OD.UnitPrice * (1 - OD.Discount)) Subtotal
FROM [Order Details] OD, Orders O, Products P
WHERE OD.OrderID = O.OrderID AND P.ProductID = OD.ProductID
GROUP BY O.OrderID
ORDER BY 2 DESC 


SELECT MAX(ORDENES.Subtotal) as Subtotal
FROM (SELECT  O.OrderID, sum(OD.Quantity * OD.UnitPrice * (1 - OD.Discount)) Subtotal
	  FROM [Order Details] OD, Orders O, Products P
	  WHERE OD.OrderID = O.OrderID AND P.ProductID = OD.ProductID
	  GROUP BY O.OrderID) ORDENES
