<?php
namespace App\Config;

class Config
{
    private static $instance = NULL;
    private static $config;

    private function __construct()
    {
        
    }

    public static function getInstance()
    {
        if (!isset(self::$instance)) {
       
            self::$instance = new Config();
          }
          return self::$instance;        
    }

    public function get($key, $default = null)
    {
        if (is_null(self::$config)) {
            self::$config = require_once('configs.php');
        }

        return !empty(self::$config[$key])?self::$config[$key]:$default;
    }
}