<?php 

    include_once 'common/imports.php';

    include_once PATH.'/src/Services/EmpleadosHandler.php'; 
    $db = new EmpleadosHandler();

    include_once 'common/http.php';

    function get(){
        $res = $_GET;
        $api = new SiegvadApi(true, null, null, false);
        $db = new EmpleadosHandler();
        $response = $db->getUsuariosEmpleados($res);
        $api->echoResponse($response->status, $response);
    }

?>