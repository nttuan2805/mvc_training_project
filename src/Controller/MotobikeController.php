<?php
namespace App\Controller;

use App\Config\Connection;

class MotobikeController
{
    public function filterByKanaPrefix()
    { 
    
        $conn = Connection::getConnection();
        $queryBuilder = $conn->createQueryBuilder();
        $queryBuilder->select('*')->from('mst_area');

        $stm = $queryBuilder->execute();
        $data = $stm->fetchAll();

        echo '<pre>';
        print_r($data);
        echo '</pre>';
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