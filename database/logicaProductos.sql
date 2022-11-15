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