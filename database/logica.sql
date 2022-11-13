-- VALIDAR ESTADO DE LA BD
DELIMITER $$
USE `siegvadbd`$$
DROP PROCEDURE IF EXISTS `getBaseDatos`;
CREATE PROCEDURE `getBaseDatos` ()
BEGIN
	SELECT NOW() as fecha;
END$$
DELIMITER ;
-- CONSULTA LAS TALLAS
DELIMITER $$
USE `siegvadbd`$$
DROP PROCEDURE IF EXISTS `getTallas`;
CREATE PROCEDURE `getTallas` ()
BEGIN
	SELECT id_talla, talla , peso_minimo, peso_maximo, cintura_minima, cintura_maxima, cadera_minima, cadera_maxima
	FROM siegvadbd.tallas;
END$$
DELIMITER ;
-- GESTIONA LAS TALLAS
DELIMITER $$
USE `siegvadbd`$$
DROP PROCEDURE IF EXISTS `setTallas`;
CREATE PROCEDURE `setTallas` (IN talla_r VARCHAR(5), IN peso_minimo_r INT(11), IN peso_maximo_r INT(11), IN cintura_minima_r INT(11), IN cintura_maxima_r INT(11), IN cadera_minima_r INT(11), IN cadera_maxima_r INT(11))
BEGIN
	DECLARE i_talla INT;
	SELECT id_talla into i_talla
	FROM siegvadbd.tallas 
	WHERE talla = talla;

	IF i_talla IS NULL THEN
		INSERT INTO siegvadbd.tallas (`talla`,`peso_minimo`,`peso_maximo`,`cintura_minima`,`cintura_maxima`,`cadera_minima`,`cadera_maxima`)
		VALUES (talla_r,peso_minimo_r,peso_maximo_r,cintura_minima_r,cintura_maxima_r,cadera_minima_r,cadera_maxima_r);
		SELECT LAST_INSERT_ID() as id_talla;
	ELSE
		UPDATE siegvadbd.tallas
		SET peso_minimo = peso_minimo_r,
			peso_maximo = peso_maximo_r,
			cintura_minima = cintura_minima_r,
			cintura_maxima = cintura_maxima_r,
			cadera_minima = cadera_minima_r,
			cadera_maxima = cadera_maxima_r
		WHERE id_talla = i_talla;
		SELECT i_talla as id_talla;
	END IF;
END$$
DELIMITER ;
-- CONSULTA LOS ESTADOS
DELIMITER $$
USE `siegvadbd`$$
DROP PROCEDURE IF EXISTS `getEstados`;
CREATE PROCEDURE `getEstados` ()
BEGIN
	SELECT id_estado, tipo_estado
	FROM siegvadbd.estado;
END$$
DELIMITER ;
-- CONSULTA LOS ESTADOS DEL EMPLEADO
DELIMITER $$
USE `siegvadbd`$$
DROP PROCEDURE IF EXISTS `getEstadosEmpleado`;
CREATE PROCEDURE `getEstadosEmpleado` ()
BEGIN
	SELECT id_estado_empleado, tipo_estado_empleado
	FROM siegvadbd.estado_empleado
	WHERE email_empleado <> 'virtual';
END$$
DELIMITER ;
-- CONSULTA LOS ESTADOS DEL PAGO
DELIMITER $$
USE `siegvadbd`$$
DROP PROCEDURE IF EXISTS `getEstadosPago`;
CREATE PROCEDURE `getEstadosPago` ()
BEGIN
	SELECT id_estado_pago, tipo_estado_pago
	FROM siegvadbd.estado_pagos;
END$$
DELIMITER ;
-- CONSULTA LOS ESTADOS DEL PAGO
DELIMITER $$
USE `siegvadbd`$$
DROP PROCEDURE IF EXISTS `getRoll`;
CREATE PROCEDURE `getRoll` ()
BEGIN
	SELECT tipo_roll
	FROM siegvadbd.roll
	WHERE tipo_roll <> 'Virtual';
