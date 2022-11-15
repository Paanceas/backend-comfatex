<?php

require_once '../include/Config.php';
require_once '../src/Models/Response.php';

class ProductosHandler {
    
    private $global;

    function __construct() {
        require_once 'CallBD.php';
        $this->global = new CallBD();
    }

    public function getProductSales($res)
    {
        if (isset($res['ALL_PRODUCTS'])){
            $sql = "CALL siegvadbd.getProductSales();";
            return $this->global->callDB($sql, 'Consulta Productos ', true);
        }else {
            $sql = "CALL siegvadbd.getProductAll();";
        return $this->global->callDB($sql, 'Consulta Productos ', true);
        }
        
    }

    public function getProductSizes($res)
    {
        $sql = "CALL siegvadbd.getProductSizes('".$res['codigo_producto']."');";
        return $this->global->callDB($sql, 'Consulta Producto Tallas ', true);
    }

    public function setProduct($res)
    {
        try {
            $sql = "CALL siegvadbd.setProducto('".$res['codigo_producto']."','".$res['nombre_producto']."','".$res['descripcion_producto']."',".$res['precio_producto'].",".$res['oferta_producto'].",".$res['descuento_producto'].",'".$res['path_producto']."');";
            $this->global->callDBReturn($sql, 'id_producto');
            return $this->global->resolveCallBD(true, "Producto creada exitosamente");
        } catch (Exception $e) {
            return $this->global->resolveCallBD(false, $e);
        }
    }
}

?>