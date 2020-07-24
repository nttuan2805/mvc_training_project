<?php
namespace App\Config;

use PDO;

class Connection extends PDO
{
    public function __construct($db)
    {
        $dsn = $db['TYPE'] . ':dbname=' . $db['NAME'] . ';host=' . $db['HOST'] . ';port=' . $db['PORT'] ;

        $options = [
            PDO::ATTR_ERRMODE            => PDO::ERRMODE_EXCEPTION,
            PDO::ATTR_DEFAULT_FETCH_MODE => PDO::FETCH_ASSOC,
            PDO::ATTR_EMULATE_PREPARES   => false,
        ];

        parent::__construct($dsn, $db['USER'], $db['PASS'], $options);
    }
}