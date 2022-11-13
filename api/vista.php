<?php 
    include_once 'common/imports.php';

    include_once PATH.'/src/Services/VistasHandler.php';
    $db = new VistasHandler();

    include_once 'common/http.php';

    function post() {
        $json = file_get_contents("php://input",true);
        $res = json_decode($json, true); 
        $api = new SiegvadApi(true, array("nombre","path","icono"), $res, true);
        $db = new VistasHandler();
        $response = $db->setVistas($res);
        $api->echoResponse($response->status, $response);
    }
?>