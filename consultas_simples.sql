-- Consultas Simples

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