<?php

require_once '../include/Config.php';
require_once '../src/Models/Response.php';

class TallasHandler {
    
    private $global;

    function __construct() {
        require_once 'CallBD.php';
        $this->global = new CallBD();
    }

    public function getTallas()
    {
        $sql = "CALL siegvadbd.getTallas();";
        return $this->global->callDB($sql, 'Consulta Tallas ', true);
    }

    public function setTallas($res)
    {
        try {
            $sql = "CALL siegvadbd.setTallas('".$res['talla']."',".$res['peso_minimo'].",".$res['peso_maximo'].",".$res['cintura_minima'].",".$res['cintura_maxima'].",".$res['cadera_minima'].",".$res['cadera_maxima'].");";
            $this->global->callDBReturn($sql, 'id_talla');
            return $this->global->resolveCallBD(true, "Talla creada exitosamente");
        } catch (Exception $e) {
            return $this->global->resolveCallBD(false, $e);
        }
    }
}

?>