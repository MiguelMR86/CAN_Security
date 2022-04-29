DROP DATABASE IF EXISTS cansecurity;
CREATE DATABASE cansecurity;
USE cansecurity;

-- Tablas Proveedores
CREATE TABLE  Proveedor(
    CodProveedor INT PRIMARY KEY AUTO_INCREMENT,
    Telefono VARCHAR(9) NOT NULL,
    Correo VARCHAR(50) NOT NULL,
    NombreFiscal VARCHAR(30) NOT NULL,
    NIF VARCHAR(9) NOT NULL ,
    CodResp INT NOT NULL
);

-- Tabla de Responsable del Proveedor
CREATE TABLE Responsable_Proveedor(
    CodResponsable INT PRIMARY KEY,
    Nombre VARCHAR(50) NOT NULL,
    ContactoFacturacion  VARCHAR(9) NOT NULL
);

-- Alter table Responsable del Proveedor - Proveedores
ALTER TABLE Proveedor ADD FOREIGN KEY (CodResp) REFERENCES Responsable_Proveedor(CodResponsable) ON UPDATE CASCADE;

-- Tabla de Pedidos
CREATE TABLE Pedido(
    NumPedido VARCHAR(12) PRIMARY KEY,
    ProductosPedidos VARCHAR(8000) NOT NULL,
    CodProveedor INT NOT NULL
);

-- Alter table Pedido - Proveedor
ALTER TABLE Pedido ADD FOREIGN KEY (CodProveedor) REFERENCES Proveedor(CodProveedor) ON UPDATE CASCADE;

-- Tabla de Productos 
CREATE TABLE Producto(
    CodProducto VARCHAR(12) PRIMARY KEY,
    Nombre VARCHAR(35) NOT NULL,
    Precio DEC(5,2) NOT NULL,
    Caracteristicas VARCHAR(8000),
    FechaDisponibilidad DATE,
    DescripcionCorta VARCHAR(4000),
    Tipo ENUM('CCTV','Intrusion','Cableado') NOT NULL,
    FechaEntrada DATE,
    FechaRetirada DATE,
    CodEmpleado VARCHAR(20)
);

-- Tabla de Pedido - Producto
CREATE TABLE Pedido_Producto(
    CodProducto VARCHAR(12),
    NumPedido VARCHAR(12),
    Cantidad INT NOT NULL,
    PrecioCompra DEC(5,2) NOT NULL, 
    PRIMARY KEY(CodProducto, NumPedido)
);

-- Introduciendo claves ajenas Pedido_Producto
ALTER TABLE Pedido_Producto ADD FOREIGN KEY (CodProducto) REFERENCES Producto(CodProducto) ON UPDATE CASCADE ON DELETE CASCADE;
ALTER TABLE Pedido_Producto ADD FOREIGN KEY (NumPedido) REFERENCES Pedido(NumPedido) ON UPDATE CASCADE ON DELETE CASCADE;

-- Ponemos todos los atributos hijos dentro del padre
-- CCTV
CREATE TABLE CCTV(
    CodProducto VARCHAR(12),
    CodCctv VARCHAR(12),
    Tipo ENUM('Grabadores','Camaras','Monitores','Switch') NOT NULL,
    TipoGrabador ENUM('Analogico','IP'),
    TipoCamara ENUM('Analogico','IP'),
    CalidadPantalla INT,
    CalidadSwitch INT,
    PRIMARY KEY(CodProducto,CodCctv)
);

-- Introduciendo claves ajenas CCTV
ALTER TABLE CCTV ADD FOREIGN KEY (CodProducto) REFERENCES Producto(CodProducto) ON UPDATE CASCADE ON DELETE CASCADE;

-- Intrusion
CREATE TABLE Intrusion(
    CodProducto VARCHAR(12),
    CodIntrusion VARCHAR(12),
    Tipo ENUM('Centrales Alarmas','Teclado','Volumetricos','Contactos Magneticos') NOT NULL,
    ZonasAbarcadas INT,
    PRIMARY KEY(CodProducto,CodIntrusion)
);

-- Introduciendo claves ajenas Intrusion
ALTER TABLE Intrusion ADD FOREIGN KEY (CodProducto) REFERENCES Producto(CodProducto) ON UPDATE CASCADE ON DELETE CASCADE;

-- Cableado
CREATE TABLE Cableado(
    CodProducto VARCHAR(12),
    CodCableado VARCHAR(12),
    Tipo ENUM('Cable de Camara','Alarma','PCI','Energia') NOT NULL,
    TipoCableCam ENUM('Coaxial','UTP','Fibra Optica'),
    TipoPCI ENUM('Pares Trenzados','Tubo + Cable'),
    TipoEnergia ENUM('Unipolar','Cable Manguera'),
    PRIMARY KEY(CodProducto,CodCableado)
);

-- Introduciendo claves ajenas Cableado
ALTER TABLE Cableado ADD FOREIGN KEY (CodProducto) REFERENCES Producto(CodProducto) ON UPDATE CASCADE ON DELETE CASCADE;

