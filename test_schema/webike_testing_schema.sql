use webike_testing;

-- MySQL Workbench Forward Engineering

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION';

-- -----------------------------------------------------
-- Schema mydb
-- -----------------------------------------------------
-- -----------------------------------------------------
-- Schema webike_testing
-- -----------------------------------------------------

-- -----------------------------------------------------
-- Schema webike_testing
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `webike_testing` DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci ;
USE `webike_testing` ;

-- -----------------------------------------------------
-- Table `webike_testing`.`mst_area`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `webike_testing`.`mst_area` (
  `area_code` INT NOT NULL,
  `area_name` VARCHAR(30) CHARACTER SET 'sjis' NULL DEFAULT NULL,
  `area_code2` INT NULL DEFAULT NULL,
  PRIMARY KEY (`area_code`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8;


-- -----------------------------------------------------
-- Table `webike_testing`.`mst_dealer`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `webike_testing`.`mst_dealer` (
  `dealer_searchkey` INT NOT NULL DEFAULT '0',
  `dealer_name` CHAR(150) NOT NULL,
  `dealer_kanri_memo` CHAR(255) NULL DEFAULT NULL,
  `dealer_begin` CHAR(4) NULL DEFAULT NULL,
  `dealer_finish` CHAR(4) NULL DEFAULT NULL,
  `dealer_holiday` CHAR(50) NULL DEFAULT NULL,
  `dealer_url` CHAR(255) NULL DEFAULT NULL,
  `dealer_mail` CHAR(80) NULL DEFAULT NULL,
  `dealer_mail2` VARCHAR(80) NULL DEFAULT NULL COMMENT '第2メールアドレス',
  `dealer_message` LONGTEXT NULL DEFAULT NULL,
  `dealer_yubin` CHAR(7) NULL DEFAULT NULL,
  `dealer_todouhuken` CHAR(8) NULL DEFAULT NULL,
  `dealer_todouhuken_code` INT NULL DEFAULT NULL,
  `dealer_sikutyoson` CHAR(60) NULL DEFAULT NULL,
  `dealer_banti` CHAR(60) NULL DEFAULT NULL,
  `dealer_tel` CHAR(20) NULL DEFAULT NULL,
  `dealer_fax` CHAR(20) NULL DEFAULT NULL,
  `dealer_lon` CHAR(30) NULL DEFAULT NULL,
  `dealer_lat` CHAR(30) NULL DEFAULT NULL,
  `dealer_option1` CHAR(255) NULL DEFAULT NULL,
  `dealer_img_1` CHAR(255) NULL DEFAULT NULL,
  `dealer_option2` CHAR(255) NULL DEFAULT NULL,
  `dealer_effective_flag` INT NOT NULL,
  `dealer_update_user` CHAR(20) NULL DEFAULT NULL,
  `dealer_last_update` TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `dealer_motoview` INT NOT NULL DEFAULT '1',
  `dealer_kyougikai_flag` INT NULL DEFAULT NULL,
  `dealer_sinki_date` DATE NULL DEFAULT NULL,
  `dealer_validity` CHAR(60) NULL DEFAULT NULL,
  `dealer_pr_title_1` CHAR(40) NULL DEFAULT NULL,
  `dealer_pr_1` LONGTEXT NULL DEFAULT NULL,
  `dealer_pr_img_1` VARCHAR(255) NULL DEFAULT NULL,
  `dealer_pr_title_2` CHAR(40) NULL DEFAULT NULL,
  `dealer_pr_2` LONGTEXT NULL DEFAULT NULL,
  `dealer_pr_img_2` VARCHAR(255) NULL DEFAULT NULL,
  `dealer_pr_title_3` CHAR(40) NULL DEFAULT NULL,
  `dealer_pr_3` LONGTEXT NULL DEFAULT NULL,
  `dealer_pr_img_3` VARCHAR(255) NULL DEFAULT NULL,
  `dealer_blog` VARCHAR(255) NULL DEFAULT NULL,
  `dealer_rss` VARCHAR(255) NULL DEFAULT NULL,
  `dealer_charge_type` CHAR(5) NULL DEFAULT NULL,
  `dealer_status` CHAR(1) NULL DEFAULT NULL,
  `dealer_market_charge_type` CHAR(5) NULL DEFAULT NULL,
  `dealer_market_status` CHAR(1) NULL DEFAULT NULL,
  `dealer_default_sale_type` CHAR(1) NULL DEFAULT NULL,
  `dealer_gid` VARCHAR(32) NULL DEFAULT NULL,
  PRIMARY KEY (`dealer_searchkey`),
  INDEX `idx_map` (`dealer_lon` ASC, `dealer_lat` ASC) VISIBLE,
  INDEX `idx_dealer_todouhuken` (`dealer_todouhuken` ASC) VISIBLE,
  INDEX `idx_dealer_charge_type` (`dealer_charge_type` ASC) VISIBLE,
  INDEX `idx_dealer_status` (`dealer_status` ASC) VISIBLE,
  INDEX `idx_dealer_todouhuken_code` (`dealer_todouhuken_code` ASC) VISIBLE)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8;


-- -----------------------------------------------------
-- Table `webike_testing`.`mst_model_maker`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `webike_testing`.`mst_model_maker` (
  `model_maker_code` INT NOT NULL,
  `model_maker_hyouji` VARCHAR(255) NOT NULL,
  `model_maker_name` VARCHAR(255) NULL DEFAULT NULL,
  `model_maker_search` VARCHAR(255) NULL DEFAULT NULL,
  `model_maker_kana` VARCHAR(255) NULL DEFAULT NULL,
  `model_maker_logo` VARCHAR(255) NULL DEFAULT NULL,
  `model_maker_country` VARCHAR(255) NOT NULL,
  `model_maker_view_no` INT NOT NULL,
  `model_maker_select_view_no` INT NOT NULL DEFAULT '9999',
  `model_top_hyouji_flg` INT NULL DEFAULT '0',
  `model_maker_gcode` INT NULL DEFAULT NULL,
  `model_special_maker_flg` INT NULL DEFAULT '0' COMMENT 'シリーズを使うメーカのフラグ',
  PRIMARY KEY (`model_maker_code`),
  UNIQUE INDEX `model_maker_search` (`model_maker_search` ASC) VISIBLE,
  INDEX `idx_model_maker_view_no` (`model_maker_view_no` ASC) VISIBLE)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8;


-- -----------------------------------------------------
-- Table `webike_testing`.`mst_model_series`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `webike_testing`.`mst_model_series` (
  `maker_code` INT NULL DEFAULT NULL,
  `series_code` INT NULL DEFAULT NULL,
  `model_code` INT NULL DEFAULT NULL,
  `created_date` TIMESTAMP NULL DEFAULT CURRENT_TIMESTAMP)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8;


-- -----------------------------------------------------
-- Table `webike_testing`.`mst_model_v2`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `webike_testing`.`mst_model_v2` (
  `model_code` INT NOT NULL,
  `model_maker_code` SMALLINT NOT NULL,
  `model_hyouji` VARCHAR(255) NOT NULL,
  `model_search_key` VARCHAR(255) NULL DEFAULT NULL,
  `model_name` VARCHAR(255) NULL DEFAULT NULL,
  `model_kana` VARCHAR(255) NULL DEFAULT NULL,
  `type_code` INT NULL DEFAULT NULL COMMENT 'id_of_mst_model_type',
  `model_displacement` SMALLINT NOT NULL,
  `model_motortype_code` TINYINT(1) NULL DEFAULT '0',
  `model_genchari` TINYINT(1) NOT NULL DEFAULT '0' COMMENT '原付スクーター',
  `model_scooter` TINYINT(1) NOT NULL DEFAULT '0' COMMENT 'スクーター',
  `model_big_scooter` TINYINT(1) NOT NULL DEFAULT '0' COMMENT 'ビッグスクーター',
  `model_mini_bike` TINYINT(1) NOT NULL DEFAULT '0' COMMENT 'ミニバイク',
  `model_street` TINYINT(1) NOT NULL DEFAULT '0' COMMENT 'ストリート',
  `model_classic` TINYINT(1) NOT NULL DEFAULT '0' COMMENT 'クラシックタイプ',
  `model_naked` TINYINT(1) NOT NULL DEFAULT '0' COMMENT 'ネイキッド',
  `model_replica` TINYINT(1) NOT NULL DEFAULT '0' COMMENT 'スーパースポーツ／レプリカ',
  `model_tourer` TINYINT(1) NOT NULL DEFAULT '0' COMMENT 'スポーツツアラー',
  `model_american` TINYINT(1) NOT NULL DEFAULT '0' COMMENT 'アメリカン／クルーザー',
  `model_off_road` TINYINT(1) NOT NULL DEFAULT '0' COMMENT 'オフロード／モタード',
  `model_import` TINYINT(1) NOT NULL DEFAULT '0' COMMENT '海外メーカー',
  `model_business_bike` TINYINT(1) NOT NULL DEFAULT '0' COMMENT 'ビジネスバイク',
  `model_competition` TINYINT(1) NOT NULL DEFAULT '0' COMMENT 'コンペティション／レーサー',
  `model_ev` TINYINT(1) NOT NULL DEFAULT '0' COMMENT '電動バイク／ATV',
  `model_4mini` TINYINT(1) NOT NULL DEFAULT '0' COMMENT '4ミニ',
  `model_zeppan1` TINYINT(1) NOT NULL DEFAULT '0' COMMENT '絶版車（80年代まで）',
  `model_zeppan2` TINYINT(1) NOT NULL DEFAULT '0' COMMENT '絶版車（80年代以降）',
  `model_vintage` TINYINT(1) NOT NULL DEFAULT '0' COMMENT 'ヴィンテージモトクロス',
  `model_dirt` TINYINT(1) NOT NULL DEFAULT '0' COMMENT 'ダート',
  `model_trial` TINYINT(1) NOT NULL DEFAULT '0' COMMENT 'トライアル',
  `model_street_fighter` TINYINT(1) NOT NULL DEFAULT '0' COMMENT 'ストリートファイター',
  `model_cafe_racer` TINYINT(1) NOT NULL DEFAULT '0' COMMENT 'カフェレーサー',
  `model_lowrider` TINYINT(1) NOT NULL DEFAULT '0' COMMENT 'ローライダーまたはチョッパー',
  `model_new_school` TINYINT(1) NOT NULL DEFAULT '0' COMMENT 'ニュースクールまたはウォンウォン系',
  `model_trike` TINYINT(1) NOT NULL DEFAULT '0' COMMENT 'トライク',
  `model_full_custom` TINYINT(1) NOT NULL DEFAULT '0' COMMENT 'フルカスタム',
  `model_iamge` VARCHAR(255) NULL DEFAULT NULL COMMENT '車種画像',
  `model_image_url` VARCHAR(255) NULL DEFAULT NULL COMMENT '車種画像パス',
  `model_name_prefix` VARCHAR(2) NOT NULL COMMENT '英数字の頭文字',
  `model_kana_prefix` VARCHAR(2) NOT NULL COMMENT 'カタカナ行',
  `model_count` INT NOT NULL DEFAULT '0',
  `model_kakaku_min` INT NULL DEFAULT NULL,
  `model_kakaku_max` INT NULL DEFAULT NULL,
  `model_kakaku_ave` INT NULL DEFAULT NULL,
  `model_rank` SMALLINT NULL DEFAULT NULL,
  PRIMARY KEY (`model_code`),
  UNIQUE INDEX `model_search_key` (`model_search_key` ASC) VISIBLE,
  INDEX `idx_model_maker_code` (`model_maker_code` ASC) VISIBLE,
  INDEX `idx_model_name_prefix` (`model_maker_code` ASC, `model_name_prefix` ASC) VISIBLE,
  INDEX `idx_model_kana_prefix` (`model_maker_code` ASC, `model_kana_prefix` ASC) VISIBLE,
  INDEX `idx_model_maker_view_no` (`model_maker_code` ASC, `model_displacement` ASC, `model_motortype_code` ASC, `model_hyouji` ASC) VISIBLE)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8;


-- -----------------------------------------------------
-- Table `webike_testing`.`mst_moto_color`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `webike_testing`.`mst_moto_color` (
  `color_code` CHAR(2) NOT NULL,
  `color_name` VARCHAR(255) NOT NULL,
  `color_sort` INT NULL DEFAULT NULL,
  `color_img` VARCHAR(255) NULL DEFAULT NULL,
  `color_gcode` CHAR(2) NULL DEFAULT NULL,
  PRIMARY KEY (`color_code`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8;


-- -----------------------------------------------------
-- Table `webike_testing`.`mst_series`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `webike_testing`.`mst_series` (
  `series_code` INT NOT NULL AUTO_INCREMENT,
  `series_name` VARCHAR(255) NOT NULL,
  `series_key_seach` VARCHAR(255) NULL DEFAULT NULL,
  `maker_code` INT NULL DEFAULT NULL,
  `display_order` INT NULL DEFAULT '0',
  `created_date` DATETIME NULL DEFAULT NULL,
  `last_update` TIMESTAMP NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`series_code`),
  UNIQUE INDEX `series_name_UNIQUE` (`series_name` ASC) VISIBLE)
ENGINE = InnoDB
AUTO_INCREMENT = 38
DEFAULT CHARACTER SET = utf8;


-- -----------------------------------------------------
-- Table `webike_testing`.`mst_tax_rate`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `webike_testing`.`mst_tax_rate` (
  `tax_rate` INT NOT NULL,
  PRIMARY KEY (`tax_rate`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8
ROW_FORMAT = DYNAMIC;


-- -----------------------------------------------------
-- Table `webike_testing`.`mst_todouhuken`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `webike_testing`.`mst_todouhuken` (
  `todouhuken_code` INT NOT NULL,
  `todouhuken_area_code` INT NOT NULL,
  `todouhuken_area_code2` INT NOT NULL,
  `todouhuken_name` CHAR(20) NOT NULL,
  `todouhuken_lon` CHAR(20) NOT NULL,
  `todouhuken_lat` CHAR(20) NOT NULL,
  `todouhuken_gcode` VARCHAR(2) NULL DEFAULT NULL,
  `todouhuken_ycode` VARCHAR(2) NULL DEFAULT NULL,
  PRIMARY KEY (`todouhuken_code`),
  INDEX `idx_todouhuken_name` (`todouhuken_name` ASC) VISIBLE)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8;


-- -----------------------------------------------------
-- Table `webike_testing`.`search_motorcycle`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `webike_testing`.`search_motorcycle` (
  `renkei_type` CHAR(1) NOT NULL COMMENT '連携種別 (0:モト、1:MJ、2:BBB)',
  `motorcycle_no` INT NOT NULL COMMENT '車両ID',
  `dealer_name` CHAR(150) NOT NULL COMMENT 'ショップ名',
  `dealer_todouhuken` CHAR(8) NULL DEFAULT NULL COMMENT '都道府県',
  `dealer_todouhuken_code` INT NOT NULL COMMENT '都道府県コード',
  `dealer_sikutyoson_code` CHAR(7) NULL DEFAULT NULL,
  `dealer_sikutyoson` CHAR(60) NULL DEFAULT NULL COMMENT '市区町村',
  `motorcycle_searchkey` INT NULL DEFAULT NULL COMMENT 'ショップID',
  `motorcycle_model_code` INT NOT NULL COMMENT '車種コード',
  `model_hyouji` VARCHAR(255) NOT NULL COMMENT '車種名',
  `model_search_key` VARCHAR(255) NULL DEFAULT NULL COMMENT '車種検索キー',
  `motorcycle_maker_code` INT NOT NULL COMMENT 'メーカーコード',
  `model_maker_hyouji` VARCHAR(255) NOT NULL COMMENT 'メーカー名',
  `model_maker_search` VARCHAR(255) NULL DEFAULT NULL COMMENT 'メーカー検索キー',
  `motorcycle_catch_copy` VARCHAR(64) NULL DEFAULT NULL COMMENT 'キャッチコピー',
  `motorcycle_ippan_pr` LONGTEXT NULL DEFAULT NULL COMMENT '一般PR',
  `motorcycle_ippan_kakaku` INT NOT NULL COMMENT '価格',
  `motorcycle_noridasi_kakaku` INT NULL DEFAULT '0',
  `motorcycle_noridasi_hyouji_flg` INT NULL DEFAULT '0',
  `motorcycle_point` INT NULL DEFAULT NULL COMMENT '納車ポイント',
  `motorcycle_nensiki` INT NULL DEFAULT NULL COMMENT '年式',
  `motorcycle_soukou` INT NULL DEFAULT NULL COMMENT '走行距離',
  `motorcycle_soukou_fumei_flg` TINYINT NULL DEFAULT NULL COMMENT '走行不明フラグ',
  `motorcycle_syaken` CHAR(16) NULL DEFAULT NULL COMMENT '車検',
  `motorcycle_haikiryo` INT NULL DEFAULT NULL COMMENT '排気量',
  `motorcycle_color_code` CHAR(2) NULL DEFAULT NULL COMMENT 'カラーコード',
  `motorcycle_color` CHAR(32) NULL DEFAULT NULL COMMENT 'カラー',
  `motorcycle_jyoukyo` INT NULL DEFAULT NULL COMMENT '販売状況\\n',
  `motorcycle_photo1` VARCHAR(255) NULL DEFAULT NULL COMMENT '車両画像１',
  `motorcycle_photo1_pr` VARCHAR(255) NULL DEFAULT NULL,
  `motorcycle_photo2` VARCHAR(255) NULL DEFAULT NULL,
  `motorcycle_photo2_pr` VARCHAR(64) NULL DEFAULT NULL,
  `motorcycle_photo3` VARCHAR(255) NULL DEFAULT NULL,
  `motorcycle_photo3_pr` VARCHAR(64) NULL DEFAULT NULL,
  `motorcycle_photo4` VARCHAR(255) NULL DEFAULT NULL,
  `motorcycle_photo4_pr` VARCHAR(64) NULL DEFAULT NULL,
  `motorcycle_photo5` VARCHAR(255) NULL DEFAULT NULL,
  `motorcycle_photo5_pr` VARCHAR(64) NULL DEFAULT NULL,
  `motorcycle_photo6` VARCHAR(255) NULL DEFAULT NULL,
  `motorcycle_photo6_pr` VARCHAR(64) NULL DEFAULT NULL,
  `motorcycle_photo7` VARCHAR(255) NULL DEFAULT NULL,
  `motorcycle_photo7_pr` VARCHAR(64) NULL DEFAULT NULL,
  `motorcycle_photo8` VARCHAR(255) NULL DEFAULT NULL,
  `motorcycle_photo8_pr` VARCHAR(64) NULL DEFAULT NULL,
  `motorcycle_photo9` VARCHAR(255) NULL DEFAULT NULL,
  `motorcycle_photo9_pr` VARCHAR(64) NULL DEFAULT NULL,
  `motorcycle_photo10` VARCHAR(255) NULL DEFAULT NULL,
  `motorcycle_photo10_pr` VARCHAR(64) NULL DEFAULT NULL,
  `motorcycle_ask_off_flg` TINYINT NULL DEFAULT NULL COMMENT '問合せ不可フラグ',
  `motorcycle_campaign_code` CHAR(2) NULL DEFAULT NULL COMMENT 'キャンペーンコード',
  `motorcycle_dynojet` VARCHAR(64) NULL DEFAULT NULL COMMENT 'ダイノジェット画像(パワーグラフ)',
  `dealer_img_1` CHAR(255) NULL DEFAULT NULL COMMENT 'ショップ画像１',
  `movie_flg` TINYINT(1) NOT NULL DEFAULT '0',
  `shinsya` TINYINT NOT NULL DEFAULT '0' COMMENT '新車',
  `gyaku_yunyu` TINYINT NOT NULL DEFAULT '0' COMMENT '逆輸入車',
  `normal` TINYINT NOT NULL DEFAULT '0' COMMENT 'ノーマル車',
  `custom` TINYINT NOT NULL DEFAULT '0' COMMENT 'カスタム車',
  `one_owner` TINYINT NOT NULL DEFAULT '0' COMMENT 'ワンオーナー',
  `buhin_tori` TINYINT NOT NULL DEFAULT '0' COMMENT '部品取り',
  `syagai_meter` TINYINT NOT NULL DEFAULT '0' COMMENT '社外メーター',
  `syagai_muffler` TINYINT NOT NULL DEFAULT '0' COMMENT '社外マフラー',
  `audio` TINYINT NOT NULL DEFAULT '0' COMMENT 'オーディオ付き',
  `navi` TINYINT NOT NULL DEFAULT '0' COMMENT 'ナビ',
  `abs_taiou` TINYINT NOT NULL DEFAULT '0' COMMENT 'ABS対応',
  `cell_tsuki` TINYINT NOT NULL DEFAULT '0' COMMENT 'セル付',
  `custom_paint` TINYINT NOT NULL DEFAULT '0' COMMENT 'カスタムペイント',
  `security` TINYINT NOT NULL DEFAULT '0' COMMENT 'セキュリティ',
  `center_stand` TINYINT NOT NULL DEFAULT '0' COMMENT 'センタースタンド',
  `atsya` TINYINT NOT NULL DEFAULT '0' COMMENT 'AT車',
  `meter_koukan` TINYINT NOT NULL DEFAULT '0' COMMENT 'メーター交換\\n',
  `kai_kounin` TINYINT NOT NULL DEFAULT '0' COMMENT '改公認',
  `genjyou_watashi` TINYINT NOT NULL DEFAULT '0' COMMENT '現状渡し',
  `maker_nintei` TINYINT NOT NULL DEFAULT '0' COMMENT 'メーカー認定',
  `maker_hosyou` TINYINT NOT NULL DEFAULT '0' COMMENT 'メーカー保証',
  `hosyou_tsuki` TINYINT NOT NULL DEFAULT '0' COMMENT '保証付き',
  `seibi_watashi` TINYINT NOT NULL DEFAULT '0' COMMENT '整備渡し',
  `tsuhan_kanou` TINYINT NOT NULL DEFAULT '0' COMMENT '通販可能',
  `hinshitsu_hosyou` TINYINT NOT NULL DEFAULT '0' COMMENT '品質保証',
  `etc` TINYINT(1) NOT NULL DEFAULT '0' COMMENT 'ETC',
  `restoration` TINYINT(1) NOT NULL DEFAULT '0' COMMENT 'レストア',
  `frame_syusei` TINYINT(1) NOT NULL DEFAULT '0' COMMENT 'フレーム修正',
  `detail_url` VARCHAR(512) NULL DEFAULT NULL COMMENT '車両詳細ページURL',
  `shop_url` VARCHAR(512) NULL DEFAULT NULL COMMENT 'ショップURL',
  `photo_url` VARCHAR(512) NULL DEFAULT NULL COMMENT '車両画像URL',
  `sort_nensiki` DOUBLE NOT NULL DEFAULT '0' COMMENT 'ソート用年式データ',
  `sort_soukou` DOUBLE NOT NULL DEFAULT '0' COMMENT 'ソート用走行距離データ',
  `gentsuki` TINYINT NOT NULL DEFAULT '0' COMMENT '原付スクーター',
  `sctr51` TINYINT NOT NULL DEFAULT '0' COMMENT 'スクーター(51cc以上)',
  `minibike` TINYINT NOT NULL DEFAULT '0' COMMENT 'ミニバイク',
  `naked` TINYINT NOT NULL DEFAULT '0' COMMENT 'ネイキッド',
  `american` TINYINT NOT NULL DEFAULT '0' COMMENT 'アメリカン',
  `replica` TINYINT NOT NULL DEFAULT '0' COMMENT 'レプリカ',
  `tourer` TINYINT NOT NULL DEFAULT '0' COMMENT 'ツアラー',
  `offload` TINYINT NOT NULL DEFAULT '0' COMMENT 'オフロード、モタード',
  `competition` TINYINT NOT NULL DEFAULT '0' COMMENT 'コンペティション',
  `ev` TINYINT NOT NULL DEFAULT '0' COMMENT '電動バイク',
  `classic` TINYINT NOT NULL DEFAULT '0' COMMENT 'クラシック',
  `atv` TINYINT NOT NULL DEFAULT '0' COMMENT 'ATV',
  `other` TINYINT NOT NULL DEFAULT '0' COMMENT 'その他車種',
  `2st` TINYINT NOT NULL DEFAULT '0' COMMENT '2サイクル',
  `zeppan` TINYINT NOT NULL DEFAULT '0' COMMENT '絶版車',
  `model_genchari` TINYINT(1) NOT NULL DEFAULT '0' COMMENT '蜴滉ｻ倥せ繧ｯ繝ｼ繧ｿ繝ｼ',
  `model_scooter` TINYINT(1) NOT NULL DEFAULT '0' COMMENT '繧ｹ繧ｯ繝ｼ繧ｿ繝ｼ??1cc縺九ｉ125cc?',
  `model_big_scooter` TINYINT(1) NOT NULL DEFAULT '0' COMMENT '繝薙ャ繧ｰ繧ｹ繧ｯ繝ｼ繧ｿ繝ｼ',
  `model_mini_bike` TINYINT(1) NOT NULL DEFAULT '0' COMMENT '繝溘ル繝舌う繧ｯ??25cc繝溘ャ繧ｷ繝ｧ繝ｳ?',
  `model_street` TINYINT(1) NOT NULL DEFAULT '0' COMMENT '繧ｹ繝医Μ繝ｼ繝',
  `model_classic` TINYINT(1) NOT NULL DEFAULT '0' COMMENT '繧ｯ繝ｩ繧ｷ繝?け繧ｿ繧､繝',
  `model_naked` TINYINT(1) NOT NULL DEFAULT '0' COMMENT '繝阪う繧ｭ繝?ラ',
  `model_replica` TINYINT(1) NOT NULL DEFAULT '0' COMMENT '繧ｹ繝ｼ繝代?繧ｹ繝昴?繝?ｼ上Ξ繝励Μ繧ｫ',
  `model_tourer` TINYINT(1) NOT NULL DEFAULT '0' COMMENT '繧ｹ繝昴?繝?ヤ繧｢繝ｩ繝ｼ',
  `model_american` TINYINT(1) NOT NULL DEFAULT '0' COMMENT '繧｢繝｡繝ｪ繧ｫ繝ｳ?上け繝ｫ繝ｼ繧ｶ繝ｼ',
  `model_off_road` TINYINT(1) NOT NULL DEFAULT '0' COMMENT '繧ｪ繝輔Ο繝ｼ繝会ｼ上Δ繧ｿ繝ｼ繝',
  `model_import` TINYINT(1) NOT NULL DEFAULT '0' COMMENT '豬ｷ螟悶Γ繝ｼ繧ｫ繝ｼ',
  `model_business_bike` TINYINT(1) NOT NULL DEFAULT '0' COMMENT '繝薙ず繝阪せ繝舌う繧ｯ',
  `model_competition` TINYINT(1) NOT NULL DEFAULT '0' COMMENT '繝ｬ繝ｼ繧ｵ繝ｼ?冗ｫｶ謚?畑 ',
  `model_ev` TINYINT(1) NOT NULL DEFAULT '0' COMMENT '髮ｻ蜍輔ヰ繧､繧ｯ?就TV',
  `model_4mini` TINYINT(1) NOT NULL DEFAULT '0' COMMENT '4st繝溘ル?上Α繝九Δ繝',
  `model_zeppan1` TINYINT(1) NOT NULL DEFAULT '0' COMMENT '邨ｶ迚亥錐霆奇ｼ?0蟷ｴ縺ｾ縺ｧ?',
  `model_zeppan2` TINYINT(1) NOT NULL DEFAULT '0' COMMENT '邨ｶ迚亥錐霆奇ｼ?0蟷ｴ縺九ｉ?',
  `model_vintage` TINYINT(1) NOT NULL DEFAULT '0' COMMENT '繝ｴ繧｣繝ｳ繝??繧ｸ繝｢繝医け繝ｭ繧ｹ',
  `model_dirt` TINYINT(1) NOT NULL DEFAULT '0' COMMENT '繝??繝医ヨ繝ｩ繝?け',
  `model_trial` TINYINT(1) NOT NULL DEFAULT '0' COMMENT '繝医Λ繧､繧｢繝ｫ',
  `model_street_fighter` TINYINT(1) NOT NULL DEFAULT '0' COMMENT '繧ｹ繝医Μ繝ｼ繝医ヵ繧｡繧､繧ｿ繝ｼ',
  `model_cafe_racer` TINYINT(1) NOT NULL DEFAULT '0' COMMENT '繧ｫ繝輔ぉ繝ｬ繝ｼ繧ｵ繝ｼ',
  `model_lowrider` TINYINT(1) NOT NULL DEFAULT '0' COMMENT '繝ｭ繝ｼ繝ｩ繧､繝???上メ繝ｧ繝?ヱ繝ｼ',
  `model_new_school` TINYINT(1) NOT NULL DEFAULT '0' COMMENT '繝九Η繝ｼ繧ｹ繧ｯ繝ｼ繝ｫ?上え繧ｩ繝ｳ繧ｦ繧ｩ繝ｳ邉ｻ',
  `model_trike` TINYINT(1) NOT NULL DEFAULT '0' COMMENT '繝医Λ繧､繧ｯ?上し繧､繝峨き繝ｼ',
  `model_full_custom` TINYINT(1) NOT NULL DEFAULT '0' COMMENT '繝薙Ν繝会ｼ上ヵ繝ｫ繧ｫ繧ｹ繧ｿ繝',
  `motorcycle_new_entry` DATETIME NULL DEFAULT NULL,
  `motorcycle_last_update` TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '車両更新日時\\n',
  PRIMARY KEY (`renkei_type`, `motorcycle_no`),
  INDEX `idx_search_motorcycle_price` (`motorcycle_ippan_kakaku` ASC) VISIBLE,
  INDEX `idx_search_motorcycle_soukou` (`sort_soukou` ASC) VISIBLE,
  INDEX `idx_search_motorcycle_nensiki` (`sort_nensiki` ASC) VISIBLE,
  INDEX `idx_search_motorcycle_pref` (`dealer_todouhuken_code` ASC) VISIBLE,
  INDEX `idx_search_motorcycle_haikiryo` (`motorcycle_haikiryo` ASC) VISIBLE,
  INDEX `idx_search_motorcycle_maker_code` (`model_maker_search` ASC, `motorcycle_maker_code` ASC) VISIBLE,
  INDEX `idx_search_motorcycle_model_code` (`model_search_key` ASC, `motorcycle_model_code` ASC) VISIBLE,
  INDEX `idx_search_motorcycle_moto_no` (`motorcycle_no` ASC) VISIBLE,
  INDEX `idx_update` (`motorcycle_last_update` ASC) VISIBLE,
  INDEX `idx_search_motorcycle_renkei_model` (`motorcycle_model_code` ASC, `renkei_type` ASC) VISIBLE)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8;


-- -----------------------------------------------------
-- Table `webike_testing`.`tbl_category_maker`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `webike_testing`.`tbl_category_maker` (
  `category_maker_code` INT NOT NULL AUTO_INCREMENT,
  `maker_code` INT NOT NULL,
  `category_code` INT NOT NULL,
  `category_type` INT NOT NULL,
  PRIMARY KEY (`category_maker_code`))
ENGINE = InnoDB
AUTO_INCREMENT = 135
DEFAULT CHARACTER SET = utf8;


-- -----------------------------------------------------
-- Table `webike_testing`.`tbl_model_type`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `webike_testing`.`tbl_model_type` (
  `model_code` INT NOT NULL COMMENT '車種コード',
  `model_type_code` INT NOT NULL DEFAULT '0' COMMENT '車種タイプコード',
  `created_on` DATETIME NOT NULL DEFAULT '0000-00-00 00:00:00' COMMENT '登録日時',
  `created_user_id` VARCHAR(128) NOT NULL DEFAULT '' COMMENT '登録ユーザー',
  `updated_on` TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '更新日時',
  `updated_user_id` VARCHAR(128) NOT NULL DEFAULT '' COMMENT '更新ユーザー',
  PRIMARY KEY (`model_code`, `model_type_code`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8;


-- -----------------------------------------------------
-- Table `webike_testing`.`tbl_moto_type_connect`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `webike_testing`.`tbl_moto_type_connect` (
  `moto_type_mc_no` INT NOT NULL,
  `moto_type_code` INT NOT NULL,
  `moto_type_update_user` CHAR(20) NOT NULL,
  `moto_type_last_update` TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`moto_type_mc_no`, `moto_type_code`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8;


-- -----------------------------------------------------
-- Table `webike_testing`.`tbl_motorcycle`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `webike_testing`.`tbl_motorcycle` (
  `motorcycle_no` INT NOT NULL AUTO_INCREMENT,
  `motorcycle_searchkey` INT NULL DEFAULT '0',
  `motorcycle_maker_code` INT NULL DEFAULT NULL,
  `motorcycle_model_code` INT NULL DEFAULT '0',
  `motorcycle_catch_copy` VARCHAR(64) NULL DEFAULT NULL,
  `motorcycle_model_other` CHAR(16) NULL DEFAULT NULL,
  `motorcycle_type` INT NULL DEFAULT '0',
  `motorcycle_sale_type` INT NULL DEFAULT '0',
  `motorcycle_ippan_kakaku` INT NULL DEFAULT '0',
  `motorcycle_point_rate` DOUBLE(3,1) NOT NULL DEFAULT '0.0',
  `motorcycle_point_max` INT NOT NULL DEFAULT '0',
  `motorcycle_point` INT NOT NULL DEFAULT '0',
  `motorcycle_nensiki` INT NULL DEFAULT '0',
  `motorcycle_soukou` INT NULL DEFAULT '0',
  `motorcycle_soukou_fumei_flg` INT NULL DEFAULT '0',
  `motorcycle_syaken` CHAR(16) NULL DEFAULT NULL,
  `motorcycle_haikiryo` INT NULL DEFAULT '0',
  `motorcycle_color_code` CHAR(2) NULL DEFAULT NULL,
  `motorcycle_color` CHAR(32) NULL DEFAULT NULL,
  `motorcycle_ippan_pr` LONGTEXT NULL DEFAULT NULL,
  `motorcycle_commission_id` INT NULL DEFAULT '0',
  `motorcycle_noridasi_kakaku` INT NULL DEFAULT '0',
  `motorcycle_noridasi_hyouji_flg` INT NULL DEFAULT '0',
  `motorcycle_gyouhan_kakaku` INT NULL DEFAULT '0',
  `motorcycle_gyouhan_pr` VARCHAR(255) NULL DEFAULT NULL,
  `motorcycle_jyoukyo` INT NULL DEFAULT '0',
  `motorcycle_continue_sell` TINYINT(1) NOT NULL DEFAULT '0',
  `motorcycle_campaign_code` CHAR(2) NULL DEFAULT '00',
  `motorcycle_jyoutai` INT NULL DEFAULT '0',
  `motorcycle_photo1` VARCHAR(255) NULL DEFAULT NULL,
  `motorcycle_photo1_pr` VARCHAR(255) NULL DEFAULT NULL,
  `motorcycle_photo2` VARCHAR(255) NULL DEFAULT NULL,
  `motorcycle_photo2_pr` VARCHAR(64) NULL DEFAULT NULL,
  `motorcycle_photo3` VARCHAR(255) NULL DEFAULT NULL,
  `motorcycle_photo3_pr` VARCHAR(64) NULL DEFAULT NULL,
  `motorcycle_photo4` VARCHAR(255) NULL DEFAULT NULL,
  `motorcycle_photo4_pr` VARCHAR(64) NULL DEFAULT NULL,
  `motorcycle_photo5` VARCHAR(255) NULL DEFAULT NULL,
  `motorcycle_photo5_pr` VARCHAR(64) NULL DEFAULT NULL,
  `motorcycle_photo6` VARCHAR(255) NULL DEFAULT NULL,
  `motorcycle_photo6_pr` VARCHAR(64) NULL DEFAULT NULL,
  `motorcycle_photo7` VARCHAR(255) NULL DEFAULT NULL,
  `motorcycle_photo7_pr` VARCHAR(64) NULL DEFAULT NULL,
  `motorcycle_photo8` VARCHAR(255) NULL DEFAULT NULL,
  `motorcycle_photo8_pr` VARCHAR(64) NULL DEFAULT NULL,
  `motorcycle_photo9` VARCHAR(255) NULL DEFAULT NULL,
  `motorcycle_photo9_pr` VARCHAR(64) NULL DEFAULT NULL,
  `motorcycle_photo10` VARCHAR(255) NULL DEFAULT NULL,
  `motorcycle_photo10_pr` VARCHAR(64) NULL DEFAULT NULL,
  `motorcycle_ask_off_flg` TINYINT(1) NOT NULL DEFAULT '0',
  `motorcycle_dynojet` VARCHAR(64) NULL DEFAULT NULL COMMENT 'ダイノジェット画像',
  `motorcycle_new_entry` DATETIME NULL DEFAULT NULL,
  `motorcycle_last_update_id` CHAR(20) NULL DEFAULT NULL,
  `motorcycle_last_update` TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`motorcycle_no`),
  INDEX `idx_motorcycle_model_code` (`motorcycle_model_code` ASC) VISIBLE,
  INDEX `idx_motorcycle_searchkey` (`motorcycle_searchkey` ASC) VISIBLE,
  INDEX `idx_motorcycle_jyoukyo` (`motorcycle_jyoukyo` ASC) VISIBLE,
  INDEX `idx_motorcycle_sale_type` (`motorcycle_sale_type` ASC) VISIBLE,
  INDEX `idx_motorcycle_soukou` (`motorcycle_soukou` ASC) VISIBLE,
  INDEX `idx_motorcycle_ippan_kakaku` (`motorcycle_ippan_kakaku` ASC) VISIBLE,
  INDEX `idx_motorcycle_type` (`motorcycle_type` ASC) VISIBLE,
  INDEX `idx_gyouhan_pr` (`motorcycle_gyouhan_pr` ASC) VISIBLE,
  INDEX `idx_new_bike` (`motorcycle_sale_type` ASC, `motorcycle_jyoukyo` ASC, `motorcycle_ippan_kakaku` ASC, `motorcycle_last_update` ASC) VISIBLE)
ENGINE = InnoDB
AUTO_INCREMENT = 242523
DEFAULT CHARACTER SET = utf8;

USE `webike_testing` ;

-- -----------------------------------------------------
-- Placeholder table for view `webike_testing`.`vw_motorcycle_v2`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `webike_testing`.`vw_motorcycle_v2` (`moto_searchkey` INT, `moto_no` INT, `maker_code` INT, `model_code` INT, `type_code` INT, `soukou_fumei_flg` INT, `catch_copy` INT, `model_other` INT, `sale_type` INT, `ippan_kakaku` INT, `point_rate` INT, `point_max` INT, `point` INT, `nensiki` INT, `soukou` INT, `syaken` INT, `haikiryo` INT, `color_code` INT, `color` INT, `ippan_pr` INT, `commission_id` INT, `noridasi_kakaku` INT, `noridasi_hyouji_flg` INT, `gyouhan_kakaku` INT, `gyouhan_pr` INT, `jyoukyo` INT, `continue_sell` INT, `campaign_code` INT, `jyoutai` INT, `photo1` INT, `photo2` INT, `photo3` INT, `photo4` INT, `photo5` INT, `photo6` INT, `photo7` INT, `photo8` INT, `photo9` INT, `photo10` INT, `photo1_pr` INT, `photo2_pr` INT, `photo3_pr` INT, `photo4_pr` INT, `photo5_pr` INT, `photo6_pr` INT, `photo7_pr` INT, `photo8_pr` INT, `photo9_pr` INT, `photo10_pr` INT, `new_entry` INT, `last_update_id` INT, `last_update` INT, `motorcycleAskOffFlg` INT, `model_maker` INT, `maker_search` INT, `model_name` INT, `model_search` INT, `motor_type` INT, `color_name` INT, `color_img` INT, `dealer_name` INT, `dealer_todouhuken` INT, `dealer_todouhuken_code` INT, `dealer_sikutyoson` INT, `todouhuken_area_code` INT, `todouhuken_name` INT, `model_maker_name` INT, `model_displacement` INT, `dealer_gid` INT);

-- -----------------------------------------------------
-- View `webike_testing`.`vw_motorcycle_v2`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `webike_testing`.`vw_motorcycle_v2`;
USE `webike_testing`;
CREATE  OR REPLACE ALGORITHM=UNDEFINED DEFINER=`root`@`localhost` SQL SECURITY DEFINER VIEW `webike`.`vw_motorcycle_v2` AS select `webike`.`tbl_motorcycle`.`motorcycle_searchkey` AS `moto_searchkey`,`webike`.`tbl_motorcycle`.`motorcycle_no` AS `moto_no`,`webike`.`tbl_motorcycle`.`motorcycle_maker_code` AS `maker_code`,`webike`.`tbl_motorcycle`.`motorcycle_model_code` AS `model_code`,`webike`.`tbl_motorcycle`.`motorcycle_type` AS `type_code`,`webike`.`tbl_motorcycle`.`motorcycle_soukou_fumei_flg` AS `soukou_fumei_flg`,`webike`.`tbl_motorcycle`.`motorcycle_catch_copy` AS `catch_copy`,`webike`.`tbl_motorcycle`.`motorcycle_model_other` AS `model_other`,`webike`.`tbl_motorcycle`.`motorcycle_sale_type` AS `sale_type`,`webike`.`tbl_motorcycle`.`motorcycle_ippan_kakaku` AS `ippan_kakaku`,`webike`.`tbl_motorcycle`.`motorcycle_point_rate` AS `point_rate`,`webike`.`tbl_motorcycle`.`motorcycle_point_max` AS `point_max`,`webike`.`tbl_motorcycle`.`motorcycle_point` AS `point`,`webike`.`tbl_motorcycle`.`motorcycle_nensiki` AS `nensiki`,`webike`.`tbl_motorcycle`.`motorcycle_soukou` AS `soukou`,`webike`.`tbl_motorcycle`.`motorcycle_syaken` AS `syaken`,`webike`.`tbl_motorcycle`.`motorcycle_haikiryo` AS `haikiryo`,`webike`.`tbl_motorcycle`.`motorcycle_color_code` AS `color_code`,`webike`.`tbl_motorcycle`.`motorcycle_color` AS `color`,`webike`.`tbl_motorcycle`.`motorcycle_ippan_pr` AS `ippan_pr`,`webike`.`tbl_motorcycle`.`motorcycle_commission_id` AS `commission_id`,`webike`.`tbl_motorcycle`.`motorcycle_noridasi_kakaku` AS `noridasi_kakaku`,`webike`.`tbl_motorcycle`.`motorcycle_noridasi_hyouji_flg` AS `noridasi_hyouji_flg`,`webike`.`tbl_motorcycle`.`motorcycle_gyouhan_kakaku` AS `gyouhan_kakaku`,`webike`.`tbl_motorcycle`.`motorcycle_gyouhan_pr` AS `gyouhan_pr`,`webike`.`tbl_motorcycle`.`motorcycle_jyoukyo` AS `jyoukyo`,`webike`.`tbl_motorcycle`.`motorcycle_continue_sell` AS `continue_sell`,`webike`.`tbl_motorcycle`.`motorcycle_campaign_code` AS `campaign_code`,`webike`.`tbl_motorcycle`.`motorcycle_jyoutai` AS `jyoutai`,`webike`.`tbl_motorcycle`.`motorcycle_photo1` AS `photo1`,`webike`.`tbl_motorcycle`.`motorcycle_photo2` AS `photo2`,`webike`.`tbl_motorcycle`.`motorcycle_photo3` AS `photo3`,`webike`.`tbl_motorcycle`.`motorcycle_photo4` AS `photo4`,`webike`.`tbl_motorcycle`.`motorcycle_photo5` AS `photo5`,`webike`.`tbl_motorcycle`.`motorcycle_photo6` AS `photo6`,`webike`.`tbl_motorcycle`.`motorcycle_photo7` AS `photo7`,`webike`.`tbl_motorcycle`.`motorcycle_photo8` AS `photo8`,`webike`.`tbl_motorcycle`.`motorcycle_photo9` AS `photo9`,`webike`.`tbl_motorcycle`.`motorcycle_photo10` AS `photo10`,`webike`.`tbl_motorcycle`.`motorcycle_photo1_pr` AS `photo1_pr`,`webike`.`tbl_motorcycle`.`motorcycle_photo2_pr` AS `photo2_pr`,`webike`.`tbl_motorcycle`.`motorcycle_photo3_pr` AS `photo3_pr`,`webike`.`tbl_motorcycle`.`motorcycle_photo4_pr` AS `photo4_pr`,`webike`.`tbl_motorcycle`.`motorcycle_photo5_pr` AS `photo5_pr`,`webike`.`tbl_motorcycle`.`motorcycle_photo6_pr` AS `photo6_pr`,`webike`.`tbl_motorcycle`.`motorcycle_photo7_pr` AS `photo7_pr`,`webike`.`tbl_motorcycle`.`motorcycle_photo8_pr` AS `photo8_pr`,`webike`.`tbl_motorcycle`.`motorcycle_photo9_pr` AS `photo9_pr`,`webike`.`tbl_motorcycle`.`motorcycle_photo10_pr` AS `photo10_pr`,`webike`.`tbl_motorcycle`.`motorcycle_new_entry` AS `new_entry`,`webike`.`tbl_motorcycle`.`motorcycle_last_update_id` AS `last_update_id`,`webike`.`tbl_motorcycle`.`motorcycle_last_update` AS `last_update`,`webike`.`tbl_motorcycle`.`motorcycle_ask_off_flg` AS `motorcycleAskOffFlg`,`webike`.`mst_model_maker`.`model_maker_hyouji` AS `model_maker`,`webike`.`mst_model_maker`.`model_maker_search` AS `maker_search`,`webike`.`mst_model_v2`.`model_hyouji` AS `model_name`,`webike`.`mst_model_v2`.`model_search_key` AS `model_search`,`webike`.`mst_model_v2`.`model_motortype_code` AS `motor_type`,`webike`.`mst_moto_color`.`color_name` AS `color_name`,`webike`.`mst_moto_color`.`color_img` AS `color_img`,`webike`.`mst_dealer`.`dealer_name` AS `dealer_name`,`webike`.`mst_dealer`.`dealer_todouhuken` AS `dealer_todouhuken`,`webike`.`mst_dealer`.`dealer_todouhuken_code` AS `dealer_todouhuken_code`,`webike`.`mst_dealer`.`dealer_sikutyoson` AS `dealer_sikutyoson`,`webike`.`mst_todouhuken`.`todouhuken_area_code` AS `todouhuken_area_code`,`webike`.`mst_todouhuken`.`todouhuken_name` AS `todouhuken_name`,`webike`.`mst_model_maker`.`model_maker_name` AS `model_maker_name`,`webike`.`mst_model_v2`.`model_displacement` AS `model_displacement`,`webike`.`mst_dealer`.`dealer_gid` AS `dealer_gid` from ((((((`webike`.`tbl_motorcycle` join `webike`.`mst_dealer` on(((`webike`.`tbl_motorcycle`.`motorcycle_searchkey` = `webike`.`mst_dealer`.`dealer_searchkey`) and (`webike`.`mst_dealer`.`dealer_status` in ('B','C')) and (`webike`.`mst_dealer`.`dealer_effective_flag` = 1) and (`webike`.`mst_dealer`.`dealer_charge_type` <> 'XX')))) join `webike`.`mst_todouhuken` on((`webike`.`mst_dealer`.`dealer_todouhuken_code` = `webike`.`mst_todouhuken`.`todouhuken_code`))) left join `webike`.`mst_model_maker` on((`webike`.`tbl_motorcycle`.`motorcycle_maker_code` = `webike`.`mst_model_maker`.`model_maker_code`))) left join `webike`.`mst_model_v2` on((`webike`.`tbl_motorcycle`.`motorcycle_model_code` = `webike`.`mst_model_v2`.`model_code`))) left join `webike`.`mst_moto_color` on((`webike`.`tbl_motorcycle`.`motorcycle_color_code` = `webike`.`mst_moto_color`.`color_code`))) left join `webike`.`mst_tax_rate` on((0 <> 1))) where (`webike`.`tbl_motorcycle`.`motorcycle_sale_type` in (1,3));

SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;
