<?php
namespace Tests;

use PHPUnit\Framework\TestCase;
use App\Config\Connection;
use PDO;
use Doctrine\DBAL\Types\Types;
use App\Model\MotobikeModel;

class MotobikeModelTest extends TestCase
{
    public function testKanaPrefixHasModel()
    {
        $inputData = [
            ['model_code' => 0, 'model_kana_prefix' =>  'ア'],
            ['model_code' => 1, 'model_kana_prefix' =>  ''  ],
            ['model_code' => 2, 'model_kana_prefix' =>  'マ'],
            ['model_code' => 3, 'model_kana_prefix' =>  'キ'],
            ['model_code' => 4, 'model_kana_prefix' =>  'ア'],
            ['model_code' => 5, 'model_kana_prefix' =>  ''  ],
            ['model_code' => 6, 'model_kana_prefix' =>  'ヌ']
        ];

        $conn = Connection::getConnection('DbTest');

        $conn->beginTransaction();

        $this->insertDumyDataForTestKanaPrefixHasModel($conn, $inputData);

        $expectedResult = array('ア', 'カ', 'ナ', 'マ');
        
        $resultData = (new MotobikeModel())->kanaPrefixHasModel('DbTest');

        $this->assertEquals($expectedResult, $resultData);

        $conn->rollBack();
    }

    public function testNamePrefixHasModel()
    {
        $inputData = [
            ['model_code' => 0, 'model_name_prefix' =>  'A'],
            ['model_code' => 1, 'model_name_prefix' =>  ''  ],
            ['model_code' => 2, 'model_name_prefix' =>  'M'],
            ['model_code' => 3, 'model_name_prefix' =>  ''],
            ['model_code' => 4, 'model_name_prefix' =>  'G'],
            ['model_code' => 5, 'model_name_prefix' =>  ''  ],
            ['model_code' => 6, 'model_name_prefix' =>  'C']
        ];

        $conn = Connection::getConnection('DbTest');

        $conn->beginTransaction();

        $this->insertDumyDataForTestNamePrefixHasModel($conn, $inputData);

        $expectedResult = array('A', 'C', 'G', 'M');
        
        $resultData = (new MotobikeModel())->namePrefixHasModel('DbTest');

        $conn->rollBack();

        $this->assertEquals($expectedResult, $resultData);
    }

    public function testDisplacementHasModel()
    {
        $inputData = [
            ['model_code' => 0, 'model_displacement' =>  '44'],
            ['model_code' => 1, 'model_displacement' =>  '57'  ],
            ['model_code' => 2, 'model_displacement' =>  '1200'],
            ['model_code' => 3, 'model_displacement' =>  '70'],
            ['model_code' => 4, 'model_displacement' =>  '1100'],
            ['model_code' => 5, 'model_displacement' =>  '267'  ],
            ['model_code' => 6, 'model_displacement' =>  '673']
        ];

        $conn = Connection::getConnection('DbTest');

        $conn->beginTransaction();

        $this->insertDumyDataForTestDisplacementHasModel($conn, $inputData);

        $expectedResult = array('50', '51-125', '251-400', '401-750', '1000Up');
        
        $resultData = (new MotobikeModel())->displacementHasModel('DbTest');

        $conn->rollBack();

        $this->assertEquals($expectedResult, $resultData);
    }

    public function testMakerHasModel()
    {
        $tbl_category_maker = [
            ['category_maker_code' => 1, 'maker_code' =>  10],
            ['category_maker_code' => 2, 'maker_code' =>  21],
            ['category_maker_code' => 3, 'maker_code' =>  18],
            ['category_maker_code' => 4, 'maker_code' =>  34],
            ['category_maker_code' => 5, 'maker_code' =>  45],
        ];

        $mst_model_maker = [
            ['model_maker_code' => 10, 'model_maker_hyouji' =>  'AAA'],
            ['model_maker_code' => 15, 'model_maker_hyouji' =>  'BBB'],
            ['model_maker_code' => 21, 'model_maker_hyouji' =>  'CCC'],
            ['model_maker_code' => 24, 'model_maker_hyouji' =>  'DDD'],
            ['model_maker_code' => 45, 'model_maker_hyouji' =>  'EEE'],
        ];

        $mst_model_v2 = [
            ['model_code' => 10, 'model_maker_code' =>  10],
            ['model_code' => 15, 'model_maker_code' =>  15],
            ['model_code' => 21, 'model_maker_code' =>  21],
            ['model_code' => 24, 'model_maker_code' =>  24],
            ['model_code' => 45, 'model_maker_code' =>  25],
        ];

        $conn = Connection::getConnection('DbTest');

        $conn->beginTransaction();

        $this->insertDumyDataForTestMakerHasModel($conn, $tbl_category_maker, $mst_model_maker, $mst_model_v2);

        $expectedResult = array('AAA', 'CCC', 'EEE');
        
        $resultData = (new MotobikeModel())->marketHasModel('DbTest');

        $conn->rollBack();

        $this->assertEquals($expectedResult, $resultData);
    }    

    private function insertDumyDataForTestKanaPrefixHasModel($conn, $inputData)
    {
        $queryBuilder = $conn->createQueryBuilder();

        foreach($inputData as $data)
        {
            $queryBuilder->insert('mst_model_v2')
            ->values(array('model_code' => $data['model_code'], 'model_kana_prefix' =>  "'".$data['model_kana_prefix']."'"))
            ->execute(); 
        }
    }

    private function insertDumyDataForTestNamePrefixHasModel($conn, $inputData)
    {
        $queryBuilder = $conn->createQueryBuilder();

        foreach($inputData as $data)
        {
            $queryBuilder->insert('mst_model_v2')
            ->values(array('model_code' => $data['model_code'], 'model_name_prefix' =>  "'".$data['model_name_prefix']."'"))
            ->execute(); 
        }
    }

    private function insertDumyDataForTestDisplacementHasModel($conn, $inputData)
    {
        $queryBuilder = $conn->createQueryBuilder();

        foreach($inputData as $data)
        {
            $queryBuilder->insert('mst_model_v2')
            ->values(array('model_code' => $data['model_code'], 'model_displacement' =>  "'".$data['model_displacement']."'"))
            ->execute(); 
        }
    }

    private function insertDumyDataForTestMakerHasModel($conn, $tbl_category_maker, $mst_model_maker, $mst_model_v2)
    {
        $queryBuilder = $conn->createQueryBuilder();

        foreach($tbl_category_maker as $data)
        {
            $queryBuilder->insert('tbl_category_maker')
            ->values(array(
                'category_maker_code' => $data['category_maker_code'],
                'maker_code' =>  $data['maker_code']))
            ->execute(); 
        }

        foreach($mst_model_maker as $data)
        {
            $queryBuilder->insert('mst_model_maker')
            ->values(array(
                'model_maker_code' => $data['model_maker_code'],
                'model_maker_hyouji' =>  "'".$data['model_maker_hyouji']."'"))
            ->execute(); 
        } 

        foreach($mst_model_v2 as $data)
        {
            $queryBuilder->insert('mst_model_v2')
            ->values(array(
                'model_code' => $data['model_code'],
                'model_maker_code' =>  "'".$data['model_maker_code']."'"))
            ->execute(); 
        }  
    }
}