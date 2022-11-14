<?php

require_once '../include/Config.php';
require_once '../src/Models/Response.php';

class ClientesHandler {
    
    private $global;

    function __construct() {
        require_once 'CallBD.php';
        $this->global = new CallBD();
    }

    public function getUsuariosClientes()
    {
        $sql = "CALL siegvadbd.getUsuariosClientes();";
        return $this->global->callDB($sql, 'Consulta Clientes ', true);
    }
}

?>