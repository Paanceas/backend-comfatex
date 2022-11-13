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
            $sql = "CALL siegvadbd.setVistas('".$res['nombre_vista']."','".$res['path_vista']."','".$res['icon_vista']."',1);";
            $this->global->callDBReturn($sql, 'id_vista');
            return $this->global->resolveCallBD(true, "Vista creada exitosamente");
        } catch (Exception $e) {
            return $this->global->resolveCallBD(false, $e);
        }
    }
    public function updVistas($res)
    {
        try {
            $sql = "CALL siegvadbd.updVistas('".$res['id_vista']."','".$res['nombre_vista']."','".$res['path_vista']."','".$res['icon_vista']."');";
            $return = $this->global->callDBReturn($sql, 'id_vista');
            return $this->global->resolveCallBD(true, "Vista actualizada exitosamente");
        } catch (Exception $e) {
            return $this->global->resolveCallBD(false, $e);
        }
    }
}

?>

