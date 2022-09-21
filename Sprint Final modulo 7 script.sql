-- Sprint Final Modulo 7
-- Integrantes: Carlos Rozas, Carlos Vasquez, Augusto Reyes, Carlos Toledo


CREATE DATABASE telovendofinal; -- Creación base de datos nueva para el trabajo final
USE telovendofinal; -- Para usar la base de datos 

CREATE USER 'administrador'@'localhost' IDENTIFIED BY '1234'; -- Creación de usuario "Administrador"
GRANT CREATE,  DELETE,  UPDATE, SELECT, INSERT ON telovendofinal.* TO 'administrador'@'localhost'; -- Otorgamiento de accesos y funciones



-- -----------------------------------------------------
-- Table telovendofinal.categoria
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS telovendofinal.categoria (
  id_categoria INT NOT NULL AUTO_INCREMENT,
  nombre VARCHAR(45) NULL,
  PRIMARY KEY (id_categoria))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table telovendofinal.producto
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS telovendofinal.producto (
  id_producto INT NOT NULL AUTO_INCREMENT,
  nombre VARCHAR(45) NULL,
  id_categoria_fk INT NULL,
  stock INT NULL,
  precio INT NULL,
  color VARCHAR(45) NULL,
  PRIMARY KEY (id_producto),
  INDEX fk_categoria_idx (id_categoria_fk ASC) VISIBLE,
  CONSTRAINT fk_categoria
    FOREIGN KEY (id_categoria_fk)
    REFERENCES telovendofinal.categoria (id_categoria)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table telovendofinal.cliente
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS telovendofinal.cliente (
  id_cliente INT NOT NULL AUTO_INCREMENT,
  nombre VARCHAR(45) NULL,
  apellido VARCHAR(45) NULL,
  direccion VARCHAR(45) NULL,
  telefono INT NULL,
  PRIMARY KEY (id_cliente))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table telovendofinal.pedido
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS telovendofinal.pedido (
  id_pedidos INT NOT NULL AUTO_INCREMENT,
  id_cliente INT NULL,
  fecha_pedido DATE NULL,
  estado_pedido VARCHAR(45) NULL,
  fecha_entrega DATE NULL,
  PRIMARY KEY (id_pedidos),
  INDEX fk_cliente_idx (id_cliente ASC) VISIBLE,
  CONSTRAINT fk_cliente
    FOREIGN KEY (id_cliente)
    REFERENCES telovendofinal.cliente (id_cliente)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table telovendofinal.repartidor
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS telovendofinal.repartidor (
  id_repartidor INT NOT NULL,
  nombre VARCHAR(45) NULL,
  apellido VARCHAR(45) NULL,
  telefono INT NULL,
  empresa_delivery VARCHAR(45) NULL,
  PRIMARY KEY (id_repartidor))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table telovendofinal.seguimiento
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS telovendofinal.seguimiento (
  id_segumiento INT NOT NULL AUTO_INCREMENT,
  id_pedido INT NOT NULL,
  id_repatidor INT NULL,
  PRIMARY KEY (id_segumiento),
  INDEX fk_seg_pedido_idx (id_pedido ASC) VISIBLE,
  INDEX fk_repartidor_idx (id_repatidor ASC) VISIBLE,
  UNIQUE INDEX id_pedido_UNIQUE (id_pedido ASC) VISIBLE,
  CONSTRAINT fk_seg_pedido
    FOREIGN KEY (id_pedido)
    REFERENCES telovendofinal.pedido (id_pedidos)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT fk_repartidor
    FOREIGN KEY (id_repatidor)
    REFERENCES telovendofinal.repartidor (id_repartidor)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table telovendofinal.reportes_estadistica
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS telovendofinal.reportes_estadistica (
  id_estadisticas INT NOT NULL AUTO_INCREMENT,
  num_clientes INT NULL,
  productos_en_stock INT NULL,
  ventas_totales INT NULL,
  cant_pedidos_vendedor INT NULL,
  PRIMARY KEY (id_estadisticas))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table telovendofinal.proveedor
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS telovendofinal.proveedor (
  id_proveedor INT NOT NULL AUTO_INCREMENT,
  nom_rep_legal VARCHAR(45) NULL,
  nom_corporativo VARCHAR(45) NULL,
  nom_contacto VARCHAR(45) NULL,
  PRIMARY KEY (id_proveedor))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table telovendofinal.telefono
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS telovendofinal.telefono (
  id_telefono INT NOT NULL AUTO_INCREMENT,
  id_proveedor_fk INT NULL,
  telefono INT NULL,
  PRIMARY KEY (id_telefono),
  INDEX fk_telefono_idx (id_proveedor_fk ASC) VISIBLE,
  CONSTRAINT fk_telefono
    FOREIGN KEY (id_proveedor_fk)
    REFERENCES telovendofinal.proveedor (id_proveedor)
    ON DELETE SET NULL
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table telovendofinal.proveedor_categoria
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS telovendofinal.proveedor_categoria (
  proveedor_id_proveedor INT NOT NULL,
  categoria_id_categoria INT NOT NULL,
  INDEX fk_proveedor_has_categoria_categoria1_idx (categoria_id_categoria ASC) VISIBLE,
  INDEX fk_proveedor_has_categoria_proveedor1_idx (proveedor_id_proveedor ASC) VISIBLE,
  CONSTRAINT fk_proveedor_has_categoria_proveedor1
    FOREIGN KEY (proveedor_id_proveedor)
    REFERENCES telovendofinal.proveedor (id_proveedor)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT fk_proveedor_has_categoria_categoria1
    FOREIGN KEY (categoria_id_categoria)
    REFERENCES telovendofinal.categoria (id_categoria)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table telovendofinal.proveedor_producto
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS telovendofinal.proveedor_producto (
  proveedor_id_proveedor INT NOT NULL,
  producto_id_producto INT NOT NULL,
  INDEX fk_proveedor_has_producto_producto1_idx (producto_id_producto ASC) VISIBLE,
  INDEX fk_proveedor_has_producto_proveedor1_idx (proveedor_id_proveedor ASC) VISIBLE,
  CONSTRAINT fk_proveedor_has_producto_proveedor1
    FOREIGN KEY (proveedor_id_proveedor)
    REFERENCES telovendofinal.proveedor (id_proveedor)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT fk_proveedor_has_producto_producto1
    FOREIGN KEY (producto_id_producto)
    REFERENCES telovendofinal.producto (id_producto)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table telovendofinal.pedido_producto
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS telovendofinal.pedido_producto (
  pedido_id_pedidos INT NOT NULL,
  cantidad INT NULL,
  producto_id_producto INT NOT NULL,
  INDEX fk_pedido_has_producto_producto1_idx (producto_id_producto ASC) VISIBLE,
  INDEX fk_pedido_has_producto_pedido1_idx (pedido_id_pedidos ASC) VISIBLE,
  CONSTRAINT fk_pedido_has_producto_pedido1
    FOREIGN KEY (pedido_id_pedidos)
    REFERENCES telovendofinal.pedido (id_pedidos)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT fk_pedido_has_producto_producto1
    FOREIGN KEY (producto_id_producto)
    REFERENCES telovendofinal.producto (id_producto)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table telovendofinal.factura
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS telovendofinal.factura (
  id_factura INT NOT NULL,
  id_pedido_fk INT NULL,
  PRIMARY KEY (id_factura),
  INDEX fk_pedido_idx (id_pedido_fk ASC) VISIBLE,
  CONSTRAINT fk_pedido
    FOREIGN KEY (id_pedido_fk)
    REFERENCES telovendofinal.pedido (id_pedidos)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- Ingreso 5 proveedores:

INSERT INTO telovendofinal.proveedor (id_proveedor, nom_rep_legal, nom_corporativo, nom_contacto) VALUES (1, 'Daniel Perez', 'Frucola', 'Juanita');
INSERT INTO telovendofinal.proveedor (id_proveedor, nom_rep_legal, nom_corporativo, nom_contacto) VALUES (2, 'Roberto Morán', 'Electroman', 'Carlos');
INSERT INTO telovendofinal.proveedor (id_proveedor, nom_rep_legal, nom_corporativo, nom_contacto) VALUES (3, 'María Luna', 'Ropero Feliz', 'María');
INSERT INTO telovendofinal.proveedor (id_proveedor, nom_rep_legal, nom_corporativo, nom_contacto) VALUES (4, 'Pedro Puebla', 'Frutas del Paíz', 'Manuel');
INSERT INTO telovendofinal.proveedor (id_proveedor, nom_rep_legal, nom_corporativo, nom_contacto) VALUES (5, 'Marta Sierra', 'Electrónica Nacional', 'Tomás');


-- Ingreso 2 teléfonos por proveedor:
INSERT INTO telovendofinal.telefono (id_telefono, id_proveedor_fk, telefono) VALUES (1, 1, 878876648);
INSERT INTO telovendofinal.telefono (id_telefono, id_proveedor_fk, telefono) VALUES (2, 1, 787766443);
INSERT INTO telovendofinal.telefono (id_telefono, id_proveedor_fk, telefono) VALUES (3, 2, 898633552);
INSERT INTO telovendofinal.telefono (id_telefono, id_proveedor_fk, telefono) VALUES (4, 2, 986344343);
INSERT INTO telovendofinal.telefono (id_telefono, id_proveedor_fk, telefono) VALUES (5, 3, 924422442);
INSERT INTO telovendofinal.telefono (id_telefono, id_proveedor_fk, telefono) VALUES (6, 3, 953535353);
INSERT INTO telovendofinal.telefono (id_telefono, id_proveedor_fk, telefono) VALUES (7, 4, 924422442);
INSERT INTO telovendofinal.telefono (id_telefono, id_proveedor_fk, telefono) VALUES (8, 4, 997262255);
INSERT INTO telovendofinal.telefono (id_telefono, id_proveedor_fk, telefono) VALUES (9, 5, 737373377);
INSERT INTO telovendofinal.telefono (id_telefono, id_proveedor_fk, telefono) VALUES (10, 5, 926262422);


-- Ingreso de categorías 
INSERT INTO telovendofinal.categoria (id_categoria, nombre) VALUES (1, 'frutas');
INSERT INTO telovendofinal.categoria (id_categoria, nombre) VALUES (2, 'electrónica');
INSERT INTO telovendofinal.categoria (id_categoria, nombre) VALUES (3, 'vestimenta');
INSERT INTO telovendofinal.categoria (id_categoria, nombre) VALUES (4, 'abarrotes');
INSERT INTO telovendofinal.categoria (id_categoria, nombre) VALUES (5, 'computación');




-- Ingreso relaciones Proveedor con su Categiría:
INSERT INTO telovendofinal.proveedor_categoria VALUES (1,1), (2,2), (3,3), (4,1), (5,2);


-- Ingreso de 10 productos:
INSERT INTO telovendofinal.producto (id_producto, nombre, id_categoria_fk, stock, precio, color) VALUES (1, 'manzana roja', 1, 100, 300, 'rojo');
INSERT INTO telovendofinal.producto (id_producto, nombre, id_categoria_fk, stock, precio, color) VALUES (2, 'zapatos', 3, 30, 25000, 'café');
INSERT INTO telovendofinal.producto (id_producto, nombre, id_categoria_fk, stock, precio, color) VALUES (3, 'celulares', 2, 50, 145000, 'negro');
INSERT INTO telovendofinal.producto (id_producto, nombre, id_categoria_fk, stock, precio, color) VALUES (4, 'frutillas', 1, 130, 900, 'rojo');
INSERT INTO telovendofinal.producto (id_producto, nombre, id_categoria_fk, stock, precio, color) VALUES (5, 'polera', 3, 40, 19000, 'blanca');
INSERT INTO telovendofinal.producto (id_producto, nombre, id_categoria_fk, stock, precio, color) VALUES (6, 'fideos', 4, 70, 990, 'cafe');
INSERT INTO telovendofinal.producto (id_producto, nombre, id_categoria_fk, stock, precio, color) VALUES (7, 'computadores', 5, 10, 290000, 'blanco');
INSERT INTO telovendofinal.producto (id_producto, nombre, id_categoria_fk, stock, precio, color) VALUES (8, 'memoria ram 4GB', 5, 80, 39000, 'verde');
INSERT INTO telovendofinal.producto (id_producto, nombre, id_categoria_fk, stock, precio, color) VALUES (9, 'jeans', 3, 70, 24000, 'azul');
INSERT INTO telovendofinal.producto (id_producto, nombre, id_categoria_fk, stock, precio, color) VALUES (10, 'arroz', 4, 80, 1200, 'blanco');


-- Cuál es la categoría de productos que más se repite.
-- Este query entrega la categoría que más se repite. Debido a que pueden ser "varias" las categorías que más se 
-- repiten, se realizan dos tablas (ta y tb). La tabla "ta" cuenta las categorías y las agrupa por su cantidad.
-- La tabla "tb" agrupa por cantidad y las ordenda de mayor a menor y saca el valor más alto (entrega un número).
-- Luego, con un INNER JOIN (segundo), se obtiene la (o las) categoría con más cantidad o que se repiten. 
-- Con el INNER JOIN (primero) se obtiene el nombre de la categoría

SELECT ca.nombre, res.co FROM categoria as ca
INNER JOIN -- (Primero)
	(SELECT ta.id_categoria_fk, ta.cont AS co FROM 
		(SELECT id_categoria_fk, COUNT(id_categoria_fk) AS cont FROM producto
		GROUP BY id_categoria_fk) AS ta -- Tabla "ta" (agrupa por cantidad)
	INNER JOIN -- (Segundo)
		(SELECT id_categoria_fk, COUNT(id_categoria_fk) AS cont FROM producto
		GROUP BY id_categoria_fk ORDER BY cont DESC LIMIT 1) AS tb -- Tabla "tb" (saca el valor máximo de la agrupación)
	ON ta.cont = tb.cont) 
    AS res --
ON ca.id_categoria = res.co;
-- R: La categoría que más se repite es vestimenta con 3 artículos






-- Cuáles son los productos con mayor stock
SELECT nombre, stock FROM producto
ORDER BY stock DESC LIMIT 3;
-- R: Los tres productos con más stock son: frutillas con 130 unidades, manzana roja con 100 y arroz con 80




-- Qué color de producto es más común en nuestra tienda.
-- Este query entrega el color que más se repite. Debido a que pueden ser "varios" los colores que más se 
-- repiten, se realizan dos tablas (ta y tb). La tabla "ta" cuenta los coloress y los agrupa por su cantidad.
-- La tabla "tb" agrupa por cantidad y los ordenda de mayor a menor y saca el valor más alto (entrega un número).
-- Luego, con un INNER JOIN se obtiene los colores con más cantidad o que se repiten. 

SELECT ta.color, ta.cont FROM 
	(SELECT color, count(color) as cont FROM producto GROUP BY color) as ta -- Tabla "ta" 
INNER JOIN 
	(SELECT COUNT(color) AS cont FROM producto GROUP BY color ORDER BY cont DESC LIMIT 1) AS tb -- Tabla "tb"
ON tb.cont = ta.cont;
-- Los colores que más se repiten es el rojo, café y blanco





-- Cual o cuales son los proveedores con menor stock de productos.
-- El siguiente query entrega los 3 proveedores con menos stock. El primer INNER JOIN relaciona los 3 productos con
-- menos stock con su proveedor basado en su llave foranea, de este se obtiene los id de los proveedores con
-- menos stock. El segundo INNER JOIN relaciona su id con el nombre.

SELECT pro.nom_corporativo, tot.sst as 'Stock', tot.nn as 'Producto' FROM proveedor AS pro
INNER JOIN -- (Segundo)
(SELECT pc.proveedor_id_proveedor as idp, ca.stock as sst, ca.nombre as nn FROM proveedor_categoria AS pc
INNER JOIN -- (Primero)
(SELECT id_categoria_fk, stock, nombre FROM producto ORDER BY stock ASC LIMIT 3) AS ca
ON pc.proveedor_id_proveedor = ca.id_categoria_fk) AS tot
ON pro.id_proveedor = tot.idp;
-- Los tres proveedores con menos stock son: Electrónica Nacional con 10 productos (Computadores), Ropero Feliz con
-- 30 productos (zapatos) y Ropero Feliz con 40 productos (poleras). 




-- Cambien la categoría de productos más popular por ‘Electrónica y computación’.
-- Supuesto: La categoría más popular es "Vestimenta", ID = 3

UPDATE telovendofinal.categoria SET nombre = 'Electrónica y computación' WHERE (id_categoria = 3);
