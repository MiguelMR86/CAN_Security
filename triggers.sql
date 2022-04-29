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

        IF NEW.Precio > precioProducto THEN

            UPDATE Producto
            SET Producto.Precio = NEW.PrecioCompra
            FROM Producto
            WHERE Producto.CodProducto = NEW.CodProducto;

        END IF;

    END IF;

END $$
DELIMITER ;