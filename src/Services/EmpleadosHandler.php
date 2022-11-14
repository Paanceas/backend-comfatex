<?php

require_once '../include/Config.php';
require_once '../src/Models/Response.php';

class EmpleadosHandler {
    
    private $global;

    function __construct() {
        require_once 'CallBD.php';
        $this->global = new CallBD();
    }

    public function getUsuariosEmpleados()
    {
        $sql = "CALL siegvadbd.getUsuariosEmpleados();";
        return $this->global->callDB($sql, 'Consulta Empleados ', true);
    }
}

?>