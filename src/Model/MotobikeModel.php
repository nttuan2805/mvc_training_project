<?php
namespace App\Model;

use App\Config\Connection;
use App\Config\Database;

class MotobikeModel
{
    const ALPHABET_JP = [
        'ア' => ['ア', 'イ', 'ウ', 'エ', 'オ'],
        'カ' => ['カ', 'キ', 'ク', 'ケ', 'コ'],
        'サ' => ['サ', 'シ', 'ス', 'セ', 'ソ'],
        'タ' => ['タ', 'チ', 'ツ', 'テ', 'ト'],
        'ナ' => ['ナ', 'ニ', 'ヌ', 'ネ', 'ノ'],
        'ハ' => ['ハ', 'ヒ', 'フ', 'ヘ', 'ホ'],
        'マ' => ['マ', 'ミ', 'ム', 'メ', 'モ'],
        'ヤ' => ['ヤ', 'ジ', 'ズ', 'ゼ', 'ゾ'],
        'ラ' => ['ラ', 'リ', 'ル', 'レ', 'ロ'],
        'ワ' => ['ワ', 'ヲ']
    ];

    const ALPHABET_EN = [
        'A', 'B', 'C'
    ];

    public function kanaPrefix()
    {
        $sql = "
        SELECT model_kana_prefix 
        FROM mst_model_v2
        GROUP BY model_kana_prefix
        HAVING NULLIF(model_kana_prefix, '') IS NOT NULL 
        ORDER BY model_kana_prefix";

        $conn = Connection::getConnection();
        $queryBuilder = $conn->createQueryBuilder();
        $queryBuilder->select('model_kana_prefix')
                    ->from('mst_model_v2')
                    ->groupby('model_kana_prefix')
                    ->orderby('model_kana_prefix');

        $stm = $queryBuilder->execute();
        $data = $stm->fetchAll();

        echo '<pre>';
        print_r($data);
        echo '</pre>';
    }

    /*
        display and filter by kana prefix (頭文字 row at index page)
    */
    public function getAlphabetJapaneseList()
    {
        // get kana prefix list from key array of the constant ALPHABET_JP
        // display at 頭文字 row at index page
    }

    public function getMotobikeListByKanaPrefix($kanaPrefix)
    {
        // When user click kana prefix at 頭文字 (index page), 
        // will get Motobike List by the Kana Prefix
        // Ouput: Motobike List and order by Kana Prefix
    }

    /*
        display and filter by name prefix (英文字 row at index page)
    */
    public function getAlphabetEnglishList()
    {
        // get name prefix list from key array of the constant ALPHABET_EN
        // display at 英文字 row at index page
    }

    public function getMotobikeListByNamePrefix($namePrefix)
    {
        // When user click name prefix at 英文字 (index page), 
        // will get Motobike List by the Name Prefix
        // Ouput: Motobike List and order by Name Prefix
    }

    public function getDisplacementList()
    {

    }

    public function getMotobikeListByDisplacementList()
    {
        
    }

    public function getMakerList()
    {

    }

    public function getMotobikeListByMakerList()
    {

    }

}