<?php

include('confidential.php');

ini_set('display_errors', 1);
ini_set('display_stsartup_errors', 1);
error_reporting(E_ERROR);

define('HOST', 'localhost');
define('DBNAME', 'eleicoesuni');
define('DBUSER', USER);
define('DBPASS', SENHA);

define('DS', DIRECTORY_SEPARATOR);
define('DIR_APP', __DIR__);
define('DIR_PROJETO', 'api');

if (file_exists('autoload.php')) {
    include 'autoload.php';
} else {
    echo 'Erro ao incluir bootstrap'; exit;
}