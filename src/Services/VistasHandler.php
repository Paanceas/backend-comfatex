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
        $sql = "CALL siegvadbd.getVistas('".$res['tipo_roll']."');";
        return $this->global->callDB($sql, 'Consulta Vistas ', true);
    }
}

?>

