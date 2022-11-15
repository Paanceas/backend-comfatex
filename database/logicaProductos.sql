ALTER TABLE `siegvadbd`.`productos` 
CHANGE COLUMN `path_producto` `path_producto` VARCHAR(300) NOT NULL,
DROP PRIMARY KEY,
ADD PRIMARY KEY (`id_producto`, `codigo_producto`);
-- Productos de la tienda
DELIMITER $$
USE `siegvadbd`$$
DROP PROCEDURE IF EXISTS `getProductSales`;
CREATE PROCEDURE `getProductSales` ()
BEGIN
	SELECT p.id_producto, p.codigo_producto, p.precio_producto, p.nombre_producto, p.descripcion_producto, p.oferta_producto, p.descuento_producto, p.path_producto
    FROM siegvadbd.productos p
    INNER JOIN siegvadbd.productos_por_tallas pt on pt.id_producto = p.id_producto
    INNER JOIN siegvadbd.tallas t on t.id_talla = pt.id_talla
    WHERE pt.cantidad_productos > 0;
END$$
DELIMITER ;
-- Productos de la tienda
DELIMITER $$
USE `siegvadbd`$$
DROP PROCEDURE IF EXISTS `getProductAll`;
CREATE PROCEDURE `getProductAll` ()
BEGIN
	SELECT p.id_producto, p.codigo_producto, p.precio_producto, p.nombre_producto, p.descripcion_producto, p.oferta_producto, p.descuento_producto, p.path_producto
    FROM siegvadbd.productos p;
END$$
DELIMITER ;
-- Detalle producto
DELIMITER $$
USE `siegvadbd`$$
DROP PROCEDURE IF EXISTS `getProductSizes`;
CREATE PROCEDURE `getProductSizes` (IN codigo_producto_r varchar(60))
BEGIN
	SELECT p.id_producto, p.codigo_producto, t.talla, pt.cantidad_productos
    FROM siegvadbd.productos p
    INNER JOIN siegvadbd.productos_por_tallas pt on pt.id_producto = p.id_producto
    INNER JOIN siegvadbd.tallas t on t.id_talla = pt.id_talla
    WHERE p.codigo_producto = codigo_producto_r;
END$$
DELIMITER ;