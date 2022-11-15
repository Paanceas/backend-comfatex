<?php 
    include_once 'common/imports.php';

    include_once PATH.'/src/Services/OrdenHandler.php';
    $db = new PagosHandler();

    include_once 'common/http.php';

    function post() {
        $json = file_get_contents("php://input",true);
        $res = json_decode($json, true); 
        $api = new SiegvadApi(true, array("id_estado_pago","id_orden","valor_pago","descuento_pago"), $res, true);
        $db = new PagosHandler();
        $response = $db->setPagos($res);
        $api->echoResponse($response->status, $response);
    }

    function put() {
        $json = file_get_contents("php://input",true);
        $res = json_decode($json, true); 
        $api = new SiegvadApi(true, array("id_pago","id_estado"), $res, true);
        $db = new PagosHandler();
        $response = $db->updEstadoPagos($res);
        $api->echoResponse($response->status, $response);
    }
?>