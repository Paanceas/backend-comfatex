<?php 

    include_once '../include/Config.php';
    include_once PATH.'/include/SiegvadApi.php';
    include_once PATH.'/src/Models/Response.php';

    header("Access-Control-Allow-Origin: *");
    header('Access-Control-Allow-Credentials: true');
    header('Access-Control-Allow-Methods: PUT, GET, POST, DELETE, OPTIONS');
    header('Access-Control-Allow-Headers: *');
    header('Content-Type: application/json; charset=utf-8');

    if ($_SERVER['REQUEST_METHOD'] == 'OPTIONS' && isset($_SERVER['HTTP_ACCESS_CONTROL_REQUEST_METHOD'])) {
            if($_SERVER['HTTP_ACCESS_CONTROL_REQUEST_METHOD'] == 'GET' 
            || $_SERVER['HTTP_ACCESS_CONTROL_REQUEST_METHOD'] == 'POST'
            || $_SERVER['HTTP_ACCESS_CONTROL_REQUEST_METHOD'] == 'PUT' 
            || $_SERVER['HTTP_ACCESS_CONTROL_REQUEST_METHOD'] == 'DELETE') {
                header('Access-Control-Allow-Origin: *');
                header('Access-Control-Allow-Headers: *');
            }
        exit();
    }

?>