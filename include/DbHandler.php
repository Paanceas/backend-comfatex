<?php
/**
 *
 * @About:      Database connection manager class
 * @File:       Maphis.php
 * @Date:       $Date:$ SEP 2022
 * @Version:    $Rev:$ 1.0
 * @Developer:  Pablo Ceballos
 **/
class DbHandler {
 
    private $conn;
 
    function __construct() {
        require_once dirname(__FILE__) . './DbConnect.php';
        // opening db connection
        $db = new DbConnect();
        $this->conn = $db->connect();
    }
 
    public function createAuto($array)
    {
        //aqui puede incluir la logica para insertar el nuevo auto a tu base de datos
    }
 
}
 
?>