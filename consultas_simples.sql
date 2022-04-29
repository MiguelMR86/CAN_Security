-- Consultas Simples
-- Miguel
-- 1) Lista todos los datos de los Proveedores de la Tabla Proveedores

SELECT * FROM Proveedor; 

-- Resultado
+--------------+-----------+-----------------------+-------------------+-----------+---------+
| CodProveedor | Telefono  | Correo                | NombreFiscal      | NIF       | CodResp |
+--------------+-----------+-----------------------+-------------------+-----------+---------+
|            1 | 928765536 | soluciones@global.com | Global Soluciones | 12345678A |       1 |
|            2 | 928546789 | seguridad@tearseg.com | Tearseg Seguridad | 12345678B |       1 |
|            3 | 928467986 | seguri@can.com        | SeguriCan         | 12345678C |       2 |
|            4 | 928753421 | seguridad@visor.com   | Visor Seguridad   | 12345678D |       1 |
|            5 | 928456734 | segur@protech.com     | SegurProtech      | 12345678E |       3 |
|            6 | 928324567 | seguridad@ecu.com     | Ecu Seguridad     | 12345678F |       6 |
+--------------+-----------+-----------------------+-------------------+-----------+---------+


-- 2) Muestra el nombre fiscal y correo de los Proveedores que contengan la palabra 
--    'segur' en su nombre fiscal

SELECT NombreFiscal, correo 
FROM Proveedor
WHERE NombreFiscal LIKE "segur%";

-- Resultado
+--------------+-------------------+
| NombreFiscal | correo            |
+--------------+-------------------+
| SeguriCan    | seguri@can.com    |
| SegurProtech | segur@protech.com |
+--------------+-------------------+


-- 3) Lista todos los Pedidos que contengan un Switch POE
SELECT * 
FROM Pedido
WHERE ProductosPedidos LIKE "%Switch POE%";

-- Resultado
+--------------+----------------------------------------------------+--------------+
| NumPedido    | ProductosPedidos                                   | CodProveedor |
+--------------+----------------------------------------------------+--------------+
| PED123456781 | PCI Tubo + Cable, Switch POE, Sensor de Movimiento |            1 |
| PED123456783 | Switch POE, Control de Acceso, Cierre Magnetico    |            4 |
| PED123456789 | Camara Fibra Optica, Switch POE, Cable UTP         |            1 |
+--------------+----------------------------------------------------+--------------+


-- 4) Contar todos los Productos
SELECT COUNT(CodProducto) FROM Producto;

-- Resultado
+--------------------+
| COUNT(CodProducto) |
+--------------------+
|                 11 |
+--------------------+


-- 5) Que Responsable no tiene proveedores asignados
SELECT Nombre
FROM Responsable_Proveedor
WHERE CodResponsable NOT IN (
    SELECT CodResp
    FROM Proveedor
);


-- Resultado
+--------+
| Nombre |
+--------+
| Mario  |
| Ivan   |
+--------+


-- Aitor
-- 6) Cual es el código del Responsable con más proyectos asignados
-- y el número de proyectos asignados que tiene
SELECT Tabla.CodResp, MAX(Tabla.Proyectos_Asignados) Proyectos_Asignados
FROM (
    SELECT Pr.CodResp, COUNT(Pr.CodResp) Proyectos_Asignados
    FROM Proveedor Pr
    GROUP BY Pr.CodResp
) 
AS Tabla; 

-- Resultado
+---------+---------------------+
| CodResp | Proyectos_Asignados |
+---------+---------------------+
|       1 |                   3 |
+---------+---------------------+

-- 7) Muestra los Productos que valgan más de 100€,
-- seleccionando el CodProducto, Nombre y Precio
SELECT P.CodProducto, P.Nombre, P.Precio 
FROM Producto P
WHERE P.Precio > 100;

-- Resultado
+--------------+----------------------+--------+
| CodProducto  | Nombre               | Precio |
+--------------+----------------------+--------+
| PROD12345670 | Cierre Magnetico     | 200.25 |
| PROD12345671 | Control de Acceso    | 100.50 |
| PROD12345672 | Camara Analogica     | 150.99 |
| PROD12345674 | Sensor de Movimiento | 450.50 |
| PROD12345678 | Camara Fibra Optica  | 323.20 |
+--------------+----------------------+--------+

-- 8) Muestra todos los Productos que no han salido del Almacen 
-- (Fecha de Salida Nula), seleccionando el CodProducto, Nombre y Precio
SELECT P.CodProducto, P.Nombre, P.Precio 
FROM Producto P
WHERE P.FechaRetirada IS NULL;

-- Resultado
+--------------+-----------------------+--------+
| CodProducto  | Nombre                | Precio |
+--------------+-----------------------+--------+
| PROD12345611 | Cable de Fibra Optica |  10.80 |
| PROD12345671 | Control de Acceso     | 100.50 |
| PROD12345672 | Camara Analogica      | 150.99 |
| PROD12345674 | Sensor de Movimiento  | 450.50 |
| PROD12345676 | Cable UTP             |  12.20 |
| PROD12345677 | Switch POE            |  50.32 |
+--------------+-----------------------+--------+

-- 9) Muestra todos los Productos que hayan salido del Almacen 
-- (Fecha de Salida No Nula), seleccionando el CodProducto, Nombre y Precio
SELECT P.CodProducto, P.Nombre, P.Precio 
FROM Producto P
WHERE P.FechaRetirada IS NOT NULL;

-- Resultado
+--------------+---------------------------+--------+
| CodProducto  | Nombre                    | Precio |
+--------------+---------------------------+--------+
| PROD12345670 | Cierre Magnetico          | 200.25 |
| PROD12345673 | Cable de Energia Unipolar |   5.00 |
| PROD12345675 | PCI Tubo + Cable          |  10.50 |
| PROD12345678 | Camara Fibra Optica       | 323.20 |
| PROD12345679 | Cable Coaxial             |   3.20 |
+--------------+---------------------------+--------+

-- 10) Muestra los Empleados propios de CAN Security, seleccionando
-- su Codigo y Nombre
SELECT CodEmpleado, Nombre 
FROM Empleado 
WHERE Tipo = "Propio";

-- Resultado
+--------------+-------------------------------+
| CodEmpleado  | Nombre                        |
+--------------+-------------------------------+
| EMP123456785 | Jose Carlos Gonzalez Calcines |
| EMP123456788 | Andrea Melian Jimenez         |
| EMP123456789 | Paco Martel Hernandez         |
+--------------+-------------------------------+