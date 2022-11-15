<?php 
    include_once 'common/imports.php';

    include_once PATH.'/src/Services/OrdenHandler.php';
    $db = new OrdenHandler();

    include_once 'common/http.php';

    function post() {
        $json = file_get_contents("php://input",true);
        $res = json_decode($json, true); 
        $api = new SiegvadApi(true, array("id_cliente","id_empleado","direccion_orden","latitud_direccion_orden","longitud_direccion_orden","fecha_entrega_orden","total_orden"), $res, true);
        $db = new OrdenHandler();
        $response = $db->setOrden($res);
        $api->echoResponse($response->status, $response);
    }

    function put() {
        $json = file_get_contents("php://input",true);
        $res = json_decode($json, true); 
        $api = new SiegvadApi(true, array("id_orden","id_estado"), $res, true);
        $db = new OrdenHandler();
        $response = $db->updEstadoOrden($res);
        $api->echoResponse($response->status, $response);
    }
?>