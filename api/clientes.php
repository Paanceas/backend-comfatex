<?php 

    include_once 'common/imports.php';

    include_once PATH.'/src/Services/ClientesHandler.php'; 
    $db = new ClientesHandler();

    include_once 'common/http.php';

    function get(){
        $res = $_GET;
        $api = new SiegvadApi(true, null, null, false);
        $db = new ClientesHandler();
        $response = $db->getUsuariosClientes($res);
        $api->echoResponse($response->status, $response);
    }

?>