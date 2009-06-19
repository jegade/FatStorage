-- 
-- Created by SQL::Translator::Producer::MySQL
-- Created on Fri Jun 19 23:28:03 2009
-- 
SET foreign_key_checks=0;

DROP TABLE IF EXISTS `backup`;

--
-- Table: `backup`
--
CREATE TABLE `backup` (
  `backup_id` integer(11) unsigned NOT NULL auto_increment,
  `file_id` integer(11) unsigned NOT NULL,
  `storage_id` integer(11) unsigned NOT NULL,
  `md5` varchar(40) NOT NULL,
  `backup_date` datetime NOT NULL,
  INDEX backup_idx_file_id (`file_id`),
  INDEX backup_idx_storage_id (`storage_id`),
  PRIMARY KEY (`backup_id`),
  CONSTRAINT `backup_fk_file_id` FOREIGN KEY (`file_id`) REFERENCES `file` (`file_id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `backup_fk_storage_id` FOREIGN KEY (`storage_id`) REFERENCES `storage` (`storage_id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARACTER SET UTF8;

DROP TABLE IF EXISTS `file`;

--
-- Table: `file`
--
CREATE TABLE `file` (
  `file_id` integer(11) unsigned NOT NULL auto_increment,
  `media_id` integer(11) unsigned NOT NULL,
  `score_id` integer(11) unsigned NOT NULL,
  `filesize` integer(11) unsigned NOT NULL,
  `filename` varchar(255) NOT NULL,
  `mimetype` varchar(64) NOT NULL,
  `revision` integer(11) unsigned NOT NULL,
  `md5` varchar(40) NOT NULL,
  INDEX file_idx_media_id (`media_id`),
  INDEX file_idx_score_id (`score_id`),
  PRIMARY KEY (`file_id`),
  CONSTRAINT `file_fk_media_id` FOREIGN KEY (`media_id`) REFERENCES `media` (`media_id`),
  CONSTRAINT `file_fk_score_id` FOREIGN KEY (`score_id`) REFERENCES `score` (`score_id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARACTER SET UTF8;

DROP TABLE IF EXISTS `file_has_geo`;

--
-- Table: `file_has_geo`
--
CREATE TABLE `file_has_geo` (
  `file_id` integer(11) unsigned NOT NULL,
  `geo_id` integer(11) unsigned NOT NULL,
  INDEX file_has_geo_idx_file_id (`file_id`),
  INDEX file_has_geo_idx_geo_id (`geo_id`),
  PRIMARY KEY (`file_id`, `geo_id`),
  CONSTRAINT `file_has_geo_fk_file_id` FOREIGN KEY (`file_id`) REFERENCES `file` (`file_id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `file_has_geo_fk_geo_id` FOREIGN KEY (`geo_id`) REFERENCES `geo` (`geo_id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARACTER SET UTF8;

DROP TABLE IF EXISTS `file_has_tag`;

--
-- Table: `file_has_tag`
--
CREATE TABLE `file_has_tag` (
  `file_id` integer(11) unsigned NOT NULL,
  `tag_id` integer(11) unsigned NOT NULL,
  INDEX file_has_tag_idx_file_id (`file_id`),
  INDEX file_has_tag_idx_tag_id (`tag_id`),
  PRIMARY KEY (`file_id`, `tag_id`),
  CONSTRAINT `file_has_tag_fk_file_id` FOREIGN KEY (`file_id`) REFERENCES `file` (`file_id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `file_has_tag_fk_tag_id` FOREIGN KEY (`tag_id`) REFERENCES `tag` (`tag_id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARACTER SET UTF8;

DROP TABLE IF EXISTS `folder`;

--
-- Table: `folder`
--
CREATE TABLE `folder` (
  `folder_id` integer(11) unsigned NOT NULL auto_increment,
  `foldername` varchar(255) NOT NULL,
  PRIMARY KEY (`folder_id`)
) ENGINE=InnoDB DEFAULT CHARACTER SET UTF8;

DROP TABLE IF EXISTS `folder_has_media`;

--
-- Table: `folder_has_media`
--
CREATE TABLE `folder_has_media` (
  `folder_id` integer(11) unsigned NOT NULL,
  `media_id` integer(11) unsigned NOT NULL,
  INDEX folder_has_media_idx_folder_id (`folder_id`),
  INDEX folder_has_media_idx_media_id (`media_id`),
  PRIMARY KEY (`media_id`, `folder_id`),
  CONSTRAINT `folder_has_media_fk_folder_id` FOREIGN KEY (`folder_id`) REFERENCES `folder` (`folder_id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `folder_has_media_fk_media_id` FOREIGN KEY (`media_id`) REFERENCES `media` (`media_id`)
) ENGINE=InnoDB DEFAULT CHARACTER SET UTF8;

DROP TABLE IF EXISTS `geo`;

--
-- Table: `geo`
--
CREATE TABLE `geo` (
  `geo_id` integer(11) unsigned NOT NULL auto_increment,
  `name` varchar(255) NOT NULL,
  `lat` DECIMAL(11, 8) NOT NULL DEFAULT '000.0000000000',
  `lon` DECIMAL(11, 8) NOT NULL DEFAULT '000.0000000000',
  PRIMARY KEY (`geo_id`)
) ENGINE=InnoDB DEFAULT CHARACTER SET UTF8;

DROP TABLE IF EXISTS `media`;

--
-- Table: `media`
--
CREATE TABLE `media` (
  `media_id` integer(11) unsigned NOT NULL auto_increment,
  PRIMARY KEY (`media_id`)
) ENGINE=InnoDB DEFAULT CHARACTER SET UTF8;

DROP TABLE IF EXISTS `media_has_file`;

--
-- Table: `media_has_file`
--
CREATE TABLE `media_has_file` (
  `media_id` integer(11) unsigned NOT NULL,
  `file_id` integer(11) unsigned NOT NULL,
  INDEX media_has_file_idx_file_id (`file_id`),
  INDEX media_has_file_idx_media_id (`media_id`),
  PRIMARY KEY (`media_id`, `file_id`),
  CONSTRAINT `media_has_file_fk_file_id` FOREIGN KEY (`file_id`) REFERENCES `tag` (`tag_id`),
  CONSTRAINT `media_has_file_fk_media_id` FOREIGN KEY (`media_id`) REFERENCES `media` (`media_id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARACTER SET UTF8;

DROP TABLE IF EXISTS `media_has_geo`;

--
-- Table: `media_has_geo`
--
CREATE TABLE `media_has_geo` (
  `media_id` integer(11) unsigned NOT NULL,
  `geo_id` integer(11) unsigned NOT NULL,
  INDEX media_has_geo_idx_geo_id (`geo_id`),
  INDEX media_has_geo_idx_media_id (`media_id`),
  PRIMARY KEY (`media_id`, `geo_id`),
  CONSTRAINT `media_has_geo_fk_geo_id` FOREIGN KEY (`geo_id`) REFERENCES `geo` (`geo_id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `media_has_geo_fk_media_id` FOREIGN KEY (`media_id`) REFERENCES `media` (`media_id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARACTER SET UTF8;

DROP TABLE IF EXISTS `media_has_tag`;

--
-- Table: `media_has_tag`
--
CREATE TABLE `media_has_tag` (
  `media_id` integer(11) unsigned NOT NULL,
  `tag_id` integer(11) unsigned NOT NULL,
  INDEX media_has_tag_idx_media_id (`media_id`),
  INDEX media_has_tag_idx_tag_id (`tag_id`),
  PRIMARY KEY (`media_id`, `tag_id`),
  CONSTRAINT `media_has_tag_fk_media_id` FOREIGN KEY (`media_id`) REFERENCES `media` (`media_id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `media_has_tag_fk_tag_id` FOREIGN KEY (`tag_id`) REFERENCES `tag` (`tag_id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARACTER SET UTF8;

DROP TABLE IF EXISTS `score`;

--
-- Table: `score`
--
CREATE TABLE `score` (
  `score_id` integer(11) unsigned NOT NULL auto_increment,
  `name` varchar(255) NOT NULL,
  `priority` integer(3) NOT NULL DEFAULT '1',
  PRIMARY KEY (`score_id`)
) ENGINE=InnoDB DEFAULT CHARACTER SET UTF8;

DROP TABLE IF EXISTS `storage`;

--
-- Table: `storage`
--
CREATE TABLE `storage` (
  `storage_id` integer(11) unsigned NOT NULL auto_increment,
  `uri` varchar(128) NOT NULL,
  `bytes_free` integer(11) unsigned NOT NULL,
  `bytes_use` integer(11) unsigned NOT NULL,
  `bytes_total` integer(11) unsigned NOT NULL,
  PRIMARY KEY (`storage_id`)
) ENGINE=InnoDB DEFAULT CHARACTER SET UTF8;

DROP TABLE IF EXISTS `tag`;

--
-- Table: `tag`
--
CREATE TABLE `tag` (
  `tag_id` integer(11) unsigned NOT NULL auto_increment,
  `name` varchar(255) NOT NULL,
  PRIMARY KEY (`tag_id`)
) ENGINE=InnoDB DEFAULT CHARACTER SET UTF8;

SET foreign_key_checks=1;

