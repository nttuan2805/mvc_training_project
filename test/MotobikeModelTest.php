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
}