-- Aitor

-- Trigger que actualice el precio del Producto, si el precio de Compra del
-- Producto_Pedido es distinto. Poniendo como precio del Producto el mayor de ambos.

DROP TRIGGER IF EXISTS actualizar_precio;
DELIMITER $$
CREATE TRIGGER actualizar_precio
AFTER INSERT ON Pedido_Producto
FOR EACH ROW
BEGIN

    DECLARE precioProducto DEC(5,2);

    SELECT Precio INTO precioProducto FROM Producto WHERE Producto.CodProducto = NEW.CodProducto;

    IF NEW.CodProducto IN (SELECT CodProducto FROM Producto) THEN

        IF NEW.PrecioCompra > precioProducto THEN

            UPDATE Producto
            SET Producto.Precio = NEW.PrecioCompra
            WHERE Producto.CodProducto = NEW.CodProducto;

        END IF;

    END IF;

END $$
DELIMITER ;

-- Ejemplo PROD12345678
SELECT Precio 
FROM Producto 
WHERE CodProducto = "PROD12345678";

-- Resultado
+--------+
| Precio |
+--------+
| 323.20 |
+--------+

INSERT INTO Pedido VALUES ("PED987654321","Cable UTP, Cable Coaxial, Cable de Fibra Optica",5); 

INSERT INTO Pedido_Producto VALUES ("PROD12345678","PED987654321",6,400.50);

-- Precio tras insertar un Pedido_Producto con precio de compra mayor
+--------+
| Precio |
+--------+
| 400.50 |
+--------+

-- Miguel
-- Trigger que cuando se inserte un Pedido_Producto también lo inserte en un Estante 
-- en función de su tipo (Estante que incluya en su nombre el tipo de Producto), actualizando
-- su Stock.

DELIMITER $$
DROP TRIGGER IF EXISTS add_prod_estante $$
CREATE TRIGGER add_prod_estante
AFTER INSERT ON Pedido_Producto
FOR EACH ROW
BEGIN
    DECLARE Tipo_prod VARCHAR(30);

    SELECT Producto.tipo 
    INTO Tipo_prod 
    FROM Producto 
    WHERE CodProducto = NEW.CodProducto;

    CASE Tipo_prod 
        WHEN 'CCTV' THEN
            
            UPDATE Estante Es 
            INNER JOIN Producto Pr
            ON Pr.CodProducto = Es.CodProducto
            SET Es.Stock = Es.Stock + NEW.Cantidad
            WHERE Es.CodProducto = NEW.CodProducto
            AND Es.NombreEst LIKE '%CCTV';

        WHEN 'Intrusion' THEN 
        
            UPDATE Estante Es 
            INNER JOIN Producto Pr
            ON Pr.CodProducto = Es.CodProducto
            SET Es.Stock = Es.Stock + NEW.Cantidad
            WHERE Es.CodProducto = NEW.CodProducto
            AND Es.NombreEst LIKE '%Intrusion';
        
        ELSE 

            UPDATE Estante Es 
            INNER JOIN Producto Pr
            ON Pr.CodProducto = Es.CodProducto
            SET Es.Stock = Es.Stock + NEW.Cantidad
            WHERE Es.CodProducto = NEW.CodProducto
            AND Es.NombreEst LIKE '%Cableado';

    END CASE;
    
END $$
DELIMITER ;

-- Ejemplo Producto "PROD12345677"
SELECT Es.*
FROM Estante Es
WHERE Es.CodProducto = "PROD12345677";

-- Resultado
+--------------+--------------+-------+
| NombreEst    | CodProducto  | Stock |
+--------------+--------------+-------+
| Estante CCTV | PROD12345677 |     4 |
+--------------+--------------+-------+

-- Insertamos para comprobar el Trigger
INSERT INTO Pedido VALUES ("PED123456111","Switch POE",5); 

INSERT INTO Pedido_Producto VALUES ("PROD12345677","PED123456111",6,120.10);

SELECT Es.*
FROM Estante Es
WHERE Es.CodProducto = "PROD12345677";

-- Stock tras la inseción 
+--------------+--------------+-------+
| NombreEst    | CodProducto  | Stock |
+--------------+--------------+-------+
| Estante CCTV | PROD12345677 |    10 |
+--------------+--------------+-------+

-- Bugs Fixed
-- Trigger que cuando se inserte un Producto también lo inserte en su Tabla Correspondiente
-- en función de su tipo 

DELIMITER $$
DROP TRIGGER IF EXISTS cctv_guard $$
CREATE TRIGGER cctv_guard
BEFORE INSERT ON CCTV
FOR EACH ROW
BEGIN
    DECLARE Tipo_prod VARCHAR(30);
    DECLARE my_error CONDITION FOR SQLSTATE '45000';

    SELECT Producto.tipo 
    INTO Tipo_prod 
    FROM Producto 
    WHERE CodProducto = NEW.CodProducto;

    IF Tipo_prod != "CCTV" THEN 
        SIGNAL my_error SET MESSAGE_TEXT = "El Producto no es CCTV";
    END IF;

END $$
DELIMITER ;

DELIMITER $$
DROP TRIGGER IF EXISTS cableado_guard $$
CREATE TRIGGER cableado_guard
BEFORE INSERT ON Cableado
FOR EACH ROW
BEGIN
    DECLARE Tipo_prod VARCHAR(30);
    DECLARE my_error CONDITION FOR SQLSTATE '45000';

    SELECT Producto.tipo 
    INTO Tipo_prod 
    FROM Producto 
    WHERE CodProducto = NEW.CodProducto;

    IF Tipo_prod != "Cableado" THEN 
        SIGNAL my_error SET MESSAGE_TEXT = "El Producto no es Cableado";
    END IF;

END $$
DELIMITER ;

DELIMITER $$
DROP TRIGGER IF EXISTS intrusion_guard $$
CREATE TRIGGER intrusion_guard
BEFORE INSERT ON Intrusion
FOR EACH ROW
BEGIN
    DECLARE Tipo_prod VARCHAR(30);
    DECLARE my_error CONDITION FOR SQLSTATE '45000';

    SELECT Producto.tipo 
    INTO Tipo_prod 
    FROM Producto 
    WHERE CodProducto = NEW.CodProducto;

    IF Tipo_prod != "Intrusion" THEN 
        SIGNAL my_error SET MESSAGE_TEXT = "El Producto no es Intrusion";
    END IF;

END $$
DELIMITER ;

-- Casos de Prueba

INSERT INTO CCTV VALUES
("PROD12345674","INTR12345678","Camaras",NULL,"IP",8,NULL);

INSERT INTO Cableado VALUES
("PROD12345674","CBLD12345678","Cable de Camara","UTP",NULL,NULL);

INSERT INTO Intrusion VALUES
("PROD12345678","INTR12345678","Centrales Alarmas",4);