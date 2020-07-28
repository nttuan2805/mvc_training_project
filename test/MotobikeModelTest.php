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

        $this->insertDumyData($inputData);

        $expectedResult = array('ア', 'カ', 'ナ', 'マ');
        
        $resultData = (new MotobikeModel())->kanaPrefixHasModel('DbTest');

        $this->assertEquals($expectedResult, $resultData);
    }

    private function insertDumyData($inputData)
    {
        $conn = Connection::getConnection('DbTest');
        $queryBuilder = $conn->createQueryBuilder();

        foreach($inputData as $data)
        {
            $queryBuilder->insert('mst_model_v2')
            ->values(array('model_code' => $data['model_code'], 'model_kana_prefix' =>  "'".$data['model_kana_prefix']."'"))
            ->execute(); 
        }
    }
}