END$$
DELIMITER ;
-- CONSULTA LAS ALL VISTAS
DELIMITER $$
USE `siegvadbd`$$
DROP PROCEDURE IF EXISTS `getAllVistas`;
CREATE PROCEDURE `getAllVistas` ()
BEGIN
	SELECT v.id_vista, v.nombre_vista, v.path_vista, v.icon_vista, v.activo
	FROM siegvadbd.vistas v;
END$$
DELIMITER ;
-- CONSULTA LAS VISTAS
DELIMITER $$
USE `siegvadbd`$$
DROP PROCEDURE IF EXISTS `getVistas`;
CREATE PROCEDURE `getVistas` (IN roll_r VARCHAR(25))
BEGIN
	SELECT v.id_vista, v.nombre_vista, v.path_vista, v.icon_vista, v.activo
	FROM siegvadbd.vistas v
	INNER JOIN siegvadbd.roll_por_vistas vr on vr.id_vista = v.id_vista
	INNER JOIN siegvadbd.roll r on r.tipo_roll = vr.tipo_roll
	WHERE vr.activo_vistas = 1 AND r.tipo_roll = roll_r;
END$$
DELIMITER ;
-- CONSULTA ROLL POR VISTA
DELIMITER $$
USE `siegvadbd`$$
DROP PROCEDURE IF EXISTS `getVistasRoll`;
CREATE PROCEDURE `getVistasRoll` (IN id_vista_r INT(11))
BEGIN
	SELECT r.tipo_roll
	FROM siegvadbd.vistas v
	INNER JOIN siegvadbd.roll_por_vistas vr on vr.id_vista = v.id_vista
	INNER JOIN siegvadbd.roll r on r.tipo_roll = vr.tipo_roll
	WHERE v.id_vista = id_vista_r
	GROUP BY r.tipo_roll;
END$$
DELIMITER ;
-- CREACION DE VISTAS
DELIMITER $$
USE `siegvadbd`$$
DROP PROCEDURE IF EXISTS `setVistas`;
CREATE PROCEDURE `setVistas` (IN nombre_vista_r varchar(50),IN path_vista_r varchar(50),IN icon_vista_r varchar(50),IN activo_r boolean)
BEGIN

	DECLARE i_vista INT;
	SELECT id_vista into i_vista
	FROM siegvadbd.vistas 
	WHERE nombre_vista = nombre_vista_r;

	IF i_vista IS NULL THEN
		INSERT INTO siegvadbd.vistas (nombre_vista, path_vista, icon_vista, activo)
		VALUES (nombre_vista_r, path_vista_r, icon_vista_r, activo_r);
		SELECT LAST_INSERT_ID() as id_vista;
	ELSE
		SELECT i_vista as id_vista;
	END IF;
END$$
DELIMITER ;
-- ACTUALIZACIÓN DE VISTAS
DELIMITER $$
USE `siegvadbd`$$
DROP PROCEDURE IF EXISTS `updVistas`;
CREATE PROCEDURE `updVistas` (IN id_vista_r INT(11), IN nombre_vista_r varchar(50),IN path_vista_r varchar(50),IN icon_vista_r varchar(50))
BEGIN
	UPDATE siegvadbd.vistas 
	SET nombre_vista=nombre_vista_r,
	path_vista=path_vista_r, 
	icon_vista=icon_vista_r
	WHERE id_vista = id_vista_r;
