# CAN_Security
Base de Datos que maneja la gestión de un Almacén de Productos de Seguridad, siendo un proyecto de la asignatura de Base de Datos del CFGS DAW.
Para está parte del Proyecto hemos desarrollado el código SQL para crear las Tablas, insertado datos ficticios y realizado una serie de **0consultas**, **procedimientos**, **funciones** y **triggers**.

## Consultas Simples
1. Lista todos los datos de los Proveedores de la Tabla Proveedores
2. Muestra el nombre fiscal y correo de los Proveedores que contengan la palabra 'segur' en su nombre fiscal
3. Lista todos los Pedidos que contengan un Switch POE
4. Contar todos los Productos
5. Que Responsable no tiene proveedores asignados
6. Cual es el código del Responsable con más proveedores asignados y el número de proyectos asignados que tiene
7. Muestra los Productos que valgan más de 100€, seleccionando el CodProducto, Nombre y Precio
8. Muestra todos los Productos que no han salido del Almacen (Fecha de Salida Nula), seleccionando el CodProducto, Nombre y Precio
9. Muestra todos los Productos que hayan salido del Almacen (Fecha de Salida No Nula), seleccionando el CodProducto, Nombre y Precio
10. Muestra los Empleados propios de CAN Security, seleccionando su Codigo y Nombre

## Consultas Compuestas
1. Muestra todos los Pedidos que hayan sido entregados por el Proveedor "Global Soluciones"
2. Muestra todos los Proyectos del empleado "Paco"
3. Muesta todos los Productos que sean del tipo "Cable de Camara", seleccionando su CodProducto, Nombre, Precio y TipoCableCam
4. Muestra todos los Proyectos de todos los Empleados que sean propios
5. Muestra todos las camaras que hay en el Estante CCTV, seleccionando su CodProducto, Nombre y Precio
6. Muestra todos los Productos que no esten en stock (stock = 0, stock != null)
7. Muestra todos los Empleados que tengan Poyectos de tipo "aviso"
8. Muestra los Proyectos realizados por Empleados Subcontratados
9. Muestra los Productos que hayan sido retirados por el Empleado "Paco"
10. Muestra el Nombre del Empleado que retiro el producto "PROD12345678"

## Procedimientos
1. Procedimiento que retire la cantidad de Producto de un Estante, y dándole fecha de Salida la fecha actual si la cantidad del Estante pasa a ser 0. Como parámetros recibe CodProducto, CodEstante y la cantidad de Producto a retirar.
2. Procedimiento que inserte en la Tabla de Información los datos de los Empleados que hayan retirado  Productos del Almacén. La Tabla almacenará el Código del Empleado, su nombre y los Productos retirados.

## Funciones
1. Función a la que se le pasa un código de Estante y que devuelva los Productos que estén en Stock, con su nombre y la cantidad del mismo siguiendo el siguiente formato: "Los productos en stock son: Switch POE: 10 unidades, Cable UTP: 3 unidades..."
2. Función a la que le pasamos un código de Producto y nos de la información del mismo, el stock que tiene y en que Estante se encuentra situado, siguiendo el siguiente formato: "EL Switch POE tiene 5 unidades y se encuentra en el Estante 1"

## Triggers
1. Trigger que actualice el precio del Producto, si el precio de Compra del Producto_Pedido es distinto. Poniendo como precio del Producto el mayor de ambos.
2. Trigger que cuando se inserte un Producto también lo inserte en un Estante en función de su tipo (Estante que incluya en su nombre el tipo de Producto), si no existe en el Estante. En caso de ya exista actualizamos el Stock.