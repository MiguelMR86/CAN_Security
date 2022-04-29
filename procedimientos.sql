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