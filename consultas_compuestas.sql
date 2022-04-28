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

-- 3) Muesta todos los Productos que sean del tipo "Cable de Camara",
-- seleccionando su CodProducto, Nombre, Precio y TipoCableCam
SELECT Pr.CodProducto, Pr.Nombre, Pr.Precio, Cl.TipoCableCam
FROM Producto Pr
INNER JOIN Cableado Cl
ON Pr.CodProducto = Cl.CodProducto 
WHERE Cl.Tipo = "Cable de Camara";

-- Resultado
+--------------+-----------------------+--------+--------------+
| CodProducto  | Nombre                | Precio | TipoCableCam |
+--------------+-----------------------+--------+--------------+
| PROD12345611 | Cable de Fibra Optica |  10.80 | Fibra Optica |
| PROD12345676 | Cable UTP             |  12.20 | UTP          |
| PROD12345679 | Cable Coaxial         |   3.20 | Coaxial      |
+--------------+-----------------------+--------+--------------+

-- 4) Muestra todos los Proyectos de todos los Empleados que sean propios
SELECT Pr.*
FROM Proyecto Pr 
INNER JOIN Empleado_Proyecto Ep 
ON Pr.CodProyecto = Ep.CodProyecto
INNER JOIN Empleado E 
ON Ep.CodEmpleado = E.CodEmpleado
WHERE E.Tipo = "Propio";

-- 5) Muestra todos las camaras que hay en el Estante CCTV, 
-- seleccionando su CodProducto, Nombre y Precio
SELECT Pr.CodProducto, Pr.Nombre, Pr.Precio
FROM Producto Pr
LEFT JOIN CCTV C 
ON Pr.CodProducto = C.CodProducto
LEFT JOIN Estante Es 
ON C.CodProducto = Es.CodProducto
WHERE Es.NombreEst = "Estante CCTV"
AND C.Tipo = "Camaras";

-- Resultado
+--------------+---------------------+--------+
| CodProducto  | Nombre              | Precio |
+--------------+---------------------+--------+
| PROD12345672 | Camara Analogica    | 150.99 |
| PROD12345678 | Camara Fibra Optica | 323.20 |
+--------------+---------------------+--------+