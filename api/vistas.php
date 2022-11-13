<?php 
    include_once 'common/imports.php';

    include_once PATH.'/src/Services/VistasHandler.php';
    $db = new VistasHandler();

    include_once 'common/http.php';

    function get(){
        $res = $_GET;
        $api = new SiegvadApi(true, array("tipo_roll"), $res, true);
        $db = new VistasHandler();
        $response = $db->getVistas($res);
        $api->echoResponse($response->status, $response);
    }
?>