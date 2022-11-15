<?php

/**
 * Dev configuration
 */
 define('ENVIRONMENT', ($_ENV['ENVIRONMENT'] ?? 'development'));
 
 define('ROOT_PATH', __DIR__);
 define('PATH', dirname(dirname(__FILE__)));


/**
 * Database configuration
 */

define('DB_USERNAME', ($_ENV['DB_USERNAME'] ?? 'root'));
define('DB_PASSWORD', ($_ENV['DB_PASSWORD'] ?? ''));
define('DB_HOST', ($_ENV['DB_HOST'] ?? 'localhost'));
define('DB_NAME', ($_ENV['DB_NAME'] ?? 'siegvadbd'));

//referencia generado con MD5(uniqueid(<some_string>, true))
define('API_KEY', ($_ENV['API_KEY'] ?? '828fbcc651f82f21e0b6fc0c23a4f5c4'));

/**
 * API Response HTTP CODE
 * Used as reference for API REST Response Header
 *
 */
/*
200 	OK
201 	Created
304 	Not Modified
400 	Bad Request
401 	Unauthorized
403 	Forbidden
404 	Not Found
422 	Unprocessable Entity
500 	Internal Server Error
*/

?>