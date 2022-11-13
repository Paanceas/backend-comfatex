<?php 

    include_once 'common/imports.php';

    include_once PATH.'/src/Services/RollHandler.php'; 
    $db = new RollHandler();

    include_once 'common/http.php';

    function get() {
        $res = $_GET;
        $api = new SiegvadApi(true, null, null, false);
        $db = new  RollHandler();
        $response = $db->getRoll($res);
        $api->echoResponse($response->status, $response);
    }

    function post() {
        $json = file_get_contents("php://input",true);
        $res = json_decode($json, true); 
        $api = new SiegvadApi(true, array("id_vista","tipo_roll","activo_vistas"), $res, true);
        $db = new  RollHandler();
        $response = $db->setRoll($res);
        $api->echoResponse($response->status, $response);
    }

?>