-- Estantes
CREATE TABLE Estante(
    NombreEst VARCHAR(30) NOT NULL,
    CodProducto VARCHAR(12) NOT NULL,
    Stock INT NOT NULL DEFAULT 0,
    PRIMARY KEY(NombreEst,CodProducto)
);

-- Alter table Estante - Producto
ALTER TABLE Estante ADD FOREIGN KEY (CodProducto) REFERENCES Producto(CodProducto) ON UPDATE CASCADE ON DELETE CASCADE;

-- Empleado - Proyecto
CREATE TABLE Empleado(
    CodEmpleado VARCHAR(20) PRIMARY KEY,
    Nombre VARCHAR(50) NOT NULL,
    Tipo ENUM('Propio', 'Subcontratado') NOT NULL,
    NombreEmpresa VARCHAR(30)
);

-- Alte table Empleado - Producto
ALTER TABLE Producto ADD FOREIGN KEY (CodEmpleado) REFERENCES Empleado (CodEmpleado) ON UPDATE CASCADE;

CREATE TABLE Proyecto(
    CodProyecto VARCHAR(20) PRIMARY KEY,
    Descripcion VARCHAR(4000),
    Tipo ENUM('Basico','Aviso') NOT NULL
);

-- Tabla de relacion entre empleado y proyecto
CREATE TABLE Empleado_Proyecto(
    CodEmpleado VARCHAR(20),
    CodProyecto VARCHAR(20),
    PRIMARY KEY(CodEmpleado, CodProyecto)
);

-- Introduciendo claves ajenas Empleado_Proyecto
ALTER TABLE Empleado_Proyecto ADD FOREIGN KEY (CodEmpleado) REFERENCES Empleado(CodEmpleado) ON UPDATE CASCADE;
ALTER TABLE Empleado_Proyecto ADD FOREIGN KEY (CodProyecto) REFERENCES Proyecto(CodProyecto) ON UPDATE CASCADE ON DELETE CASCADE;

-- Tabla de informacion de retrida
CREATE TABLE Info_Retirada(
    CodEmpleado VARCHAR(20),
    NombreEmpleado VARCHAR(50),
    Producto VARCHAR(35)
);

-- Insercion de Datos

-- Responsable_Proveedor
INSERT INTO Responsable_Proveedor VALUES 
(1,"Miguel Angel","605432123"),
(2,"Aitor","606755657"),
(3,"Romarei","605453212"),
(4,"Mario","604546560"),
(5,"Ivan","679543215"),
(6,"Angel Luis","765432123");

-- Proveedor
INSERT INTO Proveedor (Telefono,Correo,NombreFiscal,NIF,CodResp) VALUES 
("928765536","soluciones@global.com","Global Soluciones","12345678A",1),
("928546789","seguridad@tearseg.com","Tearseg Seguridad","12345678B",1),
("928467986","seguri@can.com","SeguriCan","12345678C",2),
("928753421","seguridad@visor.com","Visor Seguridad","12345678D",1),
("928456734","segur@protech.com","SegurProtech","12345678E",3),
("928324567","seguridad@ecu.com","Ecu Seguridad","12345678F",6);

-- Empleado
INSERT INTO Empleado VALUES
("EMP123456789","Paco Martel Hernandez","Propio",NULL),
("EMP123456788","Andrea Melian Jimenez","Propio",NULL),
("EMP123456787","Alberto Medina Suarez","Subcontratado","SeguriCan"),
("EMP123456786","Juan Garcia Cordero","Subcontratado","Global Soluciones"),
("EMP123456785","Jose Carlos Gonzalez Calcines","Propio",NULL); -- No tiene proyectos asignados

-- Proyecto
INSERT INTO Proyecto VALUES
("PROY123456789","Centro cormercial de los Alisios, instalacion completa de un sistema de seguridad y alarmas","Aviso"),
("PROY123456788","Telde, Calle Diamante, primer B portal, A, Instalacion de un sistema de y alarmas","Basico"),
("PROY123456787","Metal Agricola S.L, Instalacion completa de un sistema de seguridad","Aviso"),
("PROY123456786","Telde, Calle Alexander Fleming, Instalacion de un sistema de alarmas","Aviso"),
("PROY123456785","Las Palmas, Calle Alfredo Calderon segundo B, Portal C, Instalacion de un sistema de seguridad y alarmas","Basico");

-- Empleado Proyecto
INSERT INTO Empleado_Proyecto VALUES
("EMP123456789","PROY123456789"),
("EMP123456789","PROY123456788"),
("EMP123456788","PROY123456787"),
("EMP123456787","PROY123456786"),
("EMP123456786","PROY123456785");

-- Pedido
INSERT INTO Pedido VALUES 
("PED123456789","Camara Fibra Optica, Switch POE, Cable UTP",1),
("PED123456781","PCI Tubo + Cable, Switch POE, Sensor de Movimiento",1),
("PED123456782","Camara Fibra Optica, Cable de Energia Unipolar, Camara Analogica",3),
("PED123456783","Switch POE, Control de Acceso, Cierre Magnetico",4),
("PED123456784","Cable UTP, Cable Coaxial, Cable de Fibra Optica",5);

