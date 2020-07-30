<?php
namespace App\Controller;

use App\Model\MotobikeModel;
use App\View\MotobikeView;

class MotobikeController
{ 
    private $view;

    public function filterIndex()
    {
        $this->view = new MotobikeView(new MotobikeModel);
        $this->view->filterPageOutput();
    }
}