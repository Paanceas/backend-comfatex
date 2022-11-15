<?php 
    include_once 'common/imports.php';

    include_once PATH.'/src/Services/ProductosHandler.php';
    $db = new ProductosHandler();

    include_once 'common/http.php';

    function get() {
        $res = $_GET;
        $api = new SiegvadApi(false, null, null, false);
        $db = new ProductosHandler();
        $response = $db->getProductSales($res);
        $api->echoResponse($response->status, $response);
    }
?>
