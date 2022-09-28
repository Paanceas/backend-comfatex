<?php 

    include_once 'common/imports.php';

    include_once PATH.'/src/Services/GlobalHandler.php'; 
    $db = new GlobalHandler();

    include_once 'common/http.php';

    function get(){
        $res = $_GET;
        $api = new SiegvadApi(false,null, null, false);
        $db = new GlobalHandler();
        $response = $db->getValid($res);
        $api->echoResponse($response->status, $response);
    }

?>