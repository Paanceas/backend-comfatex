<?php 
    include_once 'common/imports.php';

    include_once PATH.'/src/Services/ProductosHandler.php';
    $db = new ProductosHandler();

    include_once 'common/http.php';

    function get() {
        $res = $_GET;
        $api = new SiegvadApi(false, array("codigo_producto"), $res, true);
        $db = new ProductosHandler();
        $response = $db->getProductSizes($res);
        $api->echoResponse($response->status, $response);
    }

    function post() {
        $json = file_get_contents("php://input",true);
        $res = json_decode($json, true); 
        $api = new SiegvadApi(true, array("codigo_producto","precio_producto","nombre_producto","descripcion_producto","oferta_producto","descuento_producto", "path_producto"), $res, true);
        $db = new ProductosHandler();
        $response = $db->setProduct($res);
        $api->echoResponse($response->status, $response);
    }
?>