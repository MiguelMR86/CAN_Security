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


-- Miguel
-- 6) Muestra todos los Productos que no esten en stock (stock = 0, stock != null)
SELECT Producto.Nombre AS "Fuera de Stock"
FROM Producto
INNER JOIN Estante
ON Estante.CodProducto = Producto.CodProducto
WHERE Estante.Stock = 0;

+-------------------+
| Fuera de Stock    |
+-------------------+
| PCI Tubo + Cable  |
| Control de Acceso |
+-------------------+


-- 7) Muestra todos los Empleados que tengan Poyectos de tipo "aviso"
SELECT Empleado.Nombre AS "Proyectos Aviso"
FROM Empleado
INNER JOIN Empleado_Proyecto AS E_P
ON E_P.CodEmpleado = Empleado.CodEmpleado
INNER JOIN Proyecto
ON Proyecto.CodProyecto = E_P.CodProyecto 
WHERE Proyecto.Tipo = "Aviso";

-- Resultado
+-----------------------+
| Proyectos Aviso       |
+-----------------------+
| Alberto Medina Suarez |
| Andrea Melian Jimenez |
| Paco Martel Hernandez |
+-----------------------+


-- 8) Muestra los Proyectos realizados por Empleados Subcontratados
SELECT Empleado.Nombre, Empleado.tipo, Proyecto.tipo AS "Proyectos Aviso"
FROM Empleado
INNER JOIN Empleado_Proyecto AS E_P
ON E_P.CodEmpleado = Empleado.CodEmpleado
INNER JOIN Proyecto
ON Proyecto.CodProyecto = E_P.CodProyecto
WHERE Empleado.tipo = "Subcontratado";

-- Resultado
+-----------------------+---------------+-----------------+
| Nombre                | tipo          | Proyectos Aviso |
+-----------------------+---------------+-----------------+
| Juan Garcia Cordero   | Subcontratado | Basico          |
| Alberto Medina Suarez | Subcontratado | Aviso           |
+-----------------------+---------------+-----------------+


-- 9) Muestra los Productos que hayan sido retirados por el Empleado "Paco"
SELECT Producto.Nombre AS "Retirado por Paco"
FROM Producto
INNER JOIN Empleado
ON Empleado.CodEmpleado = Producto.CodEmpleado
WHERE Empleado.Nombre LIKE "Paco%"; 

-- Resultado
+---------------------------+
| Retirado por Paco         |
+---------------------------+
| Cierre Magnetico          |
| Cable de Energia Unipolar |
| Camara Fibra Optica       |
+---------------------------+


-- 10) Muestra el Nombre del Empleado que retiro el producto "PROD12345678"

SELECT Empleado.Nombre AS "Producto retirado por"
FROM Empleado
INNER JOIN Producto
ON Producto.CodEmpleado = Empleado.CodEmpleado
WHERE Producto.CodProducto = "PROD12345678";

-- Resultado
+-----------------------+
| Producto retirado por |
+-----------------------+
| Paco Martel Hernandez |
+-----------------------+