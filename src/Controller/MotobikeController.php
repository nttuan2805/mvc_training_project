<?php
namespace App\Controller;
use App\Config\Database;
use PDO;
use PDOException;

class MotobikeController
{
    public function filterByKanaPrefix()
    { 
    
        $fluent = Database::getInstance();
        $query = $fluent->from('mst_area')->limit(5);

        foreach ($query as $row) {
            echo '<pre>';
            print_r($row);
            echo '</pre>';
        }
    //     try {
    //         $db = Database::getInstance();
    //         $stm = $db->query('SELECT * FROM mst_area limit 1');

    //         while ($row = $stm->fetch())
    //         {
    //             echo '<pre>';
    //             print_r($row);
    //             echo '</pre>';
    //         } 
    //    } catch (PDOException $e) {
    //         print "Error!: " . $e->getMessage() . "<br/>";
    //         die();
    //    }
    }

    public function filterByNamePrefix()
    {

    }

    public function filterByDisplacement()
    {
        
    }

    public function filterByMaker()
    {
        
    }
}