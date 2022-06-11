-- --------------------------------------------------------
-- Host:                         127.0.0.1
-- Server versie:                10.6.5-MariaDB - mariadb.org binary distribution
-- Server OS:                    Win64
-- HeidiSQL Versie:              11.3.0.6295
-- --------------------------------------------------------

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET NAMES utf8 */;
/*!50503 SET NAMES utf8mb4 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;


-- Databasestructuur van gtav_rp3 wordt geschreven
CREATE DATABASE IF NOT EXISTS `gtav_rp3` /*!40100 DEFAULT CHARACTER SET utf8mb4 */;
USE `gtav_rp3`;

-- Structuur van  tabel gtav_rp3.boosting wordt geschreven
CREATE TABLE IF NOT EXISTS `boosting` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `reputation` int(11) NOT NULL DEFAULT 0,
  `username` text DEFAULT NULL,
  `password` text DEFAULT NULL,
  `access` varchar(250) DEFAULT '{}',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=1814 DEFAULT CHARSET=utf8mb4;

-- Data exporteren was gedeselecteerd

-- Structuur van  tabel gtav_rp3.characters wordt geschreven
CREATE TABLE IF NOT EXISTS `characters` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `owner` varchar(50) DEFAULT NULL,
  `first_name` varchar(50) NOT NULL DEFAULT 'John',
  `last_name` varchar(50) NOT NULL DEFAULT 'Doe',
  `date_created` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp(),
  `dob` varchar(50) DEFAULT 'NULL',
  `cash` int(9) DEFAULT 500,
  `bank` int(9) NOT NULL DEFAULT 5000,
  `phone_number` longtext NOT NULL,
  `story` text NOT NULL,
  `new` int(1) NOT NULL DEFAULT 0,
  `deleted` int(11) NOT NULL DEFAULT 0,
  `gender` int(1) NOT NULL DEFAULT 0,
  `jail_time` int(11) NOT NULL DEFAULT 0,
  `stress_level` int(11) DEFAULT 0,
  `metaData` varchar(1520) DEFAULT '{"thirst":100,"hunger":100,"armour":0,"health":200}',
  `bones` varchar(250) DEFAULT '{}',
  `emotes` varchar(4160) DEFAULT '{}',
  `paycheck` int(11) DEFAULT 0,
  `meta` varchar(250) DEFAULT 'move_m@casual@d',
  `casino` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=1814 DEFAULT CHARSET=utf8mb4;

-- Data exporteren was gedeselecteerd

-- Structuur van  tabel gtav_rp3.characters_cars wordt geschreven
CREATE TABLE IF NOT EXISTS `characters_cars` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `owner` varchar(50) DEFAULT NULL,
  `cid` int(11) DEFAULT NULL,
  `purchase_price` float DEFAULT NULL,
  `model` varchar(50) DEFAULT NULL,
  `vehicle_state` longtext DEFAULT NULL,
  `fuel` int(11) DEFAULT 100,
  `name` varchar(50) DEFAULT NULL,
  `engine_damage` bigint(19) unsigned DEFAULT 1000,
  `body_damage` bigint(20) DEFAULT 1000,
  `degredation` varchar(250) DEFAULT '100,100,100,100,100,100,100,100',
  `current_garage` varchar(50) DEFAULT 'C',
  `financed` int(11) DEFAULT 0,
  `last_payment` int(11) DEFAULT 0,
  `coords` longtext DEFAULT NULL,
  `license_plate` varchar(255) NOT NULL DEFAULT '',
  `payments_left` int(3) DEFAULT 0,
  `data` longtext DEFAULT NULL,
  `repoed` int(11) NOT NULL DEFAULT 0,
  `finance_time` int(11) NOT NULL DEFAULT 10080,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=2327 DEFAULT CHARSET=utf8mb4;

-- Data exporteren was gedeselecteerd

