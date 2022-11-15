<?php

require_once '../include/Config.php';
require_once '../src/Models/Response.php';

class OrdenHandler {
    
    private $global;

    function __construct() {
        require_once 'CallBD.php';
        $this->global = new CallBD();
    }

    public function updEstadoOrden($res)
    {
        try {
            $sql = "CALL siegvadbd.updEstadoOrden('".$res['id_orden']."','".$res['id_estado']."');";
            $return = $this->global->callDBReturn($sql, 'id_orden');
            return $this->global->resolveCallBD(true, "Orden actualizada exitosamente");
        } catch (Exception $e) {
            return $this->global->resolveCallBD(false, $e);
        }
    }

    public function setOrden($res)
    {
        try {
            $sql = "CALL siegvadbd.setTallas('".$res['id_cliente']."',".$res['id_empleado'].",".$res['direccion_orden'].",".$res['latitud_direccion_orden'].",".$res['longitud_direccion_orden'].",".$res['fecha_entrega_orden'].",".$res['total_orden'].");";
            $this->global->callDBReturn($sql, 'id_orden');
            return $this->global->resolveCallBD(true, "Orden creada exitosamente");
        } catch (Exception $e) {
            return $this->global->resolveCallBD(false, $e);
        }
    }
}

?>