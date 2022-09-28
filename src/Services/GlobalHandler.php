<?php

require_once '../include/Config.php';
require_once '../src/Models/Response.php';

class GlobalHandler {
    
    private $global;

    function __construct() {
        require_once 'CallBD.php';
        $this->global = new CallBD();
    }   

    public function getValid()
    {
        $sql = "CALL sisgespro.getBaseDatos();";
        return $this->global->callDB($sql,'Api funcionando correctamente',false);
    }
}

?>