-- Structuur van  tabel gtav_rp3.characters_weapons wordt geschreven
CREATE TABLE IF NOT EXISTS `characters_weapons` (
  `id` int(11) NOT NULL DEFAULT 0,
  `type` varchar(255) DEFAULT NULL,
  `ammo` int(11) DEFAULT 0
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- Data exporteren was gedeselecteerd

-- Structuur van  tabel gtav_rp3.character_current wordt geschreven
CREATE TABLE IF NOT EXISTS `character_current` (
  `cid` int(11) DEFAULT NULL,
  `model` varchar(50) DEFAULT NULL,
  `drawables` mediumtext DEFAULT NULL,
  `props` mediumtext DEFAULT NULL,
  `drawtextures` mediumtext DEFAULT NULL,
  `proptextures` mediumtext DEFAULT NULL,
  `assExists` mediumtext DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- Data exporteren was gedeselecteerd

-- Structuur van  tabel gtav_rp3.character_face wordt geschreven
CREATE TABLE IF NOT EXISTS `character_face` (
  `cid` int(11) DEFAULT NULL,
  `hairColor` mediumtext DEFAULT NULL,
  `headBlend` mediumtext DEFAULT NULL,
  `headOverlay` mediumtext DEFAULT NULL,
  `headStructure` mediumtext DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- Data exporteren was gedeselecteerd

-- Structuur van  tabel gtav_rp3.character_outfits wordt geschreven
CREATE TABLE IF NOT EXISTS `character_outfits` (
  `cid` int(11) DEFAULT NULL,
  `model` varchar(50) DEFAULT NULL,
  `name` text DEFAULT NULL,
  `slot` int(11) DEFAULT NULL,
  `drawables` varchar(250) DEFAULT '{}',
  `props` varchar(250) DEFAULT '{}',
  `drawtextures` varchar(250) DEFAULT '{}',
  `proptextures` varchar(250) DEFAULT '{}',
  `hairColor` varchar(250) DEFAULT '{}'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- Data exporteren was gedeselecteerd

-- Structuur van  tabel gtav_rp3.character_passes wordt geschreven
CREATE TABLE IF NOT EXISTS `character_passes` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `cid` int(11) NOT NULL,
  `rank` int(11) NOT NULL DEFAULT 1,
  `name` text NOT NULL,
  `giver` text NOT NULL,
  `pass_type` text NOT NULL,
  `business_name` text NOT NULL,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=11854 DEFAULT CHARSET=utf8mb4;

-- Data exporteren was gedeselecteerd

-- Structuur van  tabel gtav_rp3.delivery_job wordt geschreven
CREATE TABLE IF NOT EXISTS `delivery_job` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `active` float DEFAULT NULL,
  `jobType` varchar(50) DEFAULT NULL,
  `dropAmount` int(2) DEFAULT NULL,
  `pickup` varchar(255) DEFAULT NULL,
  `drop` varchar(255) DEFAULT NULL,
  KEY `id` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=latin1;

-- Data exporteren was gedeselecteerd

-- Structuur van  tabel gtav_rp3.exploiters wordt geschreven
CREATE TABLE IF NOT EXISTS `exploiters` (
  `type` text DEFAULT NULL,
  `log` text DEFAULT NULL,
  `data` text DEFAULT NULL,
  `cid` int(11) DEFAULT NULL,
  `steam_id` varchar(255) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- Data exporteren was gedeselecteerd

-- Structuur van  tabel gtav_rp3.fine_types wordt geschreven
CREATE TABLE IF NOT EXISTS `fine_types` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `label` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `amount` int(11) DEFAULT NULL,
  `jailtime` int(11) DEFAULT 0,
  `category` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=203 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Data exporteren was gedeselecteerd

-- Structuur van  tabel gtav_rp3.group_banking wordt geschreven
CREATE TABLE IF NOT EXISTS `group_banking` (
  `group_type` mediumtext DEFAULT NULL,
  `bank` int(11) NOT NULL DEFAULT 0
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- Data exporteren was gedeselecteerd

-- Structuur van  tabel gtav_rp3.jobs_whitelist wordt geschreven
CREATE TABLE IF NOT EXISTS `jobs_whitelist` (
  `owner` varchar(50) NOT NULL,
  `cid` int(11) NOT NULL,
  `job` varchar(50) DEFAULT 'unemployed',
  `rank` int(11) DEFAULT 0,
  `callsign` varchar(255) DEFAULT '1'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- Data exporteren was gedeselecteerd

-- Structuur van  tabel gtav_rp3.logs wordt geschreven
CREATE TABLE IF NOT EXISTS `logs` (
  `type` text DEFAULT NULL,
  `log` text DEFAULT NULL,
  `data` text DEFAULT NULL,
  `cid` int(11) DEFAULT NULL,
  `steam_id` varchar(255) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- Data exporteren was gedeselecteerd

-- Structuur van  tabel gtav_rp3.mdt_reports wordt geschreven
CREATE TABLE IF NOT EXISTS `mdt_reports` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `char_id` int(11) DEFAULT NULL,
  `title` varchar(255) DEFAULT NULL,
  `incident` longtext DEFAULT NULL,
  `charges` longtext DEFAULT NULL,
  `author` varchar(255) DEFAULT NULL,
  `name` varchar(255) DEFAULT NULL,
  `date` varchar(255) DEFAULT NULL,
  `jailtime` mediumtext DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=354 DEFAULT CHARSET=utf8mb4;

-- Data exporteren was gedeselecteerd

-- Structuur van  tabel gtav_rp3.mdt_warrants wordt geschreven
CREATE TABLE IF NOT EXISTS `mdt_warrants` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(255) DEFAULT NULL,
  `char_id` int(11) DEFAULT NULL,
  `report_id` int(11) DEFAULT NULL,
  `report_title` varchar(255) DEFAULT NULL,
  `charges` longtext DEFAULT NULL,
  `date` varchar(255) DEFAULT NULL,
  `expire` varchar(255) DEFAULT NULL,
  `notes` varchar(255) DEFAULT NULL,
  `author` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=20 DEFAULT CHARSET=utf8mb4;

-- Data exporteren was gedeselecteerd

-- Structuur van  tabel gtav_rp3.mech_materials wordt geschreven
CREATE TABLE IF NOT EXISTS `mech_materials` (
  `Shop` mediumtext NOT NULL,
  `rubber` int(11) NOT NULL DEFAULT 0,
  `aluminium` int(11) NOT NULL DEFAULT 0,
  `scrapmetal` int(11) NOT NULL DEFAULT 0,
  `plastic` int(11) NOT NULL DEFAULT 0,
  `copper` int(11) NOT NULL DEFAULT 0,
  `steel` int(11) NOT NULL DEFAULT 0,
  `glass` int(11) NOT NULL DEFAULT 0
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- Data exporteren was gedeselecteerd

-- Structuur van  tabel gtav_rp3.modded_cars wordt geschreven
CREATE TABLE IF NOT EXISTS `modded_cars` (
  `id` int(11) DEFAULT NULL,
  `license_plate` varchar(255) DEFAULT NULL,
  `Extractors` varchar(255) DEFAULT '{}',
  `Filter` varchar(255) DEFAULT '{}',
  `Suspension` varchar(255) DEFAULT '{}',
  `Rollbars` varchar(255) DEFAULT '{}',
  `Bored` varchar(255) DEFAULT '{}',
  `Carbon` varchar(255) DEFAULT '{}',
  `LFront` varchar(255) DEFAULT '{}',
  `RFront` varchar(255) DEFAULT '{}',
  `LBack` varchar(255) DEFAULT '{}',
  `RBack` varchar(255) DEFAULT '{}'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- Data exporteren was gedeselecteerd

-- Structuur van  tabel gtav_rp3.phone_yp wordt geschreven
CREATE TABLE IF NOT EXISTS `phone_yp` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(50) DEFAULT NULL,
  `job` varchar(500) DEFAULT NULL,
  `phonenumber` varchar(50) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=1477 DEFAULT CHARSET=utf8mb4;

-- Data exporteren was gedeselecteerd

-- Structuur van  tabel gtav_rp3.playerstattoos wordt geschreven
CREATE TABLE IF NOT EXISTS `playerstattoos` (
  `identifier` int(11) DEFAULT NULL,
  `tattoos` text DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- Data exporteren was gedeselecteerd

-- Structuur van  tabel gtav_rp3.racing_tracks wordt geschreven
CREATE TABLE IF NOT EXISTS `racing_tracks` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `checkpoints` text DEFAULT NULL,
  `track_name` text DEFAULT NULL,
  `creator` text DEFAULT NULL,
  `distance` text DEFAULT NULL,
  `races` int(11) DEFAULT 0,
  `fastest_car` text DEFAULT NULL,
  `fastest_name` text DEFAULT NULL,
  `fastest_lap` int(11) DEFAULT NULL,
  `fastest_sprint` int(11) DEFAULT NULL,
  `fastest_sprint_name` text DEFAULT NULL,
  `description` text DEFAULT NULL,
  `data` text DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=9 DEFAULT CHARSET=utf8mb4;

-- Data exporteren was gedeselecteerd

-- Structuur van  tabel gtav_rp3.transaction_history wordt geschreven
CREATE TABLE IF NOT EXISTS `transaction_history` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `identifier` text NOT NULL,
  `trans_id` int(11) NOT NULL,
  `account` text NOT NULL,
  `amount` int(11) NOT NULL,
  `trans_type` text NOT NULL,
  `receiver` text NOT NULL,
  `message` text NOT NULL,
  `date` timestamp NOT NULL DEFAULT current_timestamp(),
  PRIMARY KEY (`id`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=15158 DEFAULT CHARSET=utf8mb4;

-- Data exporteren was gedeselecteerd

-- Structuur van  tabel gtav_rp3.tweets wordt geschreven
CREATE TABLE IF NOT EXISTS `tweets` (
  `handle` longtext NOT NULL,
  `message` varchar(500) NOT NULL,
  `time` longtext NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- Data exporteren was gedeselecteerd

-- Structuur van  tabel gtav_rp3.users wordt geschreven
CREATE TABLE IF NOT EXISTS `users` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `hex_id` varchar(100) DEFAULT NULL,
  `steam_id` varchar(50) DEFAULT NULL,
  `community_id` varchar(100) DEFAULT NULL,
  `license` varchar(255) DEFAULT NULL,
  `name` varchar(255) NOT NULL DEFAULT 'Uknown',
  `rank` varchar(50) NOT NULL DEFAULT 'user',
  `date_created` timestamp NULL DEFAULT current_timestamp(),
  `controls` varchar(250) DEFAULT '{}',
  `settings` varchar(250) DEFAULT '{"ctrlMovesHalf":true,"holdToDrag":true,"closeOnClick":true,"enableBlur":true,"showTooltips":false}',
  `inventory_settings` longtext DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=1256 DEFAULT CHARSET=utf8mb4;

-- Data exporteren was gedeselecteerd

-- Structuur van  tabel gtav_rp3.user_bans wordt geschreven
CREATE TABLE IF NOT EXISTS `user_bans` (
  `steam_id` longtext NOT NULL DEFAULT '',
  `discord_id` longtext NOT NULL DEFAULT '',
  `steam_name` longtext NOT NULL DEFAULT '',
  `reason` longtext NOT NULL DEFAULT '',
  `details` longtext NOT NULL,
  `date_banned` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- Data exporteren was gedeselecteerd

-- Structuur van  tabel gtav_rp3.user_contacts wordt geschreven
CREATE TABLE IF NOT EXISTS `user_contacts` (
  `identifier` varchar(40) NOT NULL,
  `name` longtext NOT NULL,
  `number` longtext NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- Data exporteren was gedeselecteerd

-- Structuur van  tabel gtav_rp3.user_convictions wordt geschreven
CREATE TABLE IF NOT EXISTS `user_convictions` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `char_id` int(11) DEFAULT NULL,
  `offense` varchar(255) DEFAULT NULL,
  `count` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=884 DEFAULT CHARSET=utf8mb4;

-- Data exporteren was gedeselecteerd

-- Structuur van  tabel gtav_rp3.user_inventory2 wordt geschreven
CREATE TABLE IF NOT EXISTS `user_inventory2` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `item_id` varchar(255) CHARACTER SET utf8mb3 DEFAULT NULL,
  `name` varchar(255) CHARACTER SET utf8mb3 NOT NULL DEFAULT '0',
  `information` varchar(255) CHARACTER SET utf8mb3 NOT NULL DEFAULT '0',
  `slot` int(11) NOT NULL,
  `dropped` tinyint(4) NOT NULL DEFAULT 0,
  `creationDate` bigint(20) NOT NULL DEFAULT 0,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=1035022 DEFAULT CHARSET=latin1;

-- Data exporteren was gedeselecteerd

-- Structuur van  tabel gtav_rp3.user_licenses wordt geschreven
CREATE TABLE IF NOT EXISTS `user_licenses` (
  `owner` longtext NOT NULL,
  `type` longtext NOT NULL,
  `status` int(11) NOT NULL DEFAULT 0
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- Data exporteren was gedeselecteerd

-- Structuur van  tabel gtav_rp3.user_mdt wordt geschreven
CREATE TABLE IF NOT EXISTS `user_mdt` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `char_id` int(11) DEFAULT NULL,
  `notes` varchar(255) DEFAULT NULL,
  `mugshot_url` varchar(255) DEFAULT NULL,
  `bail` bit(1) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=401 DEFAULT CHARSET=utf8mb4;

-- Data exporteren was gedeselecteerd

-- Structuur van  tabel gtav_rp3.user_messages wordt geschreven
CREATE TABLE IF NOT EXISTS `user_messages` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `sender` varchar(10) NOT NULL,
  `receiver` varchar(10) NOT NULL,
  `message` varchar(255) NOT NULL DEFAULT '0',
  `date` timestamp NOT NULL DEFAULT current_timestamp(),
  `isRead` int(11) NOT NULL DEFAULT 0,
  PRIMARY KEY (`id`)
) ENGINE=MyISAM AUTO_INCREMENT=5389 DEFAULT CHARSET=utf8mb3;

-- Data exporteren was gedeselecteerd

-- Structuur van  tabel gtav_rp3.vehicle_mdt wordt geschreven
CREATE TABLE IF NOT EXISTS `vehicle_mdt` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `plate` varchar(255) DEFAULT NULL,
  `stolen` bit(1) DEFAULT b'0',
  `notes` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=24 DEFAULT CHARSET=utf8mb4;

-- Data exporteren was gedeselecteerd

-- Structuur van  tabel gtav_rp3.weapon_serials wordt geschreven
CREATE TABLE IF NOT EXISTS `weapon_serials` (
  `owner` text NOT NULL,
  `serial` text NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- Data exporteren was gedeselecteerd

-- Structuur van  tabel gtav_rp3.weed wordt geschreven
CREATE TABLE IF NOT EXISTS `weed` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `x` int(11) DEFAULT 0,
  `y` int(11) DEFAULT 0,
  `z` int(11) DEFAULT 0,
  `growth` int(11) DEFAULT 0,
  `type` varchar(50) DEFAULT NULL,
  `time` varchar(250) DEFAULT '0',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- Data exporteren was gedeselecteerd

-- Structuur van  tabel gtav_rp3.__banking_logs wordt geschreven
CREATE TABLE IF NOT EXISTS `__banking_logs` (
  `cid` int(11) DEFAULT NULL,
  `amount` int(11) DEFAULT NULL,
  `reason` longtext NOT NULL,
  `withdraw` int(11) DEFAULT NULL,
  `business` int(11) NOT NULL DEFAULT 0
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- Data exporteren was gedeselecteerd

-- Structuur van  tabel gtav_rp3.__housedata wordt geschreven
CREATE TABLE IF NOT EXISTS `__housedata` (
  `cid` int(11) DEFAULT NULL,
  `house_id` int(11) DEFAULT NULL,
  `house_model` int(11) DEFAULT NULL,
  `data` varchar(250) COLLATE utf8mb4_bin DEFAULT '{}',
  `upfront` int(11) DEFAULT NULL,
  `housename` longtext COLLATE utf8mb4_bin DEFAULT NULL,
  `garages` varchar(250) COLLATE utf8mb4_bin DEFAULT '{}',
  `furniture` varchar(250) COLLATE utf8mb4_bin DEFAULT '{}',
  `status` varchar(250) COLLATE utf8mb4_bin DEFAULT 'locked',
  `force_locked` varchar(250) COLLATE utf8mb4_bin DEFAULT 'unlocked',
  `due` int(11) DEFAULT NULL,
  `overall` int(11) DEFAULT NULL,
  `payments` int(11) DEFAULT NULL,
  `days` int(11) DEFAULT NULL,
  `can_pay` varchar(250) COLLATE utf8mb4_bin DEFAULT 'true'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_bin;

-- Data exporteren was gedeselecteerd

-- Structuur van  tabel gtav_rp3.__housekeys wordt geschreven
CREATE TABLE IF NOT EXISTS `__housekeys` (
  `cid` int(11) DEFAULT NULL,
  `house_id` int(11) DEFAULT NULL,
  `house_model` int(11) DEFAULT NULL,
  `housename` longtext COLLATE utf8mb4_bin DEFAULT NULL,
  `name` mediumtext COLLATE utf8mb4_bin DEFAULT NULL,
  `garages` varchar(250) COLLATE utf8mb4_bin DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_bin ROW_FORMAT=DYNAMIC;

-- Data exporteren was gedeselecteerd

-- Structuur van  tabel gtav_rp3.__motels wordt geschreven
CREATE TABLE IF NOT EXISTS `__motels` (
  `cid` longtext COLLATE utf8mb4_bin NOT NULL,
  `roomType` int(11) NOT NULL,
  `roomNumber` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_bin;

-- Data exporteren was gedeselecteerd

-- Structuur van  tabel gtav_rp3.__vehiclemods wordt geschreven
CREATE TABLE IF NOT EXISTS `__vehiclemods` (
  `license_plate` longtext DEFAULT NULL,
  `durability` decimal(2,1) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- Data exporteren was gedeselecteerd

/*!40101 SET SQL_MODE=IFNULL(@OLD_SQL_MODE, '') */;
/*!40014 SET FOREIGN_KEY_CHECKS=IFNULL(@OLD_FOREIGN_KEY_CHECKS, 1) */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40111 SET SQL_NOTES=IFNULL(@OLD_SQL_NOTES, 1) */;
