<?php
namespace App\Model;

use App\Config\Connection;
use PDO;



class MotobikeModel
{
    private $alphabel_jp = [
        'a'  => ['ア', 'イ', 'ウ', 'エ', 'オ'],
        'ka' => ['カ', 'キ', 'ク', 'ケ', 'コ'],
        'sa' => ['サ', 'シ', 'ス', 'セ', 'ソ'],
        'ta' => ['タ', 'チ', 'ツ', 'テ', 'ト'],
        'na' => ['ナ', 'ニ', 'ヌ', 'ネ', 'ノ'],
        'ha' => ['ハ', 'ヒ', 'フ', 'ヘ', 'ホ'],
        'ma' => ['マ', 'ミ', 'ム', 'メ', 'モ'],
        'ya' => ['ヤ', 'ジ', 'ズ', 'ゼ', 'ゾ'],
        'ra' => ['ラ', 'リ', 'ル', 'レ', 'ロ'],
        'wa' => ['ワ', 'ヲ']
    ];

     private $alphabel_en = [
         'A', 'B', 'C', 'D', 'E', 'F', 'G', 'H', 'I',
         'J', 'K', 'L', 'M', 'N', 'O', 'P', 'Q', 'R',
         'S', 'T', 'U', 'V', 'W', 'X', 'Y', 'Z'
     ];

    private $motoDisplacement = [
        '50cc' => [0, 50],
        '51-125' => [51, 125],
        '126-250' => [126, 250],
        '251-400' => [251, 400],
        '401-750' => [401, 750],
        '751-1000' => [751, 1000],
        '1000' => [1000, 100000]
    ];

    public function kanaPrefixHeader()
    {
        return array_keys($this->alphabel_jp);
    }

    public function namePrefixHeader()
    {
        return $this->alphabel_en;
    }

    public function motoDisplacementHeader()
    {
        return array_keys($this->motoDisplacement);
    }

    public function markerHeader()
    {
        // Query
        /*
            SELECT
            model_maker_code,
            model_maker_hyouji
            FROM mst_model_maker
            GROUP BY model_maker_code, model_maker_hyouji

        */
        $conn = Connection::getConnection();
        $queryBuilder = $conn->createQueryBuilder();
        $queryBuilder->select('model_maker_code', 'model_maker_hyouji')
                    ->from('mst_model_maker')
                    ->groupby('model_maker_code, model_maker_hyouji')
                    ->orderby('model_maker_code')
                    ->setMaxResults(15);

        $stm = $queryBuilder->execute();
        $makers = $stm->fetchAll();

        return $makers;
    }

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

        foreach($this->motoDisplacement as $key => $value)
        {
            foreach($data as $val)
            {
                if ($val > $value[0] && $val <= $value[1])
                {
                    array_push($displacements,  $key);
                    break;
                }
            }
        }

        return $displacements;
    }

    public function markerHasModel()
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
        $queryBuilder->select('m.model_maker_code')
                    ->from('mst_model_maker', 'm')
                    ->leftJoin('m', 'mst_model_v2', 'v2', 'v2.model_maker_code = m.model_maker_code')
                    ->where($queryBuilder->expr()->in('m.model_maker_code', $makerCodes))
                    ->groupby('m.model_maker_code')
                    ->orderby('m.model_maker_select_view_no');

        $stm = $queryBuilder->execute();
        $makerNames = $stm->fetchAll(PDO::FETCH_COLUMN);
        return $makerNames;
    }

    public function filterMotobikeList($kanaPrefixs=null, $namePrefixs=null, $displacements=null, $makers=null)
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
                AND model_name_prefix = 'A'
                AND model_displacement > 50
                AND model_displacement <= 250
                AND model_count > 0
            ORDER BY model_kana_prefix;
        */

        $conn = Connection::getConnection();
        $queryBuilder = $conn->createQueryBuilder();
        $queryBuilder->select(
                            'model_name',
                            'model_hyouji',
                            'model_count',
                            'TRUNCATE(IFNULL(model_kakaku_min, 0) / 10000, 2) as model_kakaku_min',
                            'TRUNCATE(IFNULL(model_kakaku_max, 0) / 10000, 2) as model_kakaku_max',
                            'model_image_url')
                        ->from('mst_model_v2');

        if(!empty($kanaPrefixs))
        {
            $kanaPrefixs = "'" . implode("', '", $this->alphabel_jp[$kanaPrefixs]) . "'";
            $queryBuilder->where($queryBuilder->expr()->in('model_kana_prefix', $kanaPrefixs));
        }

        if(!empty($namePrefixs))
        {
            $namePrefixs = "'" . $namePrefixs . "'";
            if(!empty($kanaPrefixs))
            {
                $queryBuilder->andWhere($queryBuilder->expr()->in('model_name_prefix', $namePrefixs));
            }
            else
            {
                $queryBuilder->where($queryBuilder->expr()->in('model_name_prefix', $namePrefixs));
            }
        }

        if(!empty($displacements))
        {

            $fromDisplace = $this->motoDisplacement[$displacements][0];
            $toDisplace = $this->motoDisplacement[$displacements][1];

            if(!empty($kanaPrefixs) || !empty($namePrefixs))
            {
                
                $queryBuilder->andWhere($queryBuilder->expr()->gt('model_displacement', $fromDisplace));
                $queryBuilder->andWhere($queryBuilder->expr()->lte('model_displacement', $toDisplace));
            }
            else
            {
                $queryBuilder->where($queryBuilder->expr()->gt('model_displacement', $fromDisplace));
                $queryBuilder->andWhere($queryBuilder->expr()->lte('model_displacement', $toDisplace));
            }
        }

        $queryBuilder->andWhere('model_count > 0')
                    ->orderby('model_kana_prefix');

        $stm = $queryBuilder->execute();
        $motobikeList = $stm->fetchAll();

        return $motobikeList;
    }

}