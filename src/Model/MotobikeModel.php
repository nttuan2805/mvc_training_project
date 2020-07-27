<?php
namespace App\Model;

use App\Config\Connection;
use PDO;
use Doctrine\DBAL\Types\Types;



class MotobikeModel
{
    private $alphabel_jp = [
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

    // private $alphabel_en = [
    //     'A', 'B', 'C', 'D', 'E', 'F', 'G', 'H', 'I',
    //     'J', 'K', 'L', 'M', 'N', 'O', 'P', 'Q', 'R',
    //     'S', 'T', 'U', 'V', 'W', 'X', 'Y', 'Z'
    // ];

    private $motoDisplacement = [
        '50cc' => [0, 50],
        '51-125cc' => [51, 125],
        '126-250cc' => [126, 250],
        '251-400cc' => [251, 400],
        '401-750cc' => [401, 750],
        '751-1000cc' => [751, 1000],
        '1000cc' => [1000, 100000]
    ];



    public function kanaPrefixHasModel()
    {
        // Query
        /*
            select model_kana_prefix
            from mst_model_v2
            where  NULLIF(model_kana_prefix, ' ') IS NOT NULL
            group by model_kana_prefix
            order by model_kana_prefix;
        */
        $conn = Connection::getConnection();
        $queryBuilder = $conn->createQueryBuilder();
        $queryBuilder->select('model_kana_prefix')
                    ->from('mst_model_v2')
                    ->where("NULLIF(model_kana_prefix, ' ') IS NOT NULL")
                    ->groupby('model_kana_prefix')
                    ->orderby('model_kana_prefix');

        $stm = $queryBuilder->execute();
        $data = $stm->fetchAll(PDO::FETCH_COLUMN);
        $kanaPrefixs = array();

        foreach($this->alphabel_jp as $key => $value)
        {
            foreach($value as $val)
            {
                if(in_array($val, $data))
                {
                    array_push($kanaPrefixs, $key);
                    break;
                }
            }
        }

        // echo '<pre>';
        // var_dump($kanaPrefixs);
        // echo '</pre>';
        return $kanaPrefixs;
    }

    public function namePrefixHasModel()
    {
        // Query
        /*
            select model_name_prefix
            from mst_model_v2
            where  NULLIF(model_name_prefix, ' ') IS NOT NULL
            group by model_kana_prefix
            order by model_kana_prefix;
        */
        $conn = Connection::getConnection();
        $queryBuilder = $conn->createQueryBuilder();
        $queryBuilder->select('model_name_prefix')
                    ->from('mst_model_v2')
                    ->where("NULLIF(model_name_prefix, ' ') IS NOT NULL")
                    ->groupby('model_name_prefix')
                    ->orderby('model_name_prefix');

        $stm = $queryBuilder->execute();
        $namePrefixs = $stm->fetchAll(PDO::FETCH_COLUMN);
        //$namePrefixs = array();

        // echo '<pre>';
        // print_r($data);
        // echo '</pre>';

        // foreach($this->alphabel_en as $al)
        // {
        //     if(in_array($al, $data))
        //     {
        //         array_push($namePrefixs, $al);
        //     }
        // }

        // echo '<pre>';
        // var_dump($namePrefixs);
        // echo '</pre>';
        return $namePrefixs;
    }

    public function displacementHasModel()
    {
        // Query
        /*
            select model_displacement
            from mst_model_v2
            group by model_displacement
            order by model_displacement;
        */
        $conn = Connection::getConnection();
        $queryBuilder = $conn->createQueryBuilder();
        $queryBuilder->select('model_displacement')
                    ->from('mst_model_v2')
                    ->where("NULLIF(model_displacement, ' ') IS NOT NULL")
                    ->groupby('model_displacement')
                    ->orderby('model_displacement');

        $stm = $queryBuilder->execute();
        $data = $stm->fetchAll(PDO::FETCH_COLUMN);
        $displacements = array();
        echo '<pre>';
        print_r($data);
        echo '</pre>';

        foreach($this->motoDisplacement as $key => $value)
        {
            //echo $value[0] . '~' . $value[1] . '<br />';
            foreach($data as $val)
            {
                if ($val > $value[0] && $val <= $value[1])
                {
                    array_push($displacements,  $key);
                    break;
                }
            }
        }

        // echo '<pre>';
        // print_r($displacements);
        // echo '</pre>';
        return $displacements;
    }

    public function marketHasModel()
    {
        // Query
        /*
            SELECT maker_code
            FROM tbl_category_maker
            GROUP BY maker_code
            ORDER BY maker_code

        */

        $conn = Connection::getConnection();
        $queryBuilder = $conn->createQueryBuilder();
        $queryBuilder->select('maker_code')
                    ->from('tbl_category_maker')
                    ->groupby('maker_code')
                    ->orderby('maker_code');

        $stm = $queryBuilder->execute();
        $makerCodes = $stm->fetchAll(PDO::FETCH_COLUMN);

        echo '<pre>';
        print_r($makerCodes);
        echo '</pre>';

        // Query
        /*
            SELECT
            m.model_maker_code,
            IFNULL(SUM(v2.model_count),0) AS model_count,
            m.model_maker_hyouji
            FROM mst_model_maker m
            LEFT JOIN mst_model_v2 v2
                ON v2.model_maker_code = m.model_maker_code 
            WHERE m.model_maker_code IN (1, 2, 3, 4)
            GROUP BY m.model_maker_code
            ORDER BY m.model_maker_select_view_no;
        */
        $queryBuilder->select('m.model_maker_hyouji')
                    ->from('mst_model_maker', 'm')
                    ->leftJoin('m', 'mst_model_v2', 'v2', 'v2.model_maker_code = m.model_maker_code')
                    ->where($queryBuilder->expr()->in('m.model_maker_code', $makerCodes))
                    ->groupby('m.model_maker_code')
                    ->orderby('m.model_maker_select_view_no');

        $stm = $queryBuilder->execute();
        $makerNames = $stm->fetchAll(PDO::FETCH_COLUMN);
        // echo '<pre>';
        // print_r($makerNames);
        // echo '</pre>';
        return $makerNames;
    }

    public function filterMotobikeListByKanaPrefix($kanaPrefix)
    {
        // Query
        /*
            SELECT
                model_name,
                model_hyouji,
                model_count,
                TRUNCATE(IFNULL(model_kakaku_min, 0) / 10000, 2) as model_kakaku_min,
                TRUNCATE(IFNULL(model_kakaku_max, 0) / 10000, 2) as model_kakaku_max
            FROM
                mst_model_v2
            WHERE
                model_kana_prefix IN ('ア', 'イ', 'ウ', 'エ', 'オ') 
                AND model_count > 0
            ORDER BY model_kana_prefix;
        */
        echo '<pre>';
        print_r($this->alphabel_jp[$kanaPrefix]);
        echo '</pre>';

        $kanaPrefixs = "'" . implode("', '", $this->alphabel_jp[$kanaPrefix]) . "'";

        $conn = Connection::getConnection();
        $queryBuilder = $conn->createQueryBuilder();
        $queryBuilder->select(' model_name')
                        ->from('mst_model_v2')
                        //->where('model_kana_prefix IN (:kanas)')
                        ->where($queryBuilder->expr()->in('model_kana_prefix', $kanaPrefixs))
                        ->andWhere('model_count > 0')
                        ->orderby('model_kana_prefix');

        $stm = $queryBuilder->execute();
        $motobikeList = $stm->fetchAll(PDO::FETCH_COLUMN);
        return $motobikeList;
    }

    public function getMotobikeListByDisplacementList()
    {
        
    }

    public function getMotobikeListByMakerList()
    {

    }

}