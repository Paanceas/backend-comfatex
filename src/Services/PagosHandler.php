<?php

require_once '../include/Config.php';
require_once '../src/Models/Response.php';

class PagosHandler {
    
    private $global;

    function __construct() {
        require_once 'CallBD.php';
        $this->global = new CallBD();
    }

    public function updEstadoPagos($res)
    {
        try {
            $sql = "CALL siegvadbd.updEstadoPagos('".$res['id_pago']."','".$res['id_estado']."');";
            $return = $this->global->callDBReturn($sql, 'id_pago');
            return $this->global->resolveCallBD(true, "Pago actualizada exitosamente");
        } catch (Exception $e) {
            return $this->global->resolveCallBD(false, $e);
        }
    }

    public function setPagos($res)
    {
        try {
            $sql = "CALL siegvadbd.setPagos('".$res['id_estado_pago']."',".$res['id_orden'].",".$res['valor_pago'].",".$res['descuento_pago'].");";
            $this->global->callDBReturn($sql, 'id_pago');
            return $this->global->resolveCallBD(true, "Pago creado exitosamente");
        } catch (Exception $e) {
            return $this->global->resolveCallBD(false, $e);
        }
    }
}

?>