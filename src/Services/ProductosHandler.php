<?php

require_once '../include/Config.php';
require_once '../src/Models/Response.php';

class ProductosHandler {
    
    private $global;

    function __construct() {
        require_once 'CallBD.php';
        $this->global = new CallBD();
    }

    public function getProductSales()
    {
        $sql = "CALL siegvadbd.getProductSales();";
        return $this->global->callDB($sql, 'Consulta Porductos ', true);
    }
}

?>