-- Producto
INSERT INTO Producto VALUES
("PROD12345678","Camara Fibra Optica",323.2,"8mpx, vista angular, giro de 360",NULL,"Camara de conexion con fibra optica","CCTV","2020-11-12","2020-12-11","EMP123456789"),
("PROD12345677","Switch POE",50.32,"8 entradas, hecho de PLC",NULL,NULL,"CCTV","2020-10-09",NULL,NULL),
("PROD12345676","Cable UTP",12.2,"8m de cable",NULL,NULL,"Cableado","2020-01-15",NULL,"EMP123456788"),
("PROD12345675","PCI Tubo + Cable",10.5,"8m de cable",NULL,NULL,"Cableado","2020-02-05","2020-09-15","EMP123456786"),
("PROD12345674","Sensor de Movimiento",450.5,"Alcance 10m, luz infrarrojos","2021-01-10","Alcance corto","Intrusion",NULL,NULL,NULL),
("PROD12345673","Cable de Energia Unipolar",5.0,"8m de cable",NULL,"Cable forrado de direccion unica","Cableado","2020-02-16","2020-05-21","EMP123456789"),
("PROD12345672","Camara Analogica",150.99,"4mpx, vista analogica, giro de 120","2021-12-10",NULL,"CCTV",NULL,NULL,NULL),
("PROD12345671","Control de Acceso",100.50,"Panel integrado","2021-12-10",NULL,"Intrusion",NULL,NULL,"EMP123456785"),
("PROD12345670","Cierre Magnetico",200.25,"Cierre multiple",NULL,"De insercion en pared","Intrusion","2020-02-18","2020-09-11","EMP123456789"),
("PROD12345679","Cable Coaxial",3.2,"8m de cable",NULL,NULL,"Cableado","2020-04-26","2020-09-03","EMP123456786"),
("PROD12345611","Cable de Fibra Optica",10.8,"8m de cable","2021-12-02",NULL,"Cableado",NULL,NULL,"EMP123456787");

-- Pedido Producto
INSERT INTO Pedido_Producto VALUES 
("PROD12345678","PED123456789",3,350.50), 
("PROD12345677","PED123456789",5,120.10),
("PROD12345676","PED123456789",10,10.20),
("PROD12345675","PED123456781",12,8.30),
("PROD12345677","PED123456781",4,130.20),
("PROD12345674","PED123456781",2,30.30),
("PROD12345678","PED123456782",6,350.50),
("PROD12345673","PED123456782",15,3.00),
("PROD12345672","PED123456782",4,500.20),
("PROD12345677","PED123456783",7,120.10),
("PROD12345671","PED123456783",5,100.20),
("PROD12345670","PED123456783",4,50.20),
("PROD12345676","PED123456784",7,10.20),
("PROD12345679","PED123456784",10,7.90),
("PROD12345611","PED123456784",13,15.20);

-- CCTV
INSERT INTO CCTV VALUES
("PROD12345678","CCTV12345678","Camaras",NULL,"IP",8,NULL),
("PROD12345677","CCTV12345677","Switch",NULL,NULL,NULL,12),
("PROD12345672","CCTV12345672","Camaras",NULL,"Analogica",16,NULL);

-- Intrusion
INSERT INTO Intrusion VALUES
("PROD12345674","INTR12345678","Centrales Alarmas",4),
("PROD12345671","INTR12345677","Teclado",NULL),
("PROD12345670","INTR12345676","Contactos Magneticos",NULL);

-- Cableado
INSERT INTO Cableado VALUES
("PROD12345676","CBLD12345678","Cable de Camara","UTP",NULL,NULL),
("PROD12345675","CBLD12345677","PCI",NULL,"Tubo + Cable",NULL),
("PROD12345673","CBLD12345676",NULL,NULL,NULL,"Unipolar"),
("PROD12345679","CBLD12345675","Cable de Camara","Coaxial",NULL,NULL),
("PROD12345611","CBLD12345674","Cable de Camara","Fibra Optica",NULL,NULL);

-- Estante 
INSERT INTO Estante VALUES
("Estante CCTV","PROD12345678",10),
("Estante Cableado","PROD12345675",0),
("Estante Cableado","PROD12345679",15),
("Estante Cableado","PROD12345611",20),
("Estante CCTV","PROD12345672",30),
("Estante Intrusion","PROD12345671",0),
("Estante CCTV","PROD12345677",4),
("Estante Intrusion","PROD12345670",3),
("Estante Cableado","PROD12345673",17),
("Estante Prueba","PROD12345673",17),
("Estante Intrusion","PROD12345674",8);

-- Prueba para el Procedimiento productos_en_stock
INSERT INTO Estante VALUES 
("Estante Prueba","PROD12345673",0),
("Estante Prueba","PROD12345674",0);