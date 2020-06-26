CREATE DATABASE prueba;
\c prueba;

-----------------------------------CREAR TABLAS Y RELACIONAR ATRIBUTOS----------------------------------------

CREATE TABLE cliente(
    id_cliente SERIAL,
    nombre VARCHAR(25),
    rut VARCHAR(25),
    direccion VARCHAR(50),
    PRIMARY KEY (id_cliente));

--NO se agregan los campos subtotal, ni total, ni nada, porque todos esos campos se CALCULAN a partir del precio y la cantidad (datos existentes en otras tablas).
CREATE TABLE factura(
    numero INT,
    fecha DATE,
    cliente_asociado INT,
    PRIMARY KEY (numero),
    FOREIGN KEY (cliente_asociado) REFERENCES
    cliente(id_cliente));


CREATE TABLE categoria(
    id_categoria SERIAL,
    nombre VARCHAR(25),
    descripcion VARCHAR(100),
    PRIMARY KEY (id_categoria));

CREATE TABLE producto(
    id_producto SERIAL,
    nombre VARCHAR(25),
    descripcion VARCHAR(100),
    precio_unitario INT,
    categoria_producto INT,
    PRIMARY KEY (id_producto),
    FOREIGN KEY (categoria_producto) REFERENCES
    categoria(id_categoria));

CREATE TABLE tiene_producto(
    numero_factura INT,
    producto INT, 
    cantidad_producto INT,
    PRIMARY KEY (numero_factura, producto),
    FOREIGN KEY (numero_factura) REFERENCES
    factura(numero),
    FOREIGN KEY (producto) REFERENCES
    producto(id_producto));

--Preguntar por almacenamiento de subtotal

-----------------------------------------AGREGAR REGISTROS A TABLAS-----------------------------------------------------

--SE AGREGAN 5 REGISTROS A LA TABLA CLIENTE 
INSERT INTO cliente(nombre, rut, direccion) VALUES ('Catalina', '11223344-5', 'Pasaje algo #123');
INSERT INTO cliente(nombre, rut, direccion) VALUES ('Veronica', '55667788-9', 'Avenida algo #456');
INSERT INTO cliente(nombre, rut, direccion) VALUES ('Diego', '10111213-1', 'Villa algo #789');
INSERT INTO cliente(nombre, rut, direccion) VALUES ('Don Titi', '14151617-1', 'Barrio algo #1011');
INSERT INTO cliente(nombre, rut, direccion) VALUES ('Isidora', '18192021-1', 'Universo algo #1213');

--SE AGREGAN 3 REGISTROS A LA TABLA CATEGORIA
INSERT INTO categoria(nombre, descripcion) VALUES ('Dulces pequeños', 'Comestibles dulces en formatos de 100gr');
INSERT INTO categoria(nombre, descripcion) VALUES ('Salados pequeños', 'Comestibles salados en formatos de 200gr');
INSERT INTO categoria(nombre, descripcion) VALUES ('Acidos grandes', 'Comestibles acidos en bolsas de 1KG o botellas de 1L');

--SE AGREGAN 8 REGISTROS A LA TABLA PRODUCTO
INSERT INTO producto(nombre, descripcion, precio_unitario, categoria_producto) VALUES ('Chocolate','Chocolate amargo en barra', 200, 1);
INSERT INTO producto(nombre, descripcion, precio_unitario, categoria_producto) VALUES ('Papas fritas', 'Papas fritas en bolsa', 50, 2);
INSERT INTO producto(nombre, descripcion, precio_unitario, categoria_producto) VALUES ('Frambuesas', 'Frambuesas congeladas en bolsa', 350, 3);
INSERT INTO producto(nombre, descripcion, precio_unitario, categoria_producto) VALUES ('Sopaipillas', 'Bolsa de 10 masas de sopaipillas', 100, 2);
INSERT INTO producto(nombre, descripcion, precio_unitario, categoria_producto) VALUES ('Jugo de maracuyá', 'Jugo en botella de pulpa de maracuyá', 300, 3);
INSERT INTO producto(nombre, descripcion, precio_unitario, categoria_producto) VALUES ('Yogurt de vainilla', 'Yogurt de proteina sabor vainilla', 40, 1);
INSERT INTO producto(nombre, descripcion, precio_unitario, categoria_producto) VALUES ('Tortillas de maiz', 'Snack en bolsa de tortillas', 80, 2);
INSERT INTO producto(nombre, descripcion, precio_unitario, categoria_producto) VALUES ('Jugo de limón-menta', 'Jugo en botella de pulpa de limon con toques de menta', 300, 3);

--SE AGREGAN 10 REGISTROS A LA TABLA FACTURA, PARA CREAR LAS FACTURAS (SIN PRODUCTOS AÚN)
INSERT INTO factura(numero, fecha, cliente_asociado) VALUES (1234, '2020-01-01', 1);
INSERT INTO factura(numero, fecha, cliente_asociado) VALUES (1235, '2020-01-02', 1);
INSERT INTO factura(numero, fecha, cliente_asociado) VALUES (1236, '2020-01-03', 2);
INSERT INTO factura(numero, fecha, cliente_asociado) VALUES (1237, '2020-01-04', 2);
INSERT INTO factura(numero, fecha, cliente_asociado) VALUES (1238, '2020-01-05', 2);
INSERT INTO factura(numero, fecha, cliente_asociado) VALUES (1239, '2020-01-06', 3);
INSERT INTO factura(numero, fecha, cliente_asociado) VALUES (1240, '2020-01-07', 4);
INSERT INTO factura(numero, fecha, cliente_asociado) VALUES (1241, '2020-01-08', 4);
INSERT INTO factura(numero, fecha, cliente_asociado) VALUES (1242, '2020-01-03', 4);
INSERT INTO factura(numero, fecha, cliente_asociado) VALUES (1243, '2020-01-03', 4);

