<?php
require __DIR__.'/vendor/autoload.php';

use App\Config\Connection;
use App\Lib\Router;
use App\Controller\MotobikeController;
use App\Model\MotobikeModel;
use App\View\MotobikeView;
use App\Test\MotobikeModelTest;

Router::get('/', function () {
    (new MotobikeController())->filterIndex();
    echo 'root';
});

Router::get('/filterMotobike/(.*)', function () {
    // use Ajax to load data
    $url = trim($_SERVER['REQUEST_URI'], '/');
    $url = explode('/', $url);

    $kanaPrefix = $url[1];
    $namePrefix = $url[2];
    $displacement = $url[3];
    $maker = $url[4];  

    $result = (new MotobikeModel())->filterMotobikeList($kanaPrefix, $namePrefix, $displacement, $maker);
    (new MotobikeView(null))->filterResultOutput($result);
});

Connection::closeConnection();