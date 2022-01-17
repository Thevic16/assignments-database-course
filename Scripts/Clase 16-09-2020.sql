SELECT *
FROM Categories
WHERE CategoryID = 1


SELECT *
FROM Categories
WHERE CategoryID between 3 and 6

SELECT *
FROM Categories
WHERE CategoryName like 'c%'

SELECT *
FROM Categories
WHERE CategoryName like '%c%'

SELECT *
FROM Categories
WHERE CategoryName like 'Condiments'


SELECT *
FROM Orders
WHERE OrderId = 10256

SELECT *
FROM [Order Details]

SELECT *
FROM Orders, [Order Details]
WHERE Orders.OrderID = 10250


SELECT *
FROM Orders, [Order Details]
WHERE Orders.OrderID = [Order Details].OrderID
	AND Orders.OrderID = 10250

SELECT [Order Details].*
FROM Orders, [Order Details]
WHERE Orders.OrderID = [Order Details].OrderID
	AND Orders.OrderID = 10250

SELECT [Order Details].Discount,[Order Details].OrderID,[Order Details].UnitPrice
FROM Orders, [Order Details]
WHERE Orders.OrderID = [Order Details].OrderID
	AND Orders.OrderID = 10250


SELECT [Order Details].*,UnitPrice * Quantity * (1-Discount) as Total
FROM [Order Details]
WHERE [Order Details].OrderID = 10250


SELECT [Order Details].OrderID,sum(UnitPrice * Quantity * (1-Discount)) as Total
FROM [Order Details]
GROUP BY [Order Details].OrderID 
HAVING avg(UnitPrice * Quantity * (1-Discount)) >1000

SELECT *
FROM [Order Details]