END$$
DELIMITER ;
-- CREACION DE VISTAS POR ROLL
DELIMITER $$
USE `siegvadbd`$$
DROP PROCEDURE IF EXISTS `setVistasRoll`;
CREATE PROCEDURE `setVistasRoll` (IN id_vista_r INT(11), IN tipo_roll_r varchar(25), IN activo_vistas_r boolean)
BEGIN
	DECLARE i_vista_roll INT;
	SELECT id_roll_por_vistas into i_vista_roll
	FROM siegvadbd.roll_por_vistas 
	WHERE id_vista = id_vista_r AND tipo_roll = tipo_roll_r;

	IF i_vista_roll IS NULL THEN
		INSERT INTO siegvadbd.roll_por_vistas (id_vista,tipo_roll)
		VALUES (id_vista_r,tipo_roll_r);
		SELECT LAST_INSERT_ID() as id_talla;
	ELSE
		UPDATE siegvadbd.roll_por_vistas 
		SET id_vista=id_vista_r, 
		tipo_roll=tipo_roll_r, 
		activo_vistas=activo_vistas_r
		WHERE id_roll_por_vistas = i_vista_roll;
		SELECT i_vista_roll as id_roll_por_vistas;
	END IF;
END$$
DELIMITER ;
/*Login*/
DELIMITER $$
USE `siegvadbd`$$
DROP PROCEDURE IF EXISTS `getLogin`;
CREATE PROCEDURE `getLogin` (in usuario varchar(50), in con varchar(300))
BEGIN
	SELECT u.id_usuario, r.tipo_roll as roll, u.email_usuario as usuario, u.activo_usuario as estado
    FROM siegvadbd.usuarios u
    INNER JOIN siegvadbd.roll r on r.tipo_roll = u.tipo_roll
	WHERE u.email_usuario = usuario and u.password_usuario = con;
END$$
DELIMITER ;
/*Existe Usuario Empleado*/
DELIMITER $$
USE `siegvadbd`$$
DROP PROCEDURE IF EXISTS `getExisteUsuarioEmpleado`;
CREATE PROCEDURE `getExisteUsuarioEmpleado` (in usuario varchar(50))
BEGIN
	SELECT u.id_usuario, r.tipo_roll as roll, u.nombre_usuario as usuario, u.eliminar as estado
    FROM siegvadbd.usuarios u
    INNER JOIN siegvadbd.roll r on r.tipo_roll = u.tipo_roll
	WHERE u.email_usuario = usuario and (r.tipo_roll <> 'Cliente' AND r.tipo_roll <> 'Virtual');
END$$
DELIMITER ;
/*Existe Usuario Cliente*/
DELIMITER $$
USE `siegvadbd`$$
DROP PROCEDURE IF EXISTS `getExisteUsuarioCliente`;
CREATE PROCEDURE `getExisteUsuarioCliente` (in usuario varchar(50))
BEGIN
	SELECT u.id_usuario, r.tipo_roll as roll, u.nombre_usuario as usuario, u.eliminar as estado
    FROM siegvadbd.usuarios u
    INNER JOIN siegvadbd.roll r on r.tipo_roll = u.tipo_roll
	WHERE u.email_usuario = usuario and r.tipo_roll = 'Cliente';
END$$
DELIMITER ;
/*Creacion de Usuario*/
DELIMITER $$
USE `siegvadbd`$$
DROP PROCEDURE IF EXISTS `setUsuario`;
CREATE PROCEDURE `setUsuario` (in usuario varchar(50), in con varchar(256), in roll varchar(25))
BEGIN
	DECLARE i_email INT;
	SELECT id_usuario into i_email
	FROM siegvadbd.usuarios
	WHERE email_usuario = usuario;

	IF i_email IS NULL THEN
		INSERT INTO siegvadbd.usuarios (tipo_roll, email_usuario, password_usuario)
		VALUES (roll, usuario, con);
		SELECT LAST_INSERT_ID() as id_usuario, 0 as exist_usuario;
	ELSE
		SELECT i_email as id_usuario, 1 as exist_usuario;
	END IF;
