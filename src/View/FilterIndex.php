<?php
    namespace App\View;

    use Twig\Environment;
    use Twig\Loader\FilesystemLoader;

    class FilterIndex
    {
        private $model;

        public function __construct($model) {
            $this->model = $model;
        }

        public function output() {
          require('header.php');

          $loader = new FilesystemLoader(__DIR__ . '/templates');
          $twig = new Environment($loader);

           $kanaPrefixHeader = $this->model->kanaPrefixHeader();
          // $namePrefixHeader = $this->model->namePrefixHeader();
          // $motoDisplacementHeader = $this->model->motoDisplacementHeader();
          // $markertHeader = $this->model->markertHeader();

          // $kanaPrefixHasModel = $this->model->kanaPrefixHasModel();
          // $namePrefixHasModel = $this->model->namePrefixHasModel();
          // $displacementHasModel = $this->model->displacementHasModel();

          echo $twig->render('FilterIndex.html.twig', 
              [
                'kanaPrefixHeader'        => $this->model->kanaPrefixHeader(), 
                'namePrefixHeader'        => $this->model->namePrefixHeader(),
                'motoDisplacementHeader'  => $this->model->motoDisplacementHeader(),
                'markertHeader'           => $this->model->markertHeader(),
                'kanaPrefixHasModel'      => $this->model->kanaPrefixHasModel(),
                'namePrefixHasModel'      => $this->model->namePrefixHasModel(),
                'displacementHasModel'    => $this->model->displacementHasModel()
              ]);

          //  echo '<pre>';
          //  print_r($kanaPrefixHeader);
          //  echo '</pre>';
        }
    }
?>