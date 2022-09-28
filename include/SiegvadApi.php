<?php 
/**
 *
 * @About:      Database connection manager class
 * @File:       Maphis.php
 * @Date:       $Date:$ SEP 2022
 * @Version:    $Rev:$ 1.0
 * @Developer:  Pablo Ceballos
 **/
require_once 'Config.php';

class SiegvadApi {


    function __construct($valid, $array, $data, $valid_fields) {
        if($valid){
            $this->authenticate();
        }
        $this->verifyRequiredParams($array, $data, $valid_fields);
    }

     /**
     * Verificando los parametros requeridos en el metodo o endpoint
     */
    public function verifyRequiredParams($required_fields, $array, $valid_fields) {
        if($required_fields != null && $array != null){
            $error = false;
            $error_fields = "";
            $request_params = $array;
    
            foreach ($required_fields as $field) {
                if(isset($request_params[$field]) && is_array($request_params[$field])){
                    if (count($request_params[$field])<=0) {
                        $error = true;
                        $error_fields .= $field . ', ';
                    }
                }else{
                    if (!isset($request_params[$field]) || strlen(trim($request_params[$field])) <= 0) {
                        $error = true;
                        $error_fields .= $field . ', ';
                    }
                }
            }
        
            if ($error) {
                // Required field(s) are missing or empty
                // echo error json and stop the app
                $response = array();
                $response["status"] = 422;
                $response["message"] = 'Campos requerido(s) (' . substr($error_fields, 0, -2) . ') Falta o está vacía';
                $this->echoResponse(422, $response);
                exit();
            }
        }else if($valid_fields){
            $response = array();
            $response["status"] = 422;
            $response["message"] = 'La información falta o está vacía';
            $this->echoResponse(422, $response);
            exit();
        }
    }

    /**
     * Mostrando la respuesta en formato json al cliente o navegador
     * @param String $status_code Http response code
     * @param Int $response Json response
     */
    public function echoResponse($status_code, $response) {
        http_response_code($status_code);
        echo json_encode($response);
    }

    /**
     * Agregando un leyer intermedio e autenticación para uno o todos los metodos, usar segun necesidad
     * Revisa si la consulta contiene un Header "Authorization" para validar
     */
    public function authenticate() {
        // Getting request headers
        $headers = getallheaders();
        $response = array();
    
        // Verifying Authorization Header
        if (isset($headers['Auth'])) {
            //$db = new DbHandler(); //utilizar para manejar autenticacion contra base de datos
    
            // get the api key
            $token = $headers['Auth'];
            $token = str_replace('"','',$token);

            // validating api key
            if ($token !== API_KEY) { //API_KEY declarada en Config.php
                
                // api key is not present in users table
                $response["status"] = 401;
                $response["message"] = "Acceso denegado. Token inválido";
                $this->echoResponse(401, $response);
                
               exit(); //Detenemos la ejecución del programa al no validar
                
            } else {
                //procede utilizar el recurso o metodo del llamado
            }
        } else {
            // api key is missing in header
            $response["status"] = 400;
            $response["message"] = "Falta token de autorización";
            $this->echoResponse(400, $response);
           exit();
        }
    }
}



?>