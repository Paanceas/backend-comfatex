DROP DATABASE IF EXISTS siegvadbd;
CREATE DATABASE siegvadbd;
USE siegvadbd;

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
SET time_zone = "+00:00";

/*v1.0 SCRIPT DATABASE*/
/*================
Tabla Talla
================*/
CREATE TABLE `tallas` (
`id_talla` int NOT NULL AUTO_INCREMENT,
`talla` varchar(5) NOT NULL,
`peso_minimo` int NOT NULL,
`peso_maximo` int NOT NULL,
`cintura_minima` int NOT NULL,
`cintura_maxima` int NOT NULL,
`cadera_minima` int NOT NULL,
`cadera_maxima` int NOT NULL,
PRIMARY KEY(`id_talla`),
UNIQUE(`talla`))
ENGINE=InnoDB DEFAULT CHARSET=utf8;

/*================
TABLA ESTADO
================*/
CREATE TABLE `estado`
(`id_estado` int NOT NULL AUTO_INCREMENT,
`tipo_estado` varchar(25) NOT NULL,
PRIMARY KEY(`id_estado`))
ENGINE=InnoDB DEFAULT CHARSET=utf8;
INSERT INTO `siegvadbd`.`estado` (`tipo_estado`)
VALUES ('EN VALIDANDO'), ('CONFIRMADA'), ('EN PREPARACIÓN'), ('EN RUTA'), ('ENTREGADO'), ('CANCELADO');

/*================
TABLA ESTADO EMPLEADO
================*/
CREATE TABLE `estado_empleado`
(`id_estado_empleado` int NOT NULL AUTO_INCREMENT,
`tipo_estado_empleado` varchar(25) NOT NULL,
PRIMARY KEY(`id_estado_empleado`))
ENGINE=InnoDB DEFAULT CHARSET=utf8;
INSERT INTO `siegvadbd`.`estado_empleado` (`tipo_estado_empleado`)
VALUES ('activo'), ('suspendido'), ('inactivo');

/*================
TABLA ESTADO PAGOS
================*/
CREATE TABLE `estado_pagos`(
`id_estado_pago` int NOT NULL AUTO_INCREMENT,
`tipo_estado_pago` varchar(25) NOT NULL,
PRIMARY KEY(`id_estado_pago`))
ENGINE=InnoDB DEFAULT CHARSET=utf8;
INSERT INTO `siegvadbd`.`estado_pagos` (`tipo_estado_pago`)
VALUES ('En proceso'), ('Completado'), ('Devolucion'), ('Fallido');

/*================
TABLA ROLL
================*/
CREATE TABLE `roll` (
`tipo_roll` varchar(25) NOT NULL,
PRIMARY KEY(`tipo_roll`))
ENGINE=InnoDB DEFAULT CHARSET=utf8;
INSERT INTO `siegvadbd`.`roll` (`tipo_roll`)
VALUES ('Cliente'), ('Administrador'), ('Vendedor'), ('Asistente');

/*================
TABLA VISTAS
================*/
CREATE TABLE `vistas` (
`id_vista` int NOT NULL AUTO_INCREMENT,
`nombre_vista` varchar(50) NOT NULL,
`path_vista` varchar(50) NOT NULL,
`icon_vista` varchar(50) NOT NULL,
`activo` boolean NOT NULL DEFAULT 1,
PRIMARY KEY(`id_vista`))
ENGINE=InnoDB DEFAULT CHARSET=utf8;

/*================
TABLA ROLL POR VISTAS
================*/
CREATE TABLE `roll_por_vistas` (
`id_roll_por_vistas` int NOT NULL AUTO_INCREMENT,
`id_vista` int NOT NULL,
`tipo_roll` varchar(25) NOT NULL,
`activo_vistas` boolean NOT NULL DEFAULT 1,
PRIMARY KEY(`id_roll_por_vistas`),
FOREIGN KEY (`id_vista`) REFERENCES `vistas` (`id_vista`),
FOREIGN KEY (`tipo_roll`) REFERENCES `roll` (`tipo_roll`))
ENGINE=InnoDB DEFAULT CHARSET=utf8;

/*================
TABLA USUARIOS
================*/
CREATE TABLE `usuarios` (
`id_usuario` int NOT NULL AUTO_INCREMENT,
`tipo_roll` varchar(25) NOT NULL DEFAULT 'Cliente',
`email_usuario` varchar(50) NOT NULL,
`password_usuario` varchar(256) NOT NULL,
`activo_usuario` boolean NOT NULL DEFAULT 1,
PRIMARY KEY(`id_usuario`),
UNIQUE(`email_usuario`),
FOREIGN KEY (`tipo_roll`) REFERENCES `roll` (`tipo_roll`))
ENGINE=InnoDB DEFAULT CHARSET=utf8;

INSERT INTO `siegvadbd`.`usuarios` (`tipo_roll`,`email_usuario`,`password_usuario`,`activo_usuario`)
VALUES ('Administrador','admin@siegvad.com','2df589749f656253ff8c3309ca8bfab79fd9284b863038ecadbb2158061f577b',1),
('Vendedor','vendedor@siegvad.com','2df589749f656253ff8c3309ca8bfab79fd9284b863038ecadbb2158061f577b',1),
('Asistente','asistente@siegvad.com','2df589749f656253ff8c3309ca8bfab79fd9284b863038ecadbb2158061f577b',1);

