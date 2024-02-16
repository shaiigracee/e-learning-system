<?php
if(!defined('DB_SERVER')){
    require_once("../initialize.php");
}
class DBConnection{

    private $host = DB_SERVER;
    private $username = DB_USERNAME;
    private $password = DB_PASSWORD;
    private $database = DB_NAME;
    
    public $conn;
    
    public function __construct(){

        if (!isset($this->conn)) {
            
            $this->conn = new PDO("mysql:host=127.0.0.1:3306;dbname=".$this->database."", 'root', '');
            $this->conn->setAttribute(PDO::ATTR_ERRMODE, PDO::ERRMODE_EXCEPTION);
            
            // if (!$this->conn) {
            //     echo 'Cannot connect to database server';
            //     exit;
            // }            
        }    
        
    }
    public function __destruct(){
        // $this->conn->close();
    }
}
?>