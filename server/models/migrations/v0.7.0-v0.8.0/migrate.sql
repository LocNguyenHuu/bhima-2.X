ALTER TABLE `posting_journal` ADD COLUMN `created_at` TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP;
ALTER TABLE `posting_journal` `updated_at` TIMESTAMP NULL ON UPDATE CURRENT_TIMESTAMP;

DROP TABLE IF EXISTS `role`;
CREATE TABLE `role` (
  `uuid` binary(16) NOT NULL,
  `label` varchar(50) NOT NULL,
  `project_id` SMALLINT(5) UNSIGNED NOT NULL,
  KEY `project_id` (`project_id`),
  PRIMARY kEY(`uuid`),
  UNIQUE `project_role_label` (`project_id`,`label`),
  FOREIGN KEY (`project_id`) REFERENCES `project` (`id`) ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

DROP TABLE IF EXISTS `user_role`;
CREATE TABLE `user_role` (
  `uuid` binary(16) NOT NULL,
  `user_id` SMALLINT(5) UNSIGNED NOT NULL,
  `role_uuid` binary(16) NOT NULL,
  PRIMARY kEY(`uuid`),
  UNIQUE `role_for_user` (`user_id`,`role_uuid`),
  FOREIGN KEY (`role_uuid`) REFERENCES `role` (`uuid`) ON UPDATE CASCADE,
  FOREIGN KEY (`user_id`) REFERENCES `user` (`id`) ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

DROP TABLE IF EXISTS `role_unit`;
CREATE TABLE `role_unit` (
  `uuid` binary(16) NOT NULL,
  `role_uuid`  binary(16) NOT NULL,
  `unit_id` SMALLINT(5) UNSIGNED DEFAULT NULL,
  PRIMARY kEY(`uuid`),
  FOREIGN KEY (`role_uuid`) REFERENCES `role` (`uuid`) ON UPDATE CASCADE,
  FOREIGN KEY (`unit_id`) REFERENCES `unit` (`id`) ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

DROP TABLE IF EXISTS `config_week_days`;
CREATE TABLE `config_week_days` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `indice` int(10) unsigned NOT NULL,
  `weekend_config_id` int(10) unsigned NOT NULL,
  PRIMARY KEY (`id`),
  KEY `weekend_config_id` (`weekend_config_id`),
  FOREIGN KEY (`weekend_config_id`) REFERENCES `weekend_config` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

DROP TABLE IF EXISTS `payroll_configuration`;
CREATE TABLE `payroll_configuration` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `label` VARCHAR(100) NOT NULL,
  `dateFrom` date NOT NULL,
  `dateTo` date NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `payroll_configuration` (`label`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;


