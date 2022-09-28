<?php
    try {
        switch ($_SERVER['REQUEST_METHOD']) {
            case 'GET':
                get();
                break;
            case 'POST':
                post();
                break;
            case 'PUT':
                put();
                break;
            case 'DELETE':
                delete();
                break;    
            default:
                http_response_code(404);
                break; 
        }
    } catch (\Throwable $th) {
        http_response_code(404);
    }
?>