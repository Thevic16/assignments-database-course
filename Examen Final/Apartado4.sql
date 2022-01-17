/* a.	Conteos, despachos, facturas (Despacho, continuación (cada 30 días), 
Facturas de devolución, Factura de venta, por proyecto. */

--Conteos
SELECT * 
FROM Conteo,ConteoDespacho,ConteoDevolucion,ConteoVenta
WHERE Conteo.IdConteo = ConteoDespacho.IdConteoDes OR  Conteo.IdConteo = ConteoDevolucion.IdConteoDev OR Conteo.IdConteo = ConteoVenta.IdConteoVenta

--Despachos
SELECT *
FROM [FacturaDespacho-]


/*facturas (Despacho, continuación (cada 30 días), 
Facturas de devolución, Factura de venta, por proyecto.*/

--Factura Despacho
SELECT *
FROM [FacturaDespacho-],FacturaDespachoSubtotal
WHERE [FacturaDespacho-].IdFacturaDes = FacturaDespachoSubtotal.IdFacturaDes 
AND [FacturaDespacho-].IdPropuesta = FacturaDespachoSubtotal.IdPropuesta 
AND [FacturaDespacho-].IdProyecto = FacturaDespachoSubtotal.IdProyecto

--Factura Continuacion
SELECT *
FROM FacturaContinuidad,FacturaDespachoSubtotal
WHERE FacturaContinuidad.IdFacturaDes = FacturaDespachoSubtotal.IdFacturaDes 
AND FacturaContinuidad.IdPropuesta = FacturaDespachoSubtotal.IdPropuesta 
AND FacturaContinuidad.IdProyecto = FacturaDespachoSubtotal.IdProyecto

--Factura devolucion
SELECT *
FROM FacturaDevolucion,FacturaDevolucionSubtotal
WHERE FacturaDevolucion.IdFacturaDev = FacturaDevolucionSubtotal.IdFacturaDev
AND FacturaDevolucion.IdFacturaDes = FacturaDevolucionSubtotal.IdFacturaDes 
AND FacturaDevolucion.IdPropuesta = FacturaDevolucionSubtotal.IdPropuesta 
AND FacturaDevolucion.IdProyecto = FacturaDevolucionSubtotal.IdProyecto

--Factura venta
SELECT *
FROM FacturaVenta,FacturaVentaSubtotal
WHERE FacturaVenta.IdFacturaVenta = FacturaVentaSubtotal.IdFacturaVenta
AND FacturaVenta.IdFacturaDev = FacturaVentaSubtotal.IdFacturaDev
AND FacturaVenta.IdFacturaDes = FacturaVentaSubtotal.IdFacturaDes 
AND FacturaVenta.IdPropuesta = FacturaVentaSubtotal.IdPropuesta 
AND FacturaVenta.IdProyecto = FacturaVentaSubtotal.IdProyecto


/*b.	Inventario por proyecto de cada cliente.*/
SELECT * 
FROM ClienteEquipoAlqui


/*c.	Monto en depósito por cliente por proyecto.*/
SELECT Proyecto.IdProyecto,Proyecto.IdCliente,Proyecto.MontoTotalDeposito,Proyecto.MontoProyectoAud
FROM Proyecto


/*d.	Proyectos cerrados con la información de las facturas generadas desde su inicio.*/
SELECT *
FROM Proyecto,
(SELECT [FacturaDespacho-].IdFacturaDes,[FacturaDespacho-].IdProyecto,[FacturaDespacho-].FechaInicial,[FacturaDespacho-].FechaFinal,[FacturaDespacho-].TotalAlquiler,FacturaDespachoSubtotal.IdEquipo,FacturaDespachoSubtotal.PrecioAlquiler,FacturaDespachoSubtotal.SubTotalAlquiler
FROM [FacturaDespacho-],FacturaDespachoSubtotal
WHERE [FacturaDespacho-].IdFacturaDes = FacturaDespachoSubtotal.IdFacturaDes 
AND [FacturaDespacho-].IdPropuesta = FacturaDespachoSubtotal.IdPropuesta 
AND [FacturaDespacho-].IdProyecto = FacturaDespachoSubtotal.IdProyecto ) AS Despacho,

