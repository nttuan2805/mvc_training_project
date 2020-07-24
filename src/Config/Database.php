<?php
namespace App\Config;

use Envms\FluentPDO\Query;

class Database
{
    private static $instance = NULL;

    private function __construct()
    {
        
    }

    public static function getInstance()
    {
        if (!isset(self::$instance))
        {
            self::$instance = new Connection(Config::getInstance()->get('Db'));
        }

        return new Query(self::$instance);
    }

    public static function closeConnection()
    {
        if (isset(self::$instance))
        {
            self::$instance = null;
        }
    }
}