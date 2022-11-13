<?php 
    include_once 'common/imports.php';

    include_once PATH.'/src/Services/VistasHandler.php';
    $db = new VistasHandler();

    include_once 'common/http.php';

    function post() {
        $json = file_get_contents("php://input",true);
        $res = json_decode($json, true); 
        $api = new SiegvadApi(true, array("nombre_vista","path_vista","icon_vista"), $res, true);
        $db = new VistasHandler();
        $response = $db->setVistas($res);
        $api->echoResponse($response->status, $response);
    }

    function put() {
        $json = file_get_contents("php://input",true);
        $res = json_decode($json, true); 
        $api = new SiegvadApi(true, array("id_vista","nombre_vista","path_vista","icon_vista"), $res, true);
        $db = new VistasHandler();
        $response = $db->updVistas($res);
        $api->echoResponse($response->status, $response);
    }
?>