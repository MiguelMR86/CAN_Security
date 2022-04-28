-- Consultas Compuestas

-- Aitor
-- 1) Muestra todos los Pedidos que hayan sido entregados por 
-- el Proveedor "Global Soluciones"
SELECT P.NumPedido, P.ProductosPedidos
FROM Pedido P 
INNER JOIN Proveedor Pr 
ON P.CodProveedor = Pr.CodProveedor
WHERE Pr.NombreFiscal = "Global Soluciones";

-- Resultado
+--------------+----------------------------------------------------+
| NumPedido    | ProductosPedidos                                   |
+--------------+----------------------------------------------------+
| PED123456781 | PCI Tubo + Cable, Switch POE, Sensor de Movimiento |
| PED123456789 | Camara Fibra Optica, Switch POE, Cable UTP         |
+--------------+----------------------------------------------------+

-- 2) Muestra todos los Proyectos del empleado "Paco"
SELECT Pr.*
FROM Proyecto Pr 
INNER JOIN Empleado_Proyecto Ep 
ON Pr.CodProyecto = Ep.CodProyecto
INNER JOIN Empleado E 
ON Ep.CodEmpleado = E.CodEmpleado
WHERE E.Nombre LIKE "Paco%";

-- Resultado
+---------------+---------------------------------------------------------------------------------------------+--------+| CodProyecto   | Descripcion                                                                                 | Tipo   |+---------------+---------------------------------------------------------------------------------------------+--------+| PROY123456788 | Telde, Calle Diamante, primer B portal, A, Instalacion de un sistema de y alarmas           | Basico || PROY123456789 | Centro cormercial de los Alisios, instalacion completa de un sistema de seguridad y alarmas | Aviso  |+---------------+---------------------------------------------------------------------------------------------+--------+2