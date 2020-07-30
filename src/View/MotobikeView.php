<?php
    namespace App\View;

    use Twig\Environment;
    use Twig\Loader\FilesystemLoader;

    class MotobikeView
    {
        private $model;
        private $twig;

        public function __construct($model = null) {
            $loader = new FilesystemLoader(__DIR__ . '/templates');
            $this->twig   = new Environment($loader);
            $this->model = $model;
        }

        public function filterPageOutput() {
          echo $this->twig->render('MotobikeIndexPage.html.twig', 
              [
                'kanaPrefixHeader'        => $this->model->kanaPrefixHeader(), 
                'namePrefixHeader'        => $this->model->namePrefixHeader(),
                'motoDisplacementHeader'  => $this->model->motoDisplacementHeader(),
                'markerHeader'            => $this->model->markerHeader('Db'),

                'kanaPrefixHasModel'      => $this->model->kanaPrefixHasModel('Db'),
                'namePrefixHasModel'      => $this->model->namePrefixHasModel('Db'),
                'displacementHasModel'    => $this->model->displacementHasModel('Db'),
                'markerHasModel'          => $this->model->markerHasModel('Db')
              ]);
        }

        public function filterResultOutput($result) 
        {          
            echo $this->twig->render('MotobikeFilterResult.html.twig', ['result' => $result,]);
        }
    }
?>