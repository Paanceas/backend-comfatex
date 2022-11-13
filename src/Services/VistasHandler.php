<?php

require_once '../include/Config.php';
require_once '../src/Models/Response.php';

class VistasHandler {
    
    private $global;

    function __construct() {
        require_once 'CallBD.php';
        $this->global = new CallBD();
    }

    public function getVistas($res)
    {
        if (isset($res['tipo_roll'])){
            $sql = "CALL siegvadbd.getVistas('".$res['tipo_roll']."');";
            return $this->global->callDB($sql, 'Consulta Vistas ', true);
        }else {
            $sql = "CALL siegvadbd.getAllVistas();";
            return $this->global->callDB($sql, 'Consulta Vistas ', true);
        }
    }
    public function setVistas($res)
    {
        try {
            $sql = "CALL siegvadbd.setVistas('".$res['nombre']."','".$res['path']."','".$res['icono']."',1);";
            $return = $this->global->callDBReturn($sql, 'id_vista');
            return $this->global->resolveCallBD(true, "Aquisicion creada exitosamente");
        } catch (Exception $e) {
            return $this->global->resolveCallBD(false, $e);
        }
    }
}

?>

