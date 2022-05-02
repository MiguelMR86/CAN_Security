-- Fecha de Salida Minima
SELECT Pr.* 
FROM Producto Pr
WHERE Pr.FechaRetirada IN (SELECT MIN(Producto.FechaRetirada) FROM Producto);

-- Fecha de Salida Maxima
SELECT Pr.* 
FROM Producto Pr
WHERE Pr.FechaRetirada IN (SELECT MIN(Producto.FechaRetirada) FROM Producto);

-- Fecha de Entrada Minima
SELECT Pr.* 
FROM Producto Pr
WHERE Pr.FechaRetirada IN (SELECT MIN(Producto.FechaEntrada) FROM Producto);

-- Fecha de Entradas Maxima
SELECT Pr.* 
FROM Producto Pr
WHERE Pr.FechaRetirada IN (SELECT MIN(Producto.FechaEntrada) FROM Producto);