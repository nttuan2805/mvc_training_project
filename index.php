<?php
require __DIR__.'/vendor/autoload.php';

use App\Config\Connection;
use App\Config\Database;
use App\Lib\Router;
use App\Controller\MotobikeController;
use App\Model\MotobikeModel;
use App\View\TestSmarty;
use App\View\TwigTest;
use Faker\Factory;

// Router::get('/', function () {
//     echo 'Hello World';
// });

// Router::get('/post/([0-9]*)', function (Request $req, Response $res) {
//     $res->toJSON([
//         'post' =>  ['id' => $req->params[0]],
//         'status' => 'ok'
//     ]);
// });

// Router::get('/', function () {
//     //(new MotobikeController())->filterByKanaPrefix();
//     (new MotobikeModel())->marketHasModel();
// });

// Router::get('/', function () {
//     //(new MotobikeController())->filterByKanaPrefix();
//     $motobikeList = (new MotobikeModel())->filterMotobikeListByKanaPrefix('ア');
//     echo '<pre>';
//     print_r($motobikeList);
//     echo '</pre>';
// });

Router::get('/', function () {
    //(new MotobikeController())->filterByKanaPrefix();
    (new MotobikeController())->filterIndex();
});

Router::get('/hello', function () {
    //(new MotobikeController())->filterByKanaPrefix();
    (new TwigTest())->output();
});

Connection::closeConnection();

// $faker = Factory::create();

// $faker->seed(1234);

// echo $faker->name() . "<br />";
// echo $faker->name('male') . "<br />";
// echo $faker->name('female') . "<br />";

//require __DIR__.'/src/Test/UserFake.php';