END$$
DELIMITER ;
/*Actualzacion de Usuario*/
DELIMITER $$
USE `siegvadbd`$$
DROP PROCEDURE IF EXISTS `updUsuario`;
CREATE PROCEDURE `updUsuario` (in usuario varchar(50), in con varchar(256), in roll varchar(25), in activo boolean)
BEGIN
	DECLARE i_email INT;
	SELECT id_usuario into i_email
	FROM siegvadbd.usuarios
	WHERE email_usuario = usuario;

	IF i_email IS NULL THEN
		UPDATE siegvadbd.usuarios 
		SET tipo_roll=roll,
		password_usuario=con,
		activo=activo_usuario
		WHERE id_usuario = i_email;
	END IF;
END$$
DELIMITER ;
/*Consulta de Usuarios Empleados*/
DELIMITER $$
USE `siegvadbd`$$
DROP PROCEDURE IF EXISTS `getUsuariosEmpleados`;
CREATE PROCEDURE `getUsuariosEmpleados` ()
BEGIN
	SELECT u.id_usuario, r.tipo_roll as roll, e.id_empleado, e.fecha_creacion_empleado, e.apellido_empleado, e.nombre_empleado, ee.tipo_estado_empleado 
    FROM siegvadbd.usuarios u
    INNER JOIN siegvadbd.roll r on r.tipo_roll = u.tipo_roll
	INNER JOIN siegvadbd.empleados e on e.id_usuario = u.id_usuario
	INNER JOIN siegvadbd.estado_empleado ee on ee.id_estado_empleado = e.id_estado_empleado
	WHERE r.tipo_roll <> 'Cliente' AND r.tipo_roll <> 'Virtual';
END$$
DELIMITER ;
/*Consulta de Usuarios Clientes*/
DELIMITER $$
USE `siegvadbd`$$
DROP PROCEDURE IF EXISTS `getUsuariosClientes`;
CREATE PROCEDURE `getUsuariosClientes` ()
BEGIN
	SELECT u.id_usuario, 
	c.id_cliente,
	r.tipo_roll as roll,
	c.email_cliente,
	c.nombre_cliente,
	c.apellido_cliente,
	c.direccion_cliente,
	c.telefono_cliente,
	c.fecha_creacion_cliente
    FROM siegvadbd.usuarios u
    INNER JOIN siegvadbd.roll r on r.tipo_roll = u.tipo_roll
	INNER JOIN siegvadbd.clientes c on c.id_usuario = u.id_usuario
	WHERE r.tipo_roll = 'Cliente';
END$$
DELIMITER ;
/*Creacion de Empleado*/
DELIMITER $$
USE `siegvadbd`$$
DROP PROCEDURE IF EXISTS `setEmpleado`;
CREATE PROCEDURE `setEmpleado` (in id_usuario_r int(11), in email_empleado_r varchar(50), in nombre_empleado_r varchar(70), in apellido_empleado_r varchar(70))
BEGIN
	DECLARE i_email INT;
	SELECT id_empleado into i_email
	FROM siegvadbd.empleados
	WHERE email_empleado = email_empleado_r;

	IF i_email IS NULL THEN
		INSERT INTO siegvadbd.empleados (id_usuario,email_empleado,nombre_empleado,apellido_empleado)
		VALUES (id_usuario_r,email_empleado_r,nombre_empleado_r,apellido_empleado_r);
		SELECT LAST_INSERT_ID() as id_empleado, 0 as exist_empleado;
	ELSE
		SELECT i_email as id_empleado, 1 as exist_empleado;
	END IF;
END$$
DELIMITER ;
/*Actualizacion de Empleado*/
DELIMITER $$
USE `siegvadbd`$$
DROP PROCEDURE IF EXISTS `updEmpleado`;
CREATE PROCEDURE `updEmpleado` (in id_estado_empleado_r int(11), in email_empleado_r varchar(50), in nombre_empleado_r varchar(70), in apellido_empleado_r varchar(70))
BEGIN
	DECLARE i_email INT;
	SELECT id_empleado into i_email
	FROM siegvadbd.empleados
	WHERE email_empleado = email_empleado_r;

	IF i_email IS NULL THEN
		UPDATE siegvadbd.empleados
		SET nombre_empleado=nombre_empleado_r,
		apellido_empleado=apellido_empleado_r,
		id_estado_empleado=id_estado_empleado_r
		WHERE id_empleado = i_email;
	END IF;
