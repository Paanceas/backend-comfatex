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
	FROM siegvadbd.estado_empleado;
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
	FROM siegvadbd.roll;
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
