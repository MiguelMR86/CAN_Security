-- Aitor

-- Función a la que se le pasa un código de Estante y que 
-- devuelva los Productos que estén en Stock, con su nombre 
-- y la cantidad del mismo siguiendo el siguiente formato: 
-- "Los productos en stock son: Switch POE: 10 unidades, Cable UTP: 3 unidades..."

DROP FUNCTION IF EXISTS productos_en_stock;
DELIMITER $$
CREATE FUNCTION productos_en_stock (codEstante VARCHAR(30))
RETURNS VARCHAR(300)
BEGIN

    DECLARE result VARCHAR (300) DEFAULT "";
    DECLARE nombreProducto VARCHAR(35) DEFAULT "";
    DECLARE cantidadProducto INT;
    DECLARE productosStock INT;
    DECLARE fin INT DEFAULT 1;
    
    DECLARE almacen CURSOR FOR
    SELECT Pr.Nombre, Es.Stock
    FROM Producto Pr
    INNER JOIN Estante Es
    ON Pr.CodProducto = Es.CodProducto
    WHERE NombreEst = codEstante
    AND Es.Stock > 0;
    
    DECLARE CONTINUE HANDLER FOR NOT FOUND SET fin = 0;

    SELECT COUNT(Pr.Nombre) 
    INTO productosStock 
    FROM Producto Pr
    INNER JOIN Estante Es
    ON Pr.CodProducto = Es.CodProducto
    WHERE NombreEst = codEstante
    AND Es.Stock > 0;
    
    IF codEstante NOT IN (SELECT NombreEst FROM Estante) THEN
        SET result = "ERR1: No existe el Estante";
    ELSEIF productosStock = 0 THEN 
        SET result = "ERR2: No hay productos en Stock";
    ELSE
        OPEN almacen;
        FETCH almacen INTO nombreProducto, cantidadProducto;
    
        SET result = CONCAT(result,"Los productos en stock son: ");
    
        WHILE fin != 0 DO

            SET result = CONCAT(result, nombreProducto, ": ", cantidadProducto, " unidades, ");
            FETCH almacen INTO nombreProducto, cantidadProducto;

        END WHILE;
    
        CLOSE almacen;
        SET result = LEFT(result,LENGTH(result) - 2);
    
    END IF;

    RETURN result;

END $$
DELIMITER ;

SELECT productos_en_stock("Estante CCTV") AS "Productos en Stock";

-- Resultado
+-----------------------------------------------------------------------------------+
| Productos en Stock                                                                |
+-----------------------------------------------------------------------------------+
| Los productos en stock son: Camara Analogica: 30 unidades, Switch POE: 4 unidades |
+-----------------------------------------------------------------------------------+

SELECT productos_en_stock("Estante CCT") AS "Productos en Stock";

-- Resultado
+----------------------------+
| Productos en Stock         |
+----------------------------+
| ERR1: No existe el Estante |
+----------------------------+

SELECT productos_en_stock("Estante Prueba") AS "Productos en Stock";

-- Resultado
+---------------------------------+
| Productos en Stock              |
+---------------------------------+
| ERR2: No hay productos en Stock |
+---------------------------------+

-- Miguel 