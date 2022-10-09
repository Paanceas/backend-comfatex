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
-- CREACION DE VISTAS
DELIMITER $$
USE `siegvadbd`$$
DROP PROCEDURE IF EXISTS `setVistas`;
CREATE PROCEDURE `setVistas` (IN nombre_vista_r varchar(50),IN path_vista_r varchar(50),IN icon_vista_r varchar(50),IN activo_r boolean)
BEGIN
	INSERT INTO siegvadbd.vistas (nombre_vista, path_vista, icon_vista, activo)
	VALUES (nombre_vista_r, path_vista_r, icon_vista_r, activo_r);
	SELECT LAST_INSERT_ID() as id_vista;
END$$
DELIMITER ;
-- ACTUALIZACIÓN DE VISTAS
DELIMITER $$
USE `siegvadbd`$$
DROP PROCEDURE IF EXISTS `updVistas`;
CREATE PROCEDURE `updVistas` (IN nombre_vista_r varchar(50),IN path_vista_r varchar(50),IN icon_vista_r varchar(50))
BEGIN
	UPDATE siegvadbd.vistas 
	SET nombre_vista=nombre_vista_r,
	path_vista=path_vista_r, 
	icon_vista=icon_vista_r
	WHERE id_vista = id_vista_R;
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
	SELECT u.id_usuario, r.tipo_roll as roll, u.nombre_usuario as usuario, u.eliminar as estado
    FROM siegvadbd.usuarios u
    INNER JOIN siegvadbd.roll r on r.tipo_roll = u.tipo_roll
	WHERE u.email_usuario = usuario and u.clave = con;
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