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