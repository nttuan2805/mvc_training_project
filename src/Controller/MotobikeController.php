<?php
namespace App\Controller;

use App\Config\Connection;
use App\Model\MotobikeModel;
use App\View\FilterIndex;

class MotobikeController
{ 
    private $view;

    public function filterIndex()
    {
        $this->view = new FilterIndex(new MotobikeModel);
        $this->view->output();
    }
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