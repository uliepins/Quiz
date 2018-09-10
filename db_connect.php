<?php
function db_connect() {
    static $connection;
    if(!isset($connection)) {
		// credentials for db connection
		$servername = "localhost";
		$username = "username"; // change this
		$password = "password"; // change this
		$dbname = "c1Quiz";
		// connect mysql
		$connection = mysqli_connect($servername,$username,$password,$dbname);
    }
    // if connection was unsuccessful, return error
    if($connection === false) {
        return mysqli_connect_error(); 
    }
    return $connection;
}
// try to connect db
$connection = db_connect();
// check for failure
if ($connection->connect_error) {
    die("Connection failed: " . $connection->connect_error);
}
?> 