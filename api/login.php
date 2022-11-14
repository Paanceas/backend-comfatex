<?php 
    include_once 'common/imports.php';

    include_once PATH.'/src/Services/UsuariosHandler.php'; 
    $db = new UsuariosHandler();

    include_once 'common/http.php';

    function get(){
        $res = $_GET;
        $api = new SiegvadApi(false,array("usuario","password"), $res, true);
        $db = new UsuariosHandler();
        $response = $db->getLogin($res);
        $api->echoResponse($response->status, $response);
    }
?>