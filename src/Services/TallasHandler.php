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
}

?>