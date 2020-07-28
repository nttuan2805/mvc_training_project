<?php
use Faker\Factory;
use Twig\Environment;
use Twig\Loader\FilesystemLoader;
use App\Test\User;

$loader = new FilesystemLoader(__DIR__ . '/FakeTemplate');
$twig = new Environment($loader);

$faker = Factory::create();

$users = [];

for ($i = 0; $i < 20; $i++) 
{
    $firstName = $faker->firstName;
    $lastName = $faker->lastName;
    $occupation = $faker->jobTitle;

    $user = new User($firstName, $lastName, $occupation);
    array_push($users, $user);
}

$content = $twig->render('users.xml.twig', ['users' => $users]);
file_put_contents(__DIR__ . '/FakeXmlData/users.xml', $content);