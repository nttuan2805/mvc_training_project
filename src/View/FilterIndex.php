<?php
    namespace App\View;

    class FilterIndex
    {
        private $model;

        public function __construct($model) {
            $this->model = $model;
        }

        public function output() {
          require('header.php');
          $kanaPrefixHeader = $this->model->kanaPrefixHeader();
          $namePrefixHeader = $this->model->namePrefixHeader();
          $motoDisplacementHeader = $this->model->motoDisplacementHeader();
          $markertHeader = $this->model->markertHeader();

          $kanaPrefixHasModel = $this->model->kanaPrefixHasModel();
          $namePrefixHasModel = $this->model->namePrefixHasModel();
          $displacementHasModel = $this->model->displacementHasModel();

          // echo '<pre>';
          // print_r($displacementHasModel);
          // echo '</pre>';

?>
                    <table>
                    <tr>
                      <th>頭文字</th>
                      <td>
                        <?php
                            foreach($kanaPrefixHeader as $kanaPrefix)
                            {
                                $hasOrNotdisabled = !in_array($kanaPrefix, $kanaPrefixHasModel)?'disabled':'';
                                echo "<a href='#' class='" . $hasOrNotdisabled ."'>".$kanaPrefix. "行&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</a>";
                            }
                        ?>
                      </td>
                    </tr>
                    <tr>
                      <th>英数字</th>
                      <td>
                      <?php
                            foreach($namePrefixHeader as $namePrefix)
                            {
                              $hasOrNotdisabled = !in_array($namePrefix, $namePrefixHasModel)?'disabled':'';
                              echo "<a href='#' class='" . $hasOrNotdisabled ."'>".$namePrefix. "&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</a>";
                            }
                        ?>
                      </td>
                    </tr>
                    <tr>
                      <th>排気量</th>
                      <td>
                      <?php
                            foreach($motoDisplacementHeader as $motoDisplacement)
                            {
                              $hasOrNotdisabled = !in_array($motoDisplacement, $displacementHasModel)?'disabled':'';
                              echo "<a href='#' class='" . $hasOrNotdisabled ."'>".$motoDisplacement. "&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</a>";
                            }
                        ?>
                      </td>
                    </tr>
                    <tr>
                      <th>メーカー</th>
                      <td>
                      <?php
                            foreach($markertHeader as $markert)
                            {
                                echo "<a href='#'>".$markert."&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</a>";
                            }
                        ?>
                      </td>
                    </tr>
                  </table>

          <?php
        }
    }
?>