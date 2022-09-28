<?php 

require_once '../include/Config.php';
require_once PATH.'/src/Models/Response.php';

class CallBD {
    
    private $conn;
    private $response;

    function __construct() {
        $this->response = new Response();
    }

    private function connection(){
        require_once ROOT_PATH . '/DbConnect.php';
        $db = new DbConnect();
        $error = $db->connect();
        if($error == null){
            $this->conn = $db->conn;
        }
        return $error;
    }

    public function callDBReturn($query, $return)
    {
            $error = $this->connection();
            if($error == null){
                $sql = $query;
                $queryResponse = null;
                $cont = '';
                $q = $this->conn->query($sql);
                $q->setFetchMode(PDO::FETCH_ASSOC);
                $queryResponse = $q->fetch();
                return $queryResponse[$return];
            }else{
                return null;
            }
            return $this->response;
    }

    public function callDB($query, $label, $all)
    {
        try {
            $error = $this->connection();
            if($error == null){
                $sql = $query;
                $queryResponse = null;
                $cont = '';
                $q = $this->conn->query($sql);
                $q->setFetchMode(PDO::FETCH_ASSOC);
                if($all){
                    $queryResponse = $q->fetchAll();
                    $cont = count($queryResponse);
                    if($cont == 0){
                        $queryResponse = array();
                    }
                }else{
                    $queryResponse = $q->fetch();
                }
    
                $this->response->status = 200;
                $this->response->message =  $label.$cont ;
                $this->response->body = $queryResponse ? $queryResponse : null ;
            }else{
                $this->response->status = 500;
                $this->response->message = $error;
                $this->response->body = null;
            }
            return $this->response;
        } catch(Exception $e){
            $this->response->status = 500;
            $this->response->message = $e->getMessage();
            if($all){
                $this->response->body = array();
            }else{
                $this->response->body = null;
            }
            return $this->response;
        }
    }

    public function resolveCallBD($type, $e){
        if($type){
            $this->response->status = 200;
            $this->response->message = $e;
            $this->response->body = null;
        }else{
            $this->response->status = 500;
            $this->response->message = $e->getMessage();
            $this->response->body = null;
        }
        return $this->response;
    }


}

?>