(SELECT FacturaContinuidad.IdFacturaDes,FacturaContinuidad.IdProyecto,FacturaContinuidad.FechaInicial,FacturaContinuidad.FechaFinal,FacturaContinuidad.TotalAlquiler,FacturaDespachoSubtotal.IdEquipo,FacturaDespachoSubtotal.PrecioAlquiler,FacturaDespachoSubtotal.SubTotalAlquiler
FROM FacturaContinuidad,FacturaDespachoSubtotal
WHERE FacturaContinuidad.IdFacturaDes = FacturaDespachoSubtotal.IdFacturaDes 
AND FacturaContinuidad.IdPropuesta = FacturaDespachoSubtotal.IdPropuesta 
AND FacturaContinuidad.IdProyecto = FacturaDespachoSubtotal.IdProyecto) AS Continuidad,

(SELECT FacturaDevolucion.IdFacturaDes,FacturaDevolucion.IdProyecto,FacturaDevolucion.FechaInicial,FacturaDevolucion.FechaFinal,FacturaDevolucion.TotalAlquiler,FacturaDevolucionSubtotal.IdEquipo,FacturaDevolucionSubtotal.PrecioAlquiler,FacturaDevolucionSubtotal.SubTotalAlquiler
FROM FacturaDevolucion,FacturaDevolucionSubtotal
WHERE FacturaDevolucion.IdFacturaDev = FacturaDevolucionSubtotal.IdFacturaDev
AND FacturaDevolucion.IdFacturaDes = FacturaDevolucionSubtotal.IdFacturaDes 
AND FacturaDevolucion.IdPropuesta = FacturaDevolucionSubtotal.IdPropuesta 
AND FacturaDevolucion.IdProyecto = FacturaDevolucionSubtotal.IdProyecto) AS Devolucion,

(SELECT FacturaVenta.IdFacturaDes,FacturaVenta.IdProyecto,FacturaVenta.TotalVenta,FacturaVentaSubtotal.IdEquipo,FacturaVentaSubtotal.PrecioVenta,FacturaVentaSubtotal.SubTotalVenta
FROM FacturaVenta,FacturaVentaSubtotal
WHERE FacturaVenta.IdFacturaVenta = FacturaVentaSubtotal.IdFacturaVenta
AND FacturaVenta.IdFacturaDev = FacturaVentaSubtotal.IdFacturaDev
AND FacturaVenta.IdFacturaDes = FacturaVentaSubtotal.IdFacturaDes 
AND FacturaVenta.IdPropuesta = FacturaVentaSubtotal.IdPropuesta 
AND FacturaVenta.IdProyecto = FacturaVentaSubtotal.IdProyecto) AS Venta


WHERE Proyecto.EstaCerrado = 1 AND  Proyecto.IdProyecto = Despacho.IdProyecto AND
Proyecto.IdProyecto = Continuidad.IdProyecto AND Proyecto.IdProyecto = Devolucion.IdProyecto
AND Proyecto.IdProyecto = Venta.IdProyecto


/*e. Proyecto con equipos en alquiler con sus facturas de continuación que vencen en el mes actual.*/

SELECT Continuidad.IdProyecto,Continuidad.FechaInicial,Continuidad.FechaFinal,Continuidad.TotalAlquiler,Continuidad.IdEquipo,Continuidad.PrecioAlquiler,Continuidad.SubTotalAlquiler
FROM ClienteEquipoAlqui,
(SELECT FacturaContinuidad.IdProyecto, FacturaContinuidad.IdPropuesta,FacturaContinuidad.IdCliente,FacturaContinuidad.FechaInicial,FacturaContinuidad.FechaFinal,FacturaContinuidad.TotalAlquiler,FacturaDespachoSubtotal.IdEquipo,FacturaDespachoSubtotal.PrecioAlquiler,FacturaDespachoSubtotal.SubTotalAlquiler
FROM FacturaContinuidad,FacturaDespachoSubtotal
WHERE FacturaContinuidad.IdFacturaDes = FacturaDespachoSubtotal.IdFacturaDes 
AND FacturaContinuidad.IdPropuesta = FacturaDespachoSubtotal.IdPropuesta 
AND FacturaContinuidad.IdProyecto = FacturaDespachoSubtotal.IdProyecto) AS Continuidad

WHERE ClienteEquipoAlqui.IdPropuesta = Continuidad.IdPropuesta AND ClienteEquipoAlqui.IdProyecto = Continuidad.IdProyecto
AND ClienteEquipoAlqui.IdCliente = Continuidad.IdCliente AND ClienteEquipoAlqui.IdEquipo = Continuidad.IdEquipo
AND ClienteEquipoAlqui.CantidadRetirado > 0