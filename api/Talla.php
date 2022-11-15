<?php 
    include_once 'common/imports.php';

    include_once PATH.'/src/Services/TallasHandler.php';
    $db = new TallasHandler();

    include_once 'common/http.php';

    function post() {
        $json = file_get_contents("php://input",true);
        $res = json_decode($json, true); 
        $api = new SiegvadApi(true, array("talla","peso_minimo","peso_maximo","cintura_minima","cintura_maxima","cadera_minima","cadera_maxima"), $res, true);
        $db = new TallasHandler();
        $response = $db->setTallas($res);
        $api->echoResponse($response->status, $response);
    }

?>