--SE LE AGREGAN LOS PRODUCTOS A LA FACTURA INDIRECTAMENTE

--AGREGAR PRODUCTOS A FACTURAS DE CLIENTE 1 (2 Y 3 PRODUCTOS)
INSERT INTO tiene_producto(numero_factura, producto, cantidad_producto) VALUES (1234, 1, 100);
INSERT INTO tiene_producto(numero_factura, producto, cantidad_producto) VALUES (1234, 2, 100);
INSERT INTO tiene_producto(numero_factura, producto, cantidad_producto) VALUES (1235, 1, 50);
INSERT INTO tiene_producto(numero_factura, producto, cantidad_producto) VALUES (1235, 2, 50);
INSERT INTO tiene_producto(numero_factura, producto, cantidad_producto) VALUES (1235, 3, 50);

--AGREGAR PRODUCTOS A FACTURAS DE CLIENTE 2 (3, 2 Y 3 PRODUCTOS)
INSERT INTO tiene_producto(numero_factura, producto, cantidad_producto) VALUES (1236, 4, 30);
INSERT INTO tiene_producto(numero_factura, producto, cantidad_producto) VALUES (1236, 5, 30);
INSERT INTO tiene_producto(numero_factura, producto, cantidad_producto) VALUES (1236, 6, 40);
INSERT INTO tiene_producto(numero_factura, producto, cantidad_producto) VALUES (1237, 7, 50);
INSERT INTO tiene_producto(numero_factura, producto, cantidad_producto) VALUES (1237, 8, 60);
INSERT INTO tiene_producto(numero_factura, producto, cantidad_producto) VALUES (1238, 4, 50);
INSERT INTO tiene_producto(numero_factura, producto, cantidad_producto) VALUES (1238, 5, 100);
INSERT INTO tiene_producto(numero_factura, producto, cantidad_producto) VALUES (1238, 6, 100);

--AGREGAR PRODUCTOS A FACTURAS DE CLIENTE 3 (1 PRODUCTO)
INSERT INTO tiene_producto(numero_factura, producto, cantidad_producto) VALUES (1239, 1, 10);

--AGREGAR PRODUCTOS A FACTURAS DE CLIENTE 4 (2, 3, 4 Y 1 PRODUCTO)
INSERT INTO tiene_producto(numero_factura, producto, cantidad_producto) VALUES (1240, 1, 60);
INSERT INTO tiene_producto(numero_factura, producto, cantidad_producto) VALUES (1240, 2, 40);
INSERT INTO tiene_producto(numero_factura, producto, cantidad_producto) VALUES (1241, 8, 500);
INSERT INTO tiene_producto(numero_factura, producto, cantidad_producto) VALUES (1241, 7, 50);
INSERT INTO tiene_producto(numero_factura, producto, cantidad_producto) VALUES (1241, 6, 45);
INSERT INTO tiene_producto(numero_factura, producto, cantidad_producto) VALUES (1242, 5, 90);
INSERT INTO tiene_producto(numero_factura, producto, cantidad_producto) VALUES (1242, 4, 70);
INSERT INTO tiene_producto(numero_factura, producto, cantidad_producto) VALUES (1242, 3, 50);
INSERT INTO tiene_producto(numero_factura, producto, cantidad_producto) VALUES (1242, 7, 60);
INSERT INTO tiene_producto(numero_factura, producto, cantidad_producto) VALUES (1243, 8, 30);

-----------------------------------HACER CONSULTAS---------------------------------------------

--CONSULTA 1 - CLIENTE CON COMPRA MÁS CARA
SELECT cliente.nombre AS Cliente_compra_mas_cara
FROM factura
INNER JOIN (SELECT numero_factura, SUM (cantidad_producto * precio_unitario) AS SUBTOTAL
FROM tiene_producto, producto
WHERE producto = id_producto
GROUP BY numero_factura
ORDER BY SUBTOTAL DESC
LIMIT 1) AS tbl_aux ON numero_factura = numero 
INNER JOIN cliente ON id_cliente = cliente_asociado;

--CONSULTA 2 - CLIENTES CON PAGOS SOBRE 100 DE MONTO
SELECT DISTINCT cliente.nombre AS Cliente_sobre_100
FROM factura
INNER JOIN (SELECT numero_factura, SUM (cantidad_producto * precio_unitario) AS subtotal
FROM tiene_producto, producto
WHERE producto = id_producto
GROUP BY numero_factura)
AS tbl_aux ON numero_factura = numero and subtotal >100
INNER JOIN cliente ON id_cliente = cliente_asociado
ORDER BY Cliente_sobre_100 ASC;

--CONSULTA 3 - Q DE CLIENTES QUE HAN COMPRADO EL PRODUCTO 6 
SELECT COUNT (nombre) q_clientes
FROM (SELECT DISTINCT nombre
FROM tiene_producto, factura, cliente
WHERE producto = 6 and numero_factura = numero and cliente_asociado = id_cliente) AS tbl_aux;
