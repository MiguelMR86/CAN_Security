-- Aitor

-- Procedimiento que retire la cantidad de Producto de un Estante, y 
-- dándole fecha de Salida la fecha actual si la cantidad del Estante pasa a ser 0. Como parámetros recibe
-- CodProducto, CodEstante y la cantidad de Producto a retirar.

DROP PROCEDURE IF EXISTS retirar_producto;
DELIMITER $$
CREATE PROCEDURE retirar_producto(IN codEstanteRetirar VARCHAR(30), IN codProdRetirar VARCHAR(12), IN cantidadRetirar INT)
BEGIN

    DECLARE cantidadProducto INT;

    SELECT Stock INTO cantidadProducto FROM Estante WHERE NombreEst = codEstanteRetirar AND CodProducto = codProdRetirar;

    IF codEstanteRetirar NOT IN (SELECT NombreEst FROM Estante) THEN 
        SELECT "No existe ese Estante";
    ELSEIF codProdRetirar NOT IN (SELECT CodProducto FROM Producto) THEN
        SELECT "El Producto no existe";
    ELSEIF cantidadRetirar <= 0 THEN 
        SELECT "La Cantidad a retirar debe ser mayor a 0";
    ELSEIF cantidadProducto > cantidadRetirar THEN 
        SET cantidadProducto = cantidadProducto - cantidadRetirar;

        UPDATE Estante 
        SET Estante.Stock = cantidadProducto 
        WHERE NombreEst = codEstanteRetirar 
        AND CodProducto = codProdRetirar;
    ELSE 
        SET cantidadProducto = 0;

        UPDATE Estante 
        SET Estante.Stock = 0
        WHERE NombreEst = codEstanteRetirar 
        AND CodProducto = codProdRetirar;

        UPDATE Producto
        SET Producto.FechaRetirada = CURRENT_DATE()
        WHERE CodProducto = codProdRetirar;

    END IF;

END $$
DELIMITER ;

CALL retirar_producto("Estante CCTV","PROD12345678",10);
CALL retirar_producto("Estante Cableado","PROD12345679",10);
CALL retirar_producto("Estante Cableado", "PROD12345679", -1);


-- Miguel
-- Procedimiento que inserte en la Tabla de Información los datos de los Empleados que
-- hayan retirado  Productos del Almacén. La Tabla almacenará el Código del Empleado,
-- su nombre y los Productos retirados.

DELIMITER $$
DROP PROCEDURE IF EXISTS InfoEmpRetirada $$
CREATE PROCEDURE InfoEmpRetirada()
BEGIN
    -- Declaro las variables
    DECLARE fin INT DEFAULT 1;
    DECLARE Cod_emp VARCHAR(20);
    DECLARE Nom_emp VARCHAR(50);
    DECLARE Cod_pro VARCHAR(12);

    -- Declaro el cursor
    DECLARE InfoEmp CURSOR FOR
    SELECT Empleado.CodEmpleado, Empleado.Nombre, Producto.CodProducto
    FROM Empleado
    INNER JOIN Producto
    ON Producto.CodEmpleado = Empleado.CodEmpleado
    WHERE Empleado.CodEmpleado = Producto.CodEmpleado;

    -- Declaro el manejo de errores
    DECLARE CONTINUE HANDLER FOR NOT FOUND SET fin = 0;

    OPEN InfoEmp;

    FETCH InfoEmp INTO Cod_emp, Nom_emp, Cod_pro;

    WHILE fin != 0 DO
        IF Cod_emp NOT IN (SELECT CodEmpleado FROM Info_Retirada) THEN
            INSERT INTO Info_Retirada VALUES(Cod_emp, Nom_emp, Cod_pro);
        END IF;
        FETCH InfoEmp INTO Cod_emp, Nom_emp, Cod_pro;
    END WHILE;

    CLOSE InfoEmp;
    SELECT * FROM Info_Retirada;
END $$

DELIMITER ;
CALL InfoEmpRetirada();