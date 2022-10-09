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