END$$
DELIMITER ;
/*Creacion de Cliente*/
DELIMITER $$
USE `siegvadbd`$$
DROP PROCEDURE IF EXISTS `setCliente`;
CREATE PROCEDURE `setCliente` (in id_usuario_r int(11), IN email_cliente_r varchar(50) ,IN nombre_cliente_r varchar(100) ,IN apellido_cliente_r varchar(100) ,IN direccion_cliente_r varchar(200) ,IN telefono_cliente_r varchar(15))
BEGIN
	DECLARE i_email INT;
	SELECT id_cliente into i_email
	FROM siegvadbd.clientes
	WHERE email_cliente = clientes;

	IF i_email IS NULL THEN
		INSERT INTO siegvadbd.clientes (id_usuario,email_cliente,nombre_cliente,apellido_cliente,direccion_cliente,telefono_cliente)
		VALUES (id_usuario_r,email_cliente_r,nombre_cliente_r,apellido_cliente_r,direccion_cliente_r,telefono_cliente_r);
		SELECT LAST_INSERT_ID() as id_cliente, 0 as exist_cliente;
	ELSE
		SELECT i_email as id_cliente, 1 as exist_cliente;
	END IF;
END$$
DELIMITER ;
/*Actualizacion de Cliente*/
DELIMITER $$
USE `siegvadbd`$$
DROP PROCEDURE IF EXISTS `updCliente`;
CREATE PROCEDURE `updCliente` (IN email_cliente_r varchar(50) ,IN nombre_cliente_r varchar(100) ,IN apellido_cliente_r varchar(100) ,IN direccion_cliente_r varchar(200) ,IN telefono_cliente_r varchar(15))
BEGIN
	DECLARE i_email INT;
	SELECT id_cliente into i_email
	FROM siegvadbd.clientes
	WHERE email_cliente = email_cliente_r;

	IF i_email IS NULL THEN
		UPDATE siegvadbd.clientes
		SET id_usuario=id_usuario_r,
			email_cliente=email_cliente_r,
			nombre_cliente=nombre_cliente_r,
			apellido_cliente=apellido_cliente_r,
			direccion_cliente=direccion_cliente_r,
			telefono_cliente=telefono_cliente_r
		WHERE id_cliente = i_email;
	END IF;
END$$
DELIMITER ;
/*Creacion de Orden*/
DELIMITER $$
USE `siegvadbd`$$
DROP PROCEDURE IF EXISTS `setOrden`;
CREATE PROCEDURE `setOrden` (IN id_cliente_r int(11), IN id_empleado_r int(11), IN direccion_orden_r varchar(50), IN latitud_direccion_orden_r varchar(200), IN longitud_direccion_orden_r varchar(200),IN fecha_entrega_orden_r date, IN total_orden_r int(11))
BEGIN
	INSERT INTO siegvadbd.orden (id_cliente, id_empleado, direccion_orden, latitud_direccion_orden, longitud_direccion_orden, fecha_entrega_orden, total_orden)
	VALUES (id_cliente_r, id_empleado_r, direccion_orden_r, latitud_direccion_orden_r, longitud_direccion_orden_r, fecha_entrega_orden_r, total_orden_r);
	SELECT LAST_INSERT_ID() as id_orden;
END$$
DELIMITER ;
/*Actualizacion del estado de la orden*/
DELIMITER $$
USE `siegvadbd`$$
DROP PROCEDURE IF EXISTS `updEstadoOrden`;
CREATE PROCEDURE `updEstadoOrden` (IN id_orden_r int(11), IN id_estado_r int(11))
BEGIN
	UPDATE siegvadbd.orden 
	set id_estado = id_estado_r
	where id_orden = id_orden_r;
