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

    public static function getConnection($dbType)
    {
        if (!isset(self::$conn))
        {
            $db = Config::getInstance()->get($dbType);

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
}