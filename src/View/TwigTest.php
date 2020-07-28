<?php
namespace App\View;

use Twig\Environment;
use Twig\Loader\FilesystemLoader;

class TwigTest
{
    public function output()
    {
        $loader = new FilesystemLoader(__DIR__ . '/templates');
        $twig = new Environment($loader);
        
        echo $twig->render('TwigTest.html.twig', ['name' => 'John Doe', 
            'occupation' => 'gardener']);
    }
}