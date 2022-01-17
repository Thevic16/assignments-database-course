/*4. En base a la base de datos definitiva realizar las instrucciones “Selects” que puedan 
permitir obtener las siguientes informaciones:*/

/*A. Empleado con mayor comisión del mes*/


--SubQuerry comision ganada a traves de la venta de equipos. 
SELECT IdEmpl,SUM(InvoiceEquip.CommissionEmpl) AS SubTotalCommissionEmpl 
FROM InvoiceEquip,Billing
WHERE InvoiceEquip.IdBilling = Billing.IdBilling AND Billing.BillingDate BETWEEN DATEADD(MM,-1,GETDATE()) AND GETDATE() 
GROUP BY IdEmpl

--SubQuerry comision ganada a traves de la piezas de cambiadas. 
SELECT Part.IdEmpl,SUM(Part.CommissionEmpl) AS SubTotalCommissionEmpl 
FROM Part,InvoiceService,Billing
WHERE Part.[Authorization] = 1 AND Part.IdService = InvoiceService.IdService AND 
InvoiceService.IdBilling = Billing.IdBilling AND Part.IdClient = Billing.IdClient AND 
Billing.BillingDate BETWEEN DATEADD(MM,-1,GETDATE()) AND GETDATE() 
GROUP BY Part.IdEmpl


--SubQuerry FULL JOIN
SELECT TOP 1 SubTotal1.IdEmpl, (ISNULL(SubTotal1.SubTotalCommissionEmpl,0)+ ISNULL(SubTotal2.SubTotalCommissionEmpl,0)) AS TotalCommissionEmpl
FROM (SELECT IdEmpl,SUM(InvoiceEquip.CommissionEmpl) AS SubTotalCommissionEmpl 
FROM InvoiceEquip,Billing
WHERE InvoiceEquip.IdBilling = Billing.IdBilling AND Billing.BillingDate BETWEEN DATEADD(MM,-1,GETDATE()) AND GETDATE() 
GROUP BY IdEmpl) AS SubTotal1

FULL OUTER JOIN (SELECT Part.IdEmpl,SUM(Part.CommissionEmpl) AS SubTotalCommissionEmpl 
FROM Part,InvoiceService,Billing
WHERE Part.[Authorization] = 1 AND Part.IdService = InvoiceService.IdService AND 
InvoiceService.IdBilling = Billing.IdBilling AND Part.IdClient = Billing.IdClient AND 
Billing.BillingDate BETWEEN DATEADD(MM,-1,GETDATE()) AND GETDATE() 
GROUP BY Part.IdEmpl)AS SubTotal2

on SubTotal1.IdEmpl = SubTotal2.IdEmpl 

ORDER BY TotalCommissionEmpl DESC


/* B. Empleado con menor tiempo promedio en realización de un servicio */

SELECT TOP 1 IdService,IdEmpl,AVG(DATEDIFF(minute, ExecutionSequence.TimeInit, ExecutionSequence.TimeFinal)) AS [AVG minutes]
FROM ExecutionSequence
GROUP BY IdService,IdEmpl
ORDER BY [AVG minutes] ASC



/*C. Historia de puesto de un empleado */

SELECT *
FROM JobHistory
WHERE JobHistory.IdEmpl = '0001'


/*Equipos más vendidos durante un mes*/

SELECT InvoiceEquip.IdEqui,COUNT(InvoiceEquip.IdEqui) AS Amount
FROM InvoiceEquip,Billing
WHERE InvoiceEquip.IdBilling = Billing.IdBilling AND DATEPART(mm, Billing.BillingDate) = DATEPART(mm, (GETDATE()))
GROUP BY InvoiceEquip.IdEqui
ORDER BY Amount DESC


/*E. Tabla comparativa de equipos según características: Cámara WIFI BlueTooh*/
SELECT *
FROM EqupmentSale,EquiFeature
WHERE EqupmentSale.IdEqui = EquiFeature.IdEqui AND (EquiFeature.[Description] = 'Cámara' OR 
EquiFeature.[Description] = 'WIFI' OR EquiFeature.[Description] = 'BlueTooh')

/*F. Clientes que han solicitado más de una reparación en un mes.*/ 
SELECT Billing.IdClient
FROM InvoiceService,Billing
WHERE InvoiceService.IdBilling = Billing.IdBilling AND DATEPART(mm, Billing.BillingDate) = DATEPART(mm, (GETDATE()))
GROUP BY Billing.IdClient
HAVING COUNT(Billing.IdClient)>1

/*G. Equipos vendidos durante un mes incluyendo la información: Precio de venta, 
cliente el empleado que recibió la comisión y el monto de la misma*/

SELECT EqupmentSale.SalePrice,Billing.IdClient,InvoiceEquip.IdEmpl,InvoiceEquip.CommissionEmpl
FROM InvoiceEquip,Billing,EqupmentSale
WHERE InvoiceEquip.IdBilling = Billing.IdBilling AND EqupmentSale.IdEqui = InvoiceEquip.IdEqui AND
DATEPART(mm, Billing.BillingDate) = DATEPART(mm, (GETDATE()))


/*H. Empleados cuyos familiares recibieron descuentos en el mes.*/
SELECT Employee.IdEmpl
FROM Employee,Client,Billing
WHERE Employee.IdEmpl = Client.IdEmplFami AND Client.IdClient = Billing.IdClient
AND Billing.BillingDate BETWEEN DATEADD(MM,-1,GETDATE()) AND GETDATE() 

/*I. Tiempo promedio de realización de los servicios.*/

SELECT AVG(TimeService.[AVG minutes])  AS 'AVG minutes'
FROM (SELECT '1' AS Indice,IdService,SUM(DATEDIFF(minute, ExecutionSequence.TimeInit, ExecutionSequence.TimeFinal)) AS [AVG minutes]
FROM ExecutionSequence
GROUP BY IdService) AS TimeService
GROUP BY TimeService.Indice



--SubQuerry Tiempo tomado para realizar un servicio. 
SELECT IdService,SUM(DATEDIFF(minute, ExecutionSequence.TimeInit, ExecutionSequence.TimeFinal)) AS [AVG minutes]
FROM ExecutionSequence
GROUP BY IdService
ORDER BY [AVG minutes] ASC



/*J. Servicios que requirieron cambios de piezas durante este mes.*/

SELECT Part.IdService
FROM Part,InvoiceService,Billing
WHERE Part.[Authorization] = 1 AND Part.IdService = InvoiceService.IdService AND 
InvoiceService.IdBilling = Billing.IdBilling AND Part.IdClient = Billing.IdClient AND 
Billing.BillingDate BETWEEN DATEADD(MM,-1,GETDATE()) AND GETDATE() 


/*K. Listado de empleados (Datos empleados) con su supervisor (Datos supervisor)*/

SELECT *
FROM Employee Emplo, Employee Super
WHERE Emplo.IdSupervisor = Super.IdEmpl 

/*LListado de contactos para un empleado*/

SELECT *
FROM EmplContact