END$$
DELIMITER ;
/*Creacion del pago*/
DELIMITER $$
USE `siegvadbd`$$
DROP PROCEDURE IF EXISTS `setPagos`;
CREATE PROCEDURE `setPagos` (IN id_estado_pago_r int(11), IN id_orden_r int(11), IN valor_pago_r int(11), IN descuento_pago_r int(11))
BEGIN
	INSERT INTO siegvadbd.orden (id_estado_pago, id_orden, valor_pago, descuento_pago)
	VALUES (id_estado_pago_r, id_orden_r, valor_pago_r, descuento_pago_r);
	SELECT LAST_INSERT_ID() as id_pago;
END$$
DELIMITER ;
/*Actualizacion del estado del pago*/
DELIMITER $$
USE `siegvadbd`$$
DROP PROCEDURE IF EXISTS `updEstadoPagos`;
CREATE PROCEDURE `updEstadoPagos` (IN id_pago_r int(11), IN id_estado_r int(11))
BEGIN
	UPDATE siegvadbd.orden 
	set id_estado_pago = id_estado_r
	where id_pago = id_pago_r;
END$$
DELIMITER ;
/*Creacion de producto*/
DELIMITER $$
USE `siegvadbd`$$
DROP PROCEDURE IF EXISTS `setProducto`;
CREATE PROCEDURE `setProducto` (IN codigo_producto_r varchar(60), IN nombre_producto_r varchar(50), IN descripcion_producto_r varchar(300), IN precio_producto_r int(11), IN oferta_producto_r boolean, IN descuento_producto_r int(11), IN path_producto_r varchar(100))
BEGIN
	DECLARE i_producto INT;
	SELECT id_producto into i_producto
	FROM siegvadbd.productos
	WHERE codigo_producto = codigo_producto_r;

	IF i_producto IS NULL THEN
		INSERT INTO siegvadbd.productos (codigo_producto, nombre_producto, descripcion_producto, precio_producto, oferta_producto, descuento_producto, path_producto)
		VALUES (codigo_producto_r, nombre_producto_r, descripcion_producto_r, precio_producto_r, oferta_producto_r, descuento_producto_r, path_producto_r);
		SELECT LAST_INSERT_ID() as id_producto;
	ELSE
		SELECT i_producto as id_producto;
	END IF;
END$$
DELIMITER ;

/*Creacion del setProductosTallas*/
DELIMITER $$
USE `siegvadbd`$$
DROP PROCEDURE IF EXISTS `setProductosTallas`;
CREATE PROCEDURE `setProductosTallas` (IN codigo_producto_r varchar(60), IN id_talla_r int(11), IN cantidad_productos_r int(11))
BEGIN

	DECLARE i_producto INT;
	SELECT id_producto into i_producto
	FROM siegvadbd.productos
	WHERE codigo_producto = codigo_producto_r;

	IF i_producto IS NULL THEN
		INSERT INTO siegvadbd.productos_por_tallas (id_producto, id_talla, cantidad_productos)
		VALUES (i_producto, id_talla_r, cantidad_productos_r);
		SELECT LAST_INSERT_ID() as id_productos_por_tallas;
	ELSE
		SELECT null as id_productos_por_tallas, 1 as exist_cliente;
	END IF;
END$$
DELIMITER ;
/*Creacion del setProductosTallas*/
DELIMITER $$
USE `siegvadbd`$$
DROP PROCEDURE IF EXISTS `setProductosOrden`;
CREATE PROCEDURE `setProductosOrden` (IN id_productos_por_tallas_r int(11), IN id_orden_r int(11), IN cantidad_productos_r int(11))
BEGIN
	INSERT INTO siegvadbd.productos_por_orden (id_productos_por_tallas, id_talla, cantidad_productos)
	VALUES (id_productos_por_tallas_r, id_orden_r, cantidad_productos_r);
	SELECT LAST_INSERT_ID() as id_productos_por_orden;
END$$
DELIMITER ;
