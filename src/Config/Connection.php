<?php
namespace App\Config;

use Doctrine\DBAL\DriverManager;
use PDO;

class Connection
{
    private static $conn = NULL;

    private function __construct()
    {
        
    }

    public static function getConnection()
    {
        if (!isset(self::$conn))
        {
            $db = Config::getInstance()->get('Db');

            $options = [
                PDO::ATTR_ERRMODE            => PDO::ERRMODE_EXCEPTION,
                PDO::ATTR_DEFAULT_FETCH_MODE => PDO::FETCH_ASSOC,
                PDO::ATTR_EMULATE_PREPARES   => false,
            ];

            $connectionParams = array(
                'driver'    => $db['DRIVER'],
                'host'      => $db['HOST'],
                'port'      => $db['PORT'],
                'dbname'    => $db['NAME'],
                'user'      => $db['USER'],
                'password'  => $db['PASS'],
                'driverOptions '   => $options
            );

            self::$conn = DriverManager::getConnection($connectionParams);
        }

        return self::$conn;
    }

    public static function closeConnection()
    {
        if (isset(self::$conn))
        {
            self::$conn->close();
        }
    }

    // public function __construct($db)
    // {
    //     $connectionParams = array(
    //         'driver'    => $db['DRIVER'],
    //         'host'      => $db['HOST'],
    //         'port'      => $db['PORT'],
    //         'dbname'    => $db['NAME'],
    //         'user'      => $db['USER'],
    //         'password'  => $db['PASS']
    //     );        

    //     //$dsn = $db['TYPE'] . ':dbname=' . $db['NAME'] . ';host=' . $db['HOST'] . ';port=' . $db['PORT'] ;

    //     // $options = [
    //     //     PDO::ATTR_ERRMODE            => PDO::ERRMODE_EXCEPTION,
    //     //     PDO::ATTR_DEFAULT_FETCH_MODE => PDO::FETCH_ASSOC,
    //     //     PDO::ATTR_EMULATE_PREPARES   => false,
    //     // ];

    //     //parent::__construct($dsn, $db['USER'], $db['PASS'], $options);

        
    // }
}