/*================
TABLA Empleado
================*/
CREATE TABLE `empleados` (
`id_empleado` int NOT NULL AUTO_INCREMENT,
`id_usuario` int NOT NULL,
`id_estado_empleado` int NOT NULL,
`email_empleado` varchar(50) NOT NULL,
`nombre_empleado` varchar(70) NOT NULL,
`apellido_empleado` varchar(70) NOT NULL,
`fecha_creacion_empleado` date NOT NULL DEFAULT NOW(),
PRIMARY KEY(`id_empleado`),
UNIQUE(`email_empleado`),
FOREIGN KEY (`id_usuario`) REFERENCES `usuarios` (`id_usuario`),
FOREIGN KEY (`id_estado_empleado`) REFERENCES `estado_empleado` (`id_estado_empleado`))
ENGINE=InnoDB DEFAULT CHARSET=utf8;

INSERT INTO `siegvadbd`.`empleados` (`id_usuario`,`id_estado_empleado`,`email_empleado`,`nombre_empleado`,`apellido_empleado`)
VALUES (1,1,'admin@siegvad.com','Pablo','Ceballos'),
(2,1,'vendedor@siegvad.com','Vendedor','Prueba'),
(3,1,'asistente@siegvad.com','Asistente','Pruebas');

/*================
TABLA cliente
================*/
CREATE TABLE `cliente` (
`id_cliente` int NOT NULL AUTO_INCREMENT,
`id_usuario` int NOT NULL,
`email_cliente` varchar(50) NOT NULL,
`nombre_cliente` varchar(100) NOT NULL,
`apellido_cliente` varchar(100) NOT NULL,
`direccion_cliente` varchar(200) NOT NULL,
`telefono_cliente` varchar(200) NOT NULL,
`activo_cliente` boolean NOT NULL DEFAULT 1,
`fecha_creacion_cliente` date NOT NULL DEFAULT NOW(),
PRIMARY KEY(`id_cliente`),
UNIQUE(`email_cliente`),
FOREIGN KEY (`id_usuario`) REFERENCES `usuarios` (`id_usuario`))
ENGINE=InnoDB DEFAULT CHARSET=utf8;

/*================
TABLA orden
================*/
CREATE TABLE `orden` (
`id_orden` int NOT NULL AUTO_INCREMENT,
`id_cliente` int NOT NULL,
`id_estado` int NOT NULL default 1,
`direccion_orden` varchar(50) NOT NULL UNIQUE,
`latitud_direccion_orden` varchar(200) NULL,
`longitud_direccion_orden` varchar(200) NULL,
`fecha_orden` date NOT NULL DEFAULT NOW(),
`fecha_entrega_orden` date DEFAULT NULL,
`total_orden` int NOT NULL,
PRIMARY KEY(`id_orden`),
FOREIGN KEY (`id_cliente`) REFERENCES `cliente` (`id_cliente`),
FOREIGN KEY (`id_estado`) REFERENCES `estado` (`id_estado`))
ENGINE=InnoDB DEFAULT CHARSET=utf8;

/*================
TABLA PAGOS
================*/
CREATE TABLE `pagos`(
`id_pago` int NOT NULL AUTO_INCREMENT,
`id_estado_pago` int NOT NULL,
`id_orden` int NOT NULL,
`valor_pago` int NOT NULL,
`descuento_pago` int NOT NULL DEFAULT 0,
PRIMARY KEY(`id_pago`),
FOREIGN KEY (`id_estado_pago`) REFERENCES `estado_pagos` (`id_estado_pago`),
FOREIGN KEY (`id_orden`) REFERENCES `orden` (`id_orden`))
ENGINE=InnoDB DEFAULT CHARSET=utf8;

/*================
TABLA PRODUCTOS
================*/
CREATE TABLE `productos`(
`id_producto` int NOT NULL AUTO_INCREMENT,
`codigo_producto` varchar(60) NOT NULL,
`nombre_producto` varchar(50) NOT NULL,
`descripcion_producto` varchar(300) NOT NULL,
`precio_producto` int NOT NULL,
`oferta_producto` boolean NOT NULL default 0,
`descuento_producto` int NOT NULL DEFAULT 0,
`path_producto` varchar(100) NOT NULL,
`fecha_creacion_producto` date NOT NULL DEFAULT NOW(),
PRIMARY KEY(`id_producto`),
UNIQUE(`codigo_producto`))
ENGINE=InnoDB DEFAULT CHARSET=utf8;

/*================
TABLA PRODUCTOS POR TALLAS
================*/
CREATE TABLE `productos_por_tallas`(
`id_productos_por_tallas` int NOT NULL AUTO_INCREMENT,
`id_producto` int NOT NULL,
`id_talla` int NOT NULL,
`cantidad_productos` int NOT NULL,
PRIMARY KEY(`id_productos_por_tallas`),
FOREIGN KEY (`id_producto`) REFERENCES `productos` (`id_producto`),
FOREIGN KEY (`id_talla`) REFERENCES `tallas` (`id_talla`))
ENGINE=InnoDB DEFAULT CHARSET=utf8;

/*================
TABLA PRODUCTOS POR ORDEN
================*/
CREATE TABLE `productos_por_orden`(
`id_productos_por_orden` int NOT NULL AUTO_INCREMENT,
`id_productos_por_tallas` int NOT NULL,
`id_orden` int NOT NULL,
`cantidad_productos` int NOT NULL,
PRIMARY KEY(`id_productos_por_orden`),
FOREIGN KEY (`id_productos_por_tallas`) REFERENCES `productos_por_tallas` (`id_productos_por_tallas`),
FOREIGN KEY (`id_orden`) REFERENCES `orden` (`id_orden`))
ENGINE=InnoDB DEFAULT CHARSET=utf8;








