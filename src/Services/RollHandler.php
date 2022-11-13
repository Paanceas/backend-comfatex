<?php

require_once '../include/Config.php';
require_once '../src/Models/Response.php';

class RollHandler{
    
    private $global;

    function __construct() {
        require_once 'CallBD.php';
        $this->global = new CallBD();
    }

    public function getRoll($res)
    {
        if (isset($res['id_vista'])) {
            $sql = "CALL siegvadbd.getVistasRoll('".$res['id_vista']."');";
            return $this->global->callDB($sql, 'Consulta Roll ', true);
        }else {
            $sql = "CALL siegvadbd.getRoll();";
            return $this->global->callDB($sql, 'Consulta Roll ', true);
        }
    }

    public function setRoll($res)
    {
        try {
            $sql = "CALL siegvadbd.setVistasRoll('".$res['id_vista']."','".$res['tipo_roll']."',".$res['activo_vistas'].");";
            return $this->global->callDB($sql, 'Roll por Vista creada exitosamente', true);
        } catch (Exception $e) {
            return $this->global->resolveCallBD(false, $e);
        }
    }
}

?>