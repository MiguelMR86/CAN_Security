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

-- Función a la que le pasamos un código de Producto y nos de la información del mismo,
-- el stock que tiene y en que Estante se encuentra situado, siguiendo el siguiente 
-- formato: "EL Switch POE tiene 5 unidades y se encuentra en el Estante CCTV"

DELIMITER $$
DROP FUNCTION IF EXISTS prod_info_stock $$
CREATE FUNCTION prod_info_stock(Cod_Prod VARCHAR(30))
RETURNS VARCHAR(200)
BEGIN

    DECLARE Result VARCHAR(200) DEFAULT "";
    DECLARE PR_Nombre VARCHAR(100) DEFAULT "";
    DECLARE PR_Estante VARCHAR(100) DEFAULT "";
    DECLARE PR_Stock INT;

    SELECT Pr.nombre, COUNT(Pr.Nombre), Es.NombreEst
    INTO PR_Nombre, PR_Stock, PR_Estante
    FROM Producto Pr
    INNER JOIN Estante Es
    ON Pr.CodProducto = Es.CodProducto
    WHERE Pr.CodProducto = Cod_Prod
    AND Es.Stock > 0;

    IF Cod_Prod NOT IN (SELECT CodProducto FROM Producto) THEN
        SET Result = "ERROR: No se encontro el producto.";

    ELSEIF PR_Stock = 0 THEN
        SET Result = CONCAT("ERROR: El ",PR_Nombre," no se encuentra en stock.");

    ELSE
        SET Result = CONCAT("El ",PR_Nombre," tiene ",PR_Stock," unidades y se encuentra en el ",PR_Estante,".");
    END IF;

    RETURN Result;
    
END $$
DELIMITER ;

SELECT prod_info_stock("PROD12345678") AS "Stock y Ubicacion del Producto";

-- Resultado
+----------------------------------------------------------------------------+
| Stock y Ubicacion del Producto                                             |
+----------------------------------------------------------------------------+
| El Camara Fibra Optica tiene 1 unidades y se encuentra en el Estante CCTV. |
+----------------------------------------------------------------------------+

SELECT prod_info_stock("PROD123456710") AS "Stock y Ubicacion del Producto";
+--------------------------------+
| Stock y Ubicacion del Producto |
+--------------------------------+
| No se encontro el producto     |
+--------------------------------+

SELECT prod_info_stock("PROD12345675") AS "Stock y Ubicacion del Producto";
+-----------------------------------------------------+
| Stock y Ubicacion del Producto                      |
+-----------------------------------------------------+
| ERROR: El PCI Tubo + Cable no se ecuentra en stock. |
+-----------------------------------------------------+