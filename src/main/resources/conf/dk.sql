/*
Navicat MySQL Data Transfer

Source Server         : 120.27.155.121_dk_pro
Source Server Version : 50621
Source Host           : 120.27.155.121:3306
Source Database       : dk

Target Server Type    : MYSQL
Target Server Version : 50621
File Encoding         : 65001

Date: 2016-12-19 10:07:17
*/

SET FOREIGN_KEY_CHECKS=0;

-- ----------------------------
-- Table structure for course
-- ----------------------------
DROP TABLE IF EXISTS `course`;
CREATE TABLE `course` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `course_name` varchar(20) NOT NULL,
  `course_type` int(2) NOT NULL COMMENT '0：小课，1：集体课',
  `remark` varchar(255) DEFAULT NULL,
  `create_time` datetime NOT NULL,
  `update_time` datetime DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `course_name_unique` (`course_name`)
) ENGINE=InnoDB AUTO_INCREMENT=32 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of course
-- ----------------------------
INSERT INTO `course` VALUES ('16', '钢琴 一对一', '0', '一对一，45分钟每节课', '2016-08-22 13:57:48', '2016-08-22 14:02:47');
INSERT INTO `course` VALUES ('17', '钢琴 互动课', '1', '一对多的集体课', '2016-08-22 13:58:16', '2016-08-22 14:02:54');
INSERT INTO `course` VALUES ('18', '吉他 一对一', '0', '吉他一对一，45分钟每节课', '2016-08-22 13:58:45', '2016-08-22 14:03:03');
INSERT INTO `course` VALUES ('19', '吉他 一对多', '1', '一对多', '2016-08-22 13:59:28', '2016-08-22 14:03:21');
INSERT INTO `course` VALUES ('20', '架子鼓 一对一', '0', '一对一，45分钟每节课', '2016-08-22 14:00:40', '2016-08-22 14:03:32');
INSERT INTO `course` VALUES ('21', '架子鼓 一对多', '1', '一对多', '2016-08-22 14:01:08', '2016-08-22 14:03:46');
INSERT INTO `course` VALUES ('22', '舞蹈课 中国舞', '1', '90分钟，中间休息10分钟', '2016-08-22 14:01:43', null);
INSERT INTO `course` VALUES ('23', '舞蹈课 拉丁舞', '1', '一对多，90分钟，中间休息10分钟', '2016-08-22 14:02:09', null);
INSERT INTO `course` VALUES ('24', '古筝 一对一', '0', '45分钟每节课', '2016-08-22 14:04:15', null);
INSERT INTO `course` VALUES ('25', '美术 儿童画', '1', '90分钟', '2016-08-22 14:04:54', null);
INSERT INTO `course` VALUES ('26', '美术   素描', '1', '90分钟', '2016-08-22 14:05:13', '2016-08-22 14:05:25');
INSERT INTO `course` VALUES ('27', '书法', '1', '90分钟', '2016-08-22 14:06:19', null);
INSERT INTO `course` VALUES ('28', '声乐 一对一', '0', '30分钟', '2016-08-22 14:07:02', null);
INSERT INTO `course` VALUES ('29', '声乐 一对多', '1', '', '2016-08-22 14:07:16', null);
INSERT INTO `course` VALUES ('30', '笛子', '0', '45分钟', '2016-08-22 14:07:46', null);
INSERT INTO `course` VALUES ('31', '钢琴 陪练', '0', '', '2016-09-30 15:26:47', null);

-- ----------------------------
-- Table structure for grp
-- ----------------------------
DROP TABLE IF EXISTS `grp`;
CREATE TABLE `grp` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `grp_name` varchar(20) NOT NULL,
  `teacher_id` int(11) NOT NULL COMMENT '老师的id，即userid',
  `course_id` int(11) NOT NULL,
  `remark` varchar(255) DEFAULT NULL,
  `create_time` datetime NOT NULL,
  `update_time` datetime DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=17 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of grp
-- ----------------------------
INSERT INTO `grp` VALUES ('15', '钢琴 杨洁', '29', '16', '', '2016-09-16 10:35:46', '2016-09-17 09:35:31');
INSERT INTO `grp` VALUES ('16', '古筝 张琦', '39', '24', '', '2016-09-17 16:35:08', null);

-- ----------------------------
-- Table structure for grp_stu_mapping
-- ----------------------------
DROP TABLE IF EXISTS `grp_stu_mapping`;
CREATE TABLE `grp_stu_mapping` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `student_id` int(11) NOT NULL,
  `grp_id` int(11) NOT NULL,
  `create_time` datetime NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=57 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of grp_stu_mapping
-- ----------------------------
INSERT INTO `grp_stu_mapping` VALUES ('30', '28', '15', '2016-09-16 10:35:46');
INSERT INTO `grp_stu_mapping` VALUES ('31', '29', '15', '2016-09-16 10:35:46');
INSERT INTO `grp_stu_mapping` VALUES ('32', '30', '15', '2016-09-16 10:35:46');
INSERT INTO `grp_stu_mapping` VALUES ('33', '33', '15', '2016-09-17 09:35:31');
INSERT INTO `grp_stu_mapping` VALUES ('34', '44', '15', '2016-09-17 09:35:31');
INSERT INTO `grp_stu_mapping` VALUES ('35', '55', '15', '2016-09-17 09:35:31');
INSERT INTO `grp_stu_mapping` VALUES ('36', '34', '15', '2016-09-17 09:35:31');
INSERT INTO `grp_stu_mapping` VALUES ('37', '45', '15', '2016-09-17 09:35:31');
INSERT INTO `grp_stu_mapping` VALUES ('38', '35', '15', '2016-09-17 09:35:31');
INSERT INTO `grp_stu_mapping` VALUES ('39', '46', '15', '2016-09-17 09:35:31');
INSERT INTO `grp_stu_mapping` VALUES ('40', '57', '15', '2016-09-17 09:35:31');
INSERT INTO `grp_stu_mapping` VALUES ('41', '36', '15', '2016-09-17 09:35:31');
INSERT INTO `grp_stu_mapping` VALUES ('42', '47', '15', '2016-09-17 09:35:31');
INSERT INTO `grp_stu_mapping` VALUES ('43', '37', '15', '2016-09-17 09:35:31');
INSERT INTO `grp_stu_mapping` VALUES ('44', '48', '15', '2016-09-17 09:35:31');
INSERT INTO `grp_stu_mapping` VALUES ('45', '38', '15', '2016-09-17 09:35:31');
INSERT INTO `grp_stu_mapping` VALUES ('46', '39', '15', '2016-09-17 09:35:31');
INSERT INTO `grp_stu_mapping` VALUES ('47', '50', '15', '2016-09-17 09:35:31');
INSERT INTO `grp_stu_mapping` VALUES ('48', '40', '15', '2016-09-17 09:35:31');
INSERT INTO `grp_stu_mapping` VALUES ('49', '51', '15', '2016-09-17 09:35:31');
INSERT INTO `grp_stu_mapping` VALUES ('50', '52', '15', '2016-09-17 09:35:31');
INSERT INTO `grp_stu_mapping` VALUES ('51', '42', '15', '2016-09-17 09:35:31');
INSERT INTO `grp_stu_mapping` VALUES ('52', '53', '15', '2016-09-17 09:35:31');
INSERT INTO `grp_stu_mapping` VALUES ('53', '32', '15', '2016-09-17 09:35:31');
INSERT INTO `grp_stu_mapping` VALUES ('54', '43', '15', '2016-09-17 09:35:31');
INSERT INTO `grp_stu_mapping` VALUES ('55', '54', '15', '2016-09-17 09:35:31');
INSERT INTO `grp_stu_mapping` VALUES ('56', '56', '16', '2016-09-17 16:35:08');

-- ----------------------------
-- Table structure for stu_course_flow
-- ----------------------------
DROP TABLE IF EXISTS `stu_course_flow`;
CREATE TABLE `stu_course_flow` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `student_id` int(11) NOT NULL,
  `course_id` int(11) NOT NULL,
  `type` int(2) NOT NULL COMMENT '0:消费   1:充值  2:赠送',
  `operate_id` int(11) NOT NULL,
  `course_count` int(10) NOT NULL COMMENT '上课数量或者充值课数',
  `recharge_fee` int(10) NOT NULL COMMENT '充值费用',
  `remark` varchar(255) NOT NULL COMMENT '备注',
  `teacher_work_id` varchar(50) NOT NULL COMMENT '教师点课id号',
  `create_time` datetime NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=436 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of stu_course_flow
-- ----------------------------
INSERT INTO `stu_course_flow` VALUES ('125', '28', '16', '1', '1', '2', '196', '', 'a95738f6a9794a09bf207fadbac7b74f', '2016-08-22 14:16:55');
INSERT INTO `stu_course_flow` VALUES ('126', '29', '16', '1', '1', '32', '2628', '年卡剩余30节课，送2节课', 'ad0df48d63674124b81eabea233fce77', '2016-09-16 10:13:08');
INSERT INTO `stu_course_flow` VALUES ('127', '28', '16', '1', '1', '1', '98', '', '5ead6e244f904b689b7b08eba2b26358', '2016-09-16 10:13:23');
INSERT INTO `stu_course_flow` VALUES ('128', '30', '16', '1', '1', '3', '294', '', '311121deb200491e9ecbde3c1b1baee0', '2016-09-16 10:18:58');
INSERT INTO `stu_course_flow` VALUES ('129', '28', '16', '0', '29', '1', '0', '2016.8.12', '7b26d4d87c414470959e4466e98b985f', '2016-09-16 10:36:50');
INSERT INTO `stu_course_flow` VALUES ('130', '28', '16', '0', '29', '1', '0', '2016.9.12', 'd98f8a46b8164be593504a531db0a38f', '2016-09-16 10:37:04');
INSERT INTO `stu_course_flow` VALUES ('131', '32', '16', '1', '1', '23', '2015', '', 'b3fe6cf3d37942aebd79599f7ee82be8', '2016-09-16 10:41:49');
INSERT INTO `stu_course_flow` VALUES ('132', '33', '16', '1', '1', '17', '1666', '', 'a60db53b443d4b529c3a017158820cbe', '2016-09-16 10:42:58');
INSERT INTO `stu_course_flow` VALUES ('133', '34', '16', '1', '1', '1', '98', '', 'b8630caa67a043afa5a51f5064bab88a', '2016-09-16 10:44:53');
INSERT INTO `stu_course_flow` VALUES ('134', '35', '16', '1', '1', '43', '3592', '', 'd3b86fa26b0c4c5984599266a5605dfb', '2016-09-16 10:46:35');
INSERT INTO `stu_course_flow` VALUES ('135', '36', '16', '1', '1', '45', '3767', '', '6cdfd5a9757e4cd8920c4d0c55344f84', '2016-09-16 10:52:30');
INSERT INTO `stu_course_flow` VALUES ('136', '37', '16', '1', '1', '4', '392', '', '6388b42de45f4e8890d12329b62ddb84', '2016-09-16 11:12:19');
INSERT INTO `stu_course_flow` VALUES ('137', '38', '16', '1', '1', '27', '2366', '', '812994bed4fb45f782fd1a7e3d3a8dcc', '2016-09-16 11:18:36');
INSERT INTO `stu_course_flow` VALUES ('138', '39', '16', '1', '1', '25', '2190', '', '9af95df2d20846268bdb6ef778a5a516', '2016-09-16 11:27:54');
INSERT INTO `stu_course_flow` VALUES ('139', '40', '16', '1', '1', '2', '196', '', '52a8657712954342891dc8e44c1e3dc1', '2016-09-16 11:39:24');
INSERT INTO `stu_course_flow` VALUES ('140', '42', '16', '1', '1', '33', '2891', '', '7041a378734345f59b9985028b09a049', '2016-09-16 11:46:41');
INSERT INTO `stu_course_flow` VALUES ('141', '43', '16', '1', '1', '28', '2453', '', '7dd85fe05eed4177987b35b775f33a80', '2016-09-16 11:48:44');
INSERT INTO `stu_course_flow` VALUES ('142', '44', '16', '1', '1', '5', '490', '', '2bba1f66b73545b3b0277187f3d43022', '2016-09-16 11:49:31');
INSERT INTO `stu_course_flow` VALUES ('143', '45', '16', '1', '1', '30', '2628', '', 'cddeeccf53824c499d21db36f6c11777', '2016-09-16 11:53:37');
INSERT INTO `stu_course_flow` VALUES ('144', '46', '16', '1', '1', '12', '1176', '', '8db743f289e6464db0caa0cb848c6ecd', '2016-09-16 11:54:22');
INSERT INTO `stu_course_flow` VALUES ('145', '47', '16', '1', '1', '29', '2541', '', '065b655dbd9d43ceb15e7df122874e29', '2016-09-16 11:56:45');
INSERT INTO `stu_course_flow` VALUES ('146', '48', '16', '1', '1', '10', '980', '', '4c90259069bd4ccd92dbb44cb691f34c', '2016-09-16 11:57:50');
INSERT INTO `stu_course_flow` VALUES ('147', '50', '16', '1', '1', '6', '588', '', '1e391ac3b0364d6d8eaea8fcaf91ee5c', '2016-09-16 12:01:46');
INSERT INTO `stu_course_flow` VALUES ('148', '51', '16', '1', '1', '8', '784', '', '214126c84a6141a5b19b7123f4d240f4', '2016-09-16 12:05:01');
INSERT INTO `stu_course_flow` VALUES ('149', '52', '16', '1', '1', '3', '294', '', '7a56b19f55ed4b8db3cff2aa1907321d', '2016-09-16 12:05:43');
INSERT INTO `stu_course_flow` VALUES ('150', '53', '16', '1', '1', '25', '2190', '', 'c189f726868148c084d8fcacb202178e', '2016-09-16 12:06:30');
INSERT INTO `stu_course_flow` VALUES ('151', '54', '16', '1', '1', '3', '210', '30分钟的，2015年6月28第一次', 'b03d2815c58f478d95ed8272042c043a', '2016-09-16 12:07:56');
INSERT INTO `stu_course_flow` VALUES ('152', '55', '16', '1', '1', '3', '294', '', 'c25b45ff99d14acb93a2a870e863c86b', '2016-09-16 12:09:16');
INSERT INTO `stu_course_flow` VALUES ('153', '57', '16', '1', '1', '2', '196', '', 'b9959eec2d344a409ed1bde2c115401b', '2016-09-16 12:11:46');
INSERT INTO `stu_course_flow` VALUES ('155', '56', '24', '1', '1', '10', '880', '', 'c52d5d1a30ac4433855a56832f7c946d', '2016-09-17 16:32:11');
INSERT INTO `stu_course_flow` VALUES ('156', '56', '24', '0', '39', '1', '0', '9月3号', 'c3b2fb2f782d4ccd8eb1aa539c4fc454', '2016-09-17 16:35:55');
INSERT INTO `stu_course_flow` VALUES ('157', '56', '24', '0', '39', '1', '0', '9月10日\r\n', '80b0b12d83e3497aa503b75ec70cb2d8', '2016-09-17 16:36:07');
INSERT INTO `stu_course_flow` VALUES ('158', '60', '16', '1', '1', '9', '882', '', 'c0522018f0294654b4a864b37be49685', '2016-09-28 11:00:24');
INSERT INTO `stu_course_flow` VALUES ('159', '61', '16', '1', '1', '10', '980', '', 'e5f6fb663f7f44a7bcce99d9689b8aee', '2016-09-28 11:12:24');
INSERT INTO `stu_course_flow` VALUES ('161', '63', '16', '1', '1', '0', '0', '寒暑假生', '4648a58507294154be5cce18b9427b6d', '2016-09-28 11:17:07');
INSERT INTO `stu_course_flow` VALUES ('163', '65', '16', '1', '1', '1', '98', '', '7dd7e3e3ea7240dfbee15553cf5d7917', '2016-09-28 11:23:53');
INSERT INTO `stu_course_flow` VALUES ('164', '66', '16', '1', '1', '1', '98', '', '01a830bbf7eb4ac49deb4f1941608554', '2016-09-28 11:25:33');
INSERT INTO `stu_course_flow` VALUES ('166', '68', '16', '1', '1', '8', '784', '', '090d3764c8b34f2b89e2c2e9aa1d1ca1', '2016-09-28 11:47:03');
INSERT INTO `stu_course_flow` VALUES ('167', '69', '16', '1', '1', '10', '980', '', '02ffcdb1eebe4d5d91881c996c553a0d', '2016-09-28 12:39:11');
INSERT INTO `stu_course_flow` VALUES ('168', '70', '16', '1', '1', '9', '882', '', 'aeff5fce630a46868c12c9f1d7ae08d6', '2016-09-28 12:40:43');
INSERT INTO `stu_course_flow` VALUES ('169', '71', '16', '1', '1', '14', '1372', '', 'd88899a76163477d9c5efea6f6993877', '2016-09-28 12:42:59');
INSERT INTO `stu_course_flow` VALUES ('170', '72', '16', '1', '1', '21', '2058', '', '32253656af2c4eeda3a91ca544755688', '2016-09-28 12:44:57');
INSERT INTO `stu_course_flow` VALUES ('171', '73', '16', '1', '1', '11', '1078', '', 'd31f530069fe4dc291529f8cfc20abda', '2016-09-28 12:48:06');
INSERT INTO `stu_course_flow` VALUES ('172', '77', '16', '1', '1', '28', '2190', '', '3e6aafba4b114ed6bc0cb498a215e064', '2016-09-28 13:00:01');
INSERT INTO `stu_course_flow` VALUES ('173', '78', '16', '1', '1', '1', '98', '', '67135824913343adb7e6bf9c1bbbd4e9', '2016-09-28 13:02:49');
INSERT INTO `stu_course_flow` VALUES ('174', '79', '16', '1', '1', '57', '4655', '', '7162802543fb426881fce5dfc19b9b1e', '2016-09-28 13:05:16');
INSERT INTO `stu_course_flow` VALUES ('175', '81', '16', '1', '1', '12', '922', '', '75bbc48b1ca34782b8a892d371b45e62', '2016-09-28 13:10:59');
INSERT INTO `stu_course_flow` VALUES ('176', '82', '16', '1', '1', '21', '1803', '', 'b91abe5a74a847668db67c31ff302a84', '2016-09-28 13:13:02');
INSERT INTO `stu_course_flow` VALUES ('177', '84', '16', '1', '1', '23', '2015', '', '48d46cc3ae4e422b8c3f548c4dff0fef', '2016-09-28 13:15:11');
INSERT INTO `stu_course_flow` VALUES ('178', '87', '16', '1', '1', '9', '882', '', '923b667f26414cd9afd4aae82c77bdf6', '2016-09-28 13:22:17');
INSERT INTO `stu_course_flow` VALUES ('180', '90', '16', '1', '1', '38', '3329', '', '86860c1a5ae7495c8777e3fa199fe6db', '2016-09-28 13:27:36');
INSERT INTO `stu_course_flow` VALUES ('181', '91', '16', '1', '1', '1', '98', '', '6856a97f5658463aa1718234f5346d30', '2016-09-28 13:28:41');
INSERT INTO `stu_course_flow` VALUES ('182', '92', '16', '1', '1', '18', '1576', '', 'b7211cc8657846369c2eb9df36bb616a', '2016-09-28 13:30:36');
INSERT INTO `stu_course_flow` VALUES ('183', '94', '16', '1', '1', '9', '744', '', 'fa05555f744c4041bc5eba80be8552fd', '2016-09-28 13:33:19');
INSERT INTO `stu_course_flow` VALUES ('184', '94', '16', '1', '1', '5', '490', '表演奖送5节课', 'ad5bc6b99e594fdeb2e120019e6ca75d', '2016-09-28 13:34:35');
INSERT INTO `stu_course_flow` VALUES ('185', '95', '16', '1', '1', '46', '4508', '送15节电钢', '5e72496ecbb64c6ea384bdad1dbcc508', '2016-09-28 13:37:19');
INSERT INTO `stu_course_flow` VALUES ('187', '97', '16', '1', '1', '18', '1516', '', '121e3998ad67409aa62ce3217334aa80', '2016-09-28 13:41:24');
INSERT INTO `stu_course_flow` VALUES ('188', '98', '16', '1', '1', '3', '294', '', '95b57188b5484216a2a0b6004d52c88b', '2016-09-28 13:42:34');
INSERT INTO `stu_course_flow` VALUES ('190', '100', '16', '1', '1', '8', '784', '', '0342a975e4b542ddb09a8f5a6821765f', '2016-09-28 13:50:11');
INSERT INTO `stu_course_flow` VALUES ('191', '100', '16', '1', '1', '10', '980', '', '5bf6c061c78d46f69a544a5f660ca78f', '2016-09-28 13:50:36');
INSERT INTO `stu_course_flow` VALUES ('193', '102', '16', '1', '1', '13', '1139', '', '75f73c5398cc49aeb05f6e24dbc753a2', '2016-09-28 13:55:30');
INSERT INTO `stu_course_flow` VALUES ('194', '104', '16', '1', '1', '1', '98', '', '9393f2a7dbe048029f77cdfc63a9298f', '2016-09-28 13:57:45');
INSERT INTO `stu_course_flow` VALUES ('195', '105', '16', '1', '1', '18', '1764', '', 'bd8b502923774c7fb2e2c018f52996df', '2016-09-28 14:11:16');
INSERT INTO `stu_course_flow` VALUES ('196', '105', '16', '1', '1', '5', '490', '表演奖', '916429d3b8854b09a0be0ace0e6cbda9', '2016-09-28 14:11:56');
INSERT INTO `stu_course_flow` VALUES ('197', '106', '16', '1', '1', '31', '2716', '', 'ce34cb775c784c89ba49b8986f028447', '2016-09-28 14:15:48');
INSERT INTO `stu_course_flow` VALUES ('198', '107', '16', '1', '1', '13', '1139', '', '9423baef0d5f4248b1fe1cfcfd605019', '2016-09-28 14:17:57');
INSERT INTO `stu_course_flow` VALUES ('199', '107', '16', '1', '1', '5', '490', '表演奖', '58c674a03ac345688a2ec05ad9ca1484', '2016-09-28 14:18:23');
INSERT INTO `stu_course_flow` VALUES ('200', '108', '16', '1', '1', '41', '4018', '', '2370742119a44f4583cc8ab619eb8474', '2016-09-28 14:20:18');
INSERT INTO `stu_course_flow` VALUES ('201', '109', '16', '1', '1', '1', '98', '', '410cf1fa7f20441a8088e838668ec9ea', '2016-09-28 14:28:14');
INSERT INTO `stu_course_flow` VALUES ('202', '110', '16', '1', '1', '1', '98', '', 'b65db5a5ef7e4b37a117e21c8143d81f', '2016-09-28 14:29:07');
INSERT INTO `stu_course_flow` VALUES ('204', '112', '16', '1', '1', '37', '3241', '', '5df7a74b23aa4e5eb486c6fe9e5b36e5', '2016-09-28 14:35:14');
INSERT INTO `stu_course_flow` VALUES ('206', '115', '16', '1', '1', '1', '98', '', '1ae820e8c0e5499a9197230b5db2a646', '2016-09-28 14:43:02');
INSERT INTO `stu_course_flow` VALUES ('207', '116', '16', '1', '1', '5', '490', '', 'e2250600762047e2a3cfad1276d7d85d', '2016-09-28 14:45:10');
INSERT INTO `stu_course_flow` VALUES ('208', '117', '16', '1', '1', '27', '2365', '', 'aa4148ad667d4f45aa750992c6a7dd31', '2016-09-28 14:46:17');
INSERT INTO `stu_course_flow` VALUES ('209', '118', '16', '1', '1', '26', '2278', '', '002bf2ff2c2e47bea1f2e61e5984e083', '2016-09-28 14:52:20');
INSERT INTO `stu_course_flow` VALUES ('211', '120', '16', '1', '1', '6', '588', '', '43ce1a2e3b564c6f8d8905fbd85804f3', '2016-09-28 14:56:36');
INSERT INTO `stu_course_flow` VALUES ('213', '121', '16', '1', '1', '2', '196', '', '21824f29e5c540acbfb1c725876602f7', '2016-09-28 14:59:38');
INSERT INTO `stu_course_flow` VALUES ('214', '122', '16', '1', '1', '36', '3154', '', 'a477a745cf7b4337b35d0bf2f3ee38a3', '2016-09-28 15:05:52');
INSERT INTO `stu_course_flow` VALUES ('215', '124', '16', '1', '1', '37', '3241', '', '8c4f5a7c79d3408291a315839c452deb', '2016-09-28 15:10:30');
INSERT INTO `stu_course_flow` VALUES ('216', '127', '16', '1', '1', '10', '980', '', '415a281fe66643509289867194fa096c', '2016-09-28 15:16:35');
INSERT INTO `stu_course_flow` VALUES ('217', '128', '16', '1', '1', '5', '445', '', '6532bfb90c6c4804a8b298118b54656d', '2016-09-28 15:17:57');
INSERT INTO `stu_course_flow` VALUES ('218', '129', '16', '1', '1', '4', '392', '', '43507f5b020b437688647bea9efd7111', '2016-09-28 15:19:43');
INSERT INTO `stu_course_flow` VALUES ('219', '131', '16', '1', '1', '8', '784', '', '84cd1d418616450b95674b4be7e9cf5d', '2016-09-28 15:24:35');
INSERT INTO `stu_course_flow` VALUES ('220', '130', '16', '1', '1', '9', '882', '', '9c671034906049d8aad11682e8817b49', '2016-09-28 15:24:54');
INSERT INTO `stu_course_flow` VALUES ('221', '132', '16', '1', '1', '9', '882', '', '2a044bc5f92c4e798dce62ecd9e22490', '2016-09-28 15:25:57');
INSERT INTO `stu_course_flow` VALUES ('222', '133', '18', '1', '1', '31', '2728', '', '6d19d018ee1c42cd8f06d02946618353', '2016-09-28 15:57:19');
INSERT INTO `stu_course_flow` VALUES ('223', '134', '18', '1', '1', '19', '1672', '', 'a63ad827cdc142bf9153e68caa8a3ecf', '2016-09-28 20:17:23');
INSERT INTO `stu_course_flow` VALUES ('224', '135', '18', '1', '1', '35', '3080', '', 'fc2c7912fb694c9f8eeb53327407aad1', '2016-09-28 20:18:59');
INSERT INTO `stu_course_flow` VALUES ('225', '136', '18', '1', '1', '2', '176', '', 'f193898544a44d86bcfdcf2cace49248', '2016-09-28 20:23:04');
INSERT INTO `stu_course_flow` VALUES ('226', '137', '16', '1', '1', '18', '1604', '', '7dcf901aa7964ba7ba164d46aa00a3ab', '2016-09-28 20:27:27');
INSERT INTO `stu_course_flow` VALUES ('227', '138', '20', '1', '1', '4', '432', '', '9943d611c4f84af2b09b74c694df475b', '2016-09-28 20:28:59');
INSERT INTO `stu_course_flow` VALUES ('228', '139', '20', '1', '1', '3', '324', '', 'b2c31245d2444fe8be57ea1916e5e23f', '2016-09-28 20:31:33');
INSERT INTO `stu_course_flow` VALUES ('229', '140', '20', '1', '1', '2', '216', '', 'ec84836c92dc475d82c6a10672757f7b', '2016-09-28 20:33:05');
INSERT INTO `stu_course_flow` VALUES ('230', '141', '20', '1', '1', '35', '3780', '', 'f37f201a0b9c4b3f8f92d2b136307e38', '2016-09-28 20:38:01');
INSERT INTO `stu_course_flow` VALUES ('231', '142', '20', '1', '1', '8', '648', '', 'dbda2626f993414cbbc52c99034d9ce2', '2016-09-28 20:39:42');
INSERT INTO `stu_course_flow` VALUES ('232', '143', '16', '1', '1', '8', '648', '', '5ad4fae6cf424e5684e8f8e908d65f3d', '2016-09-28 20:40:55');
INSERT INTO `stu_course_flow` VALUES ('233', '143', '20', '1', '1', '5', '540', '表演奖送5节课', 'd8ff90b415d8498590854a6e60a4fb37', '2016-09-28 20:41:46');
INSERT INTO `stu_course_flow` VALUES ('234', '145', '20', '1', '1', '55', '5121', '', '48d4a1a352c549c5b5a5cb50e4b5ab53', '2016-09-28 20:44:36');
INSERT INTO `stu_course_flow` VALUES ('235', '144', '20', '1', '1', '12', '1296', '', 'bb976ca717ca421294f1fd15ebbdf39c', '2016-09-28 20:48:08');
INSERT INTO `stu_course_flow` VALUES ('236', '146', '20', '1', '1', '24', '2592', '', '99cb482503ad403388e1df03c089dc01', '2016-09-28 20:48:51');
INSERT INTO `stu_course_flow` VALUES ('237', '147', '20', '1', '1', '47', '5076', '', '6e8cbca79d9940068bfa0bdc5b300401', '2016-09-28 20:50:06');
INSERT INTO `stu_course_flow` VALUES ('238', '148', '20', '1', '1', '43', '4644', '', 'f620f36279244f3a838ffb7d15edbc6a', '2016-09-28 20:52:41');
INSERT INTO `stu_course_flow` VALUES ('239', '149', '20', '1', '1', '8', '864', '买鼓送10节课', 'b9588049ffb341859461ea204c3ac006', '2016-09-28 20:54:18');
INSERT INTO `stu_course_flow` VALUES ('240', '150', '20', '1', '1', '5', '540', '', '94cb0b938a884f66a3932085924af4a5', '2016-09-28 20:56:51');
INSERT INTO `stu_course_flow` VALUES ('241', '151', '16', '1', '1', '20', '1836', '', 'b6e1bcdb93284c228ea8c927eb8f7812', '2016-09-28 20:58:14');
INSERT INTO `stu_course_flow` VALUES ('242', '152', '20', '1', '1', '7', '756', '', 'cb46a5fdb3b943fc9b4b47083ae4a77e', '2016-09-28 21:06:00');
INSERT INTO `stu_course_flow` VALUES ('243', '153', '20', '1', '1', '7', '756', '', '8f651b26a8d44377ab9e9a43c3290c60', '2016-09-28 21:07:14');
INSERT INTO `stu_course_flow` VALUES ('244', '154', '20', '1', '1', '4', '432', '', 'c7d5e0ae20684f43b63f3b1a62827826', '2016-09-28 21:08:40');
INSERT INTO `stu_course_flow` VALUES ('245', '155', '20', '1', '1', '8', '756', '', 'ff13e942f5c74107a1905486059aa269', '2016-09-28 21:10:00');
INSERT INTO `stu_course_flow` VALUES ('246', '156', '20', '1', '1', '9', '864', '', '4e6447623bc04c3b86d1201a64b5ed79', '2016-09-28 21:11:05');
INSERT INTO `stu_course_flow` VALUES ('247', '157', '20', '1', '1', '9', '972', '', '5ab65e76f7464f578ef45b00c1415d9e', '2016-09-28 21:12:11');
INSERT INTO `stu_course_flow` VALUES ('250', '183', '18', '1', '1', '9', '792', '', 'f8c8939985744fe58283466cde7652fc', '2016-09-29 08:51:39');
INSERT INTO `stu_course_flow` VALUES ('251', '184', '18', '1', '1', '9', '792', '', 'e571a04088a049d5ad2da6fdde6977ad', '2016-09-29 08:52:24');
INSERT INTO `stu_course_flow` VALUES ('252', '185', '18', '1', '1', '8', '704', '', '71e66649add7409fa1bf30f41207d7ae', '2016-09-29 08:53:48');
INSERT INTO `stu_course_flow` VALUES ('253', '186', '18', '1', '1', '8', '704', '', '11aa7680edeb4e569de040ae56a2d786', '2016-09-29 08:54:41');
INSERT INTO `stu_course_flow` VALUES ('254', '187', '18', '1', '1', '7', '616', '', '023bc6ebea35412c9a6dece318969947', '2016-09-29 08:56:19');
INSERT INTO `stu_course_flow` VALUES ('255', '188', '18', '1', '1', '7', '616', '', 'faf1ad38160546368f55d3b1d1dea339', '2016-09-29 08:57:13');
INSERT INTO `stu_course_flow` VALUES ('256', '190', '18', '1', '1', '8', '704', '', '8da77052816d4ab3a37ad235d91fd602', '2016-09-29 08:58:42');
INSERT INTO `stu_course_flow` VALUES ('257', '191', '18', '1', '1', '7', '528', '', '9c6f3689b1b849fb9ac614f6d15f546c', '2016-09-29 08:59:53');
INSERT INTO `stu_course_flow` VALUES ('258', '192', '18', '1', '1', '8', '704', '', 'b8fe43be64f645c9b602bd0ff4cafa4d', '2016-09-29 09:00:52');
INSERT INTO `stu_course_flow` VALUES ('259', '193', '18', '1', '1', '6', '528', '', '3e971da82a0f4f4c8d2c7e645e8d066e', '2016-09-29 09:01:51');
INSERT INTO `stu_course_flow` VALUES ('260', '194', '18', '1', '1', '5', '440', '', '1d15735335504d62b465d6952f0d0b42', '2016-09-29 09:02:39');
INSERT INTO `stu_course_flow` VALUES ('261', '195', '18', '1', '1', '5', '440', '', 'd0fab93beec543768f291b43b016c92f', '2016-09-29 09:06:32');
INSERT INTO `stu_course_flow` VALUES ('262', '196', '18', '1', '1', '4', '352', '', '93b0aaef93184d17b7db089c71c7a618', '2016-09-29 09:07:25');
INSERT INTO `stu_course_flow` VALUES ('263', '197', '18', '1', '1', '7', '616', '', 'aea08887a2484561a0dff43966b47e00', '2016-09-29 09:09:57');
INSERT INTO `stu_course_flow` VALUES ('265', '199', '18', '1', '1', '8', '704', '', '85bc26bed9e24577a812dbed2e803b7c', '2016-09-29 09:13:05');
INSERT INTO `stu_course_flow` VALUES ('267', '201', '18', '1', '1', '3', '264', '', '9dc56d2d4eab464680ac0935fd24f018', '2016-09-29 09:16:25');
INSERT INTO `stu_course_flow` VALUES ('268', '203', '18', '1', '1', '10', '880', '', '29a2b27b6a1044ad933fc1a6225c588d', '2016-09-29 09:18:14');
INSERT INTO `stu_course_flow` VALUES ('269', '204', '18', '1', '1', '1', '0', '古筝转8节', '34ac1e80c2474491ab707a54e3f08a6b', '2016-09-29 09:20:04');
INSERT INTO `stu_course_flow` VALUES ('270', '205', '18', '1', '1', '5', '440', '', '3358c053178b46aab41033afcf854ed3', '2016-09-29 09:21:27');
INSERT INTO `stu_course_flow` VALUES ('271', '206', '18', '1', '1', '38', '3344', '', 'e3351a95867b49e3a51d2bb55d2709b8', '2016-09-29 09:22:55');
INSERT INTO `stu_course_flow` VALUES ('272', '202', '18', '1', '1', '8', '704', '', 'bb152df4bb394456b31896e244fe538a', '2016-09-29 09:23:25');
INSERT INTO `stu_course_flow` VALUES ('273', '207', '18', '1', '1', '3', '264', '', 'e5f7ef79d42140ce8a66713b81be8cd8', '2016-09-29 09:26:55');
INSERT INTO `stu_course_flow` VALUES ('274', '209', '18', '1', '1', '4', '352', '', 'a727091942214caea909e7002f60d849', '2016-09-29 09:31:29');
INSERT INTO `stu_course_flow` VALUES ('275', '211', '18', '1', '1', '5', '440', '', 'd8360b0138d148549a9e2c38fdde016f', '2016-09-29 09:34:31');
INSERT INTO `stu_course_flow` VALUES ('276', '212', '18', '1', '1', '4', '352', '', 'ef66ec150bb7424dbb8548beac65f710', '2016-09-29 09:38:50');
INSERT INTO `stu_course_flow` VALUES ('277', '214', '18', '1', '1', '6', '528', '', 'b543e612c0a6479480837120e8cdccf3', '2016-09-29 09:42:20');
INSERT INTO `stu_course_flow` VALUES ('278', '218', '18', '1', '1', '5', '440', '', 'ef43bad7b8d3403f8a4a3d75e13e0bb0', '2016-09-29 09:46:32');
INSERT INTO `stu_course_flow` VALUES ('279', '219', '18', '1', '1', '9', '528', '', '9bf5bf3f42f04778bd5bd5e46ffe8e81', '2016-09-29 09:47:35');
INSERT INTO `stu_course_flow` VALUES ('280', '220', '18', '1', '1', '7', '616', '', '61c1a15e5ca844f7b95ba6e95edd78c3', '2016-09-29 09:49:20');
INSERT INTO `stu_course_flow` VALUES ('281', '221', '18', '1', '1', '1', '88', '马舒涵转4节课', '71f7f1df22784fd795f13a61eb13ec53', '2016-09-29 09:51:08');
INSERT INTO `stu_course_flow` VALUES ('282', '222', '18', '1', '1', '3', '176', '', '7842c73dbda24de482ee294dd2145113', '2016-09-29 09:52:27');
INSERT INTO `stu_course_flow` VALUES ('284', '224', '18', '1', '1', '7', '616', '', '96cb15f38dae4b0a98c24c3371feb742', '2016-09-29 09:56:02');
INSERT INTO `stu_course_flow` VALUES ('286', '181', '24', '1', '1', '10', '880', '', 'dfeafdcb4fbf4805baf5486d0cf37eec', '2016-09-29 10:07:45');
INSERT INTO `stu_course_flow` VALUES ('287', '56', '24', '1', '1', '7', '616', '', '66bc74cdf86b4609a34e23f6e2656c5f', '2016-09-29 10:09:49');
INSERT INTO `stu_course_flow` VALUES ('288', '234', '24', '1', '1', '5', '440', '', 'd4632f2ffe5e4eb19d0c7b8b8b36ec19', '2016-09-29 10:11:08');
INSERT INTO `stu_course_flow` VALUES ('289', '235', '24', '1', '1', '26', '2288', '', '26d383e4d4d84930b0b47204a9b373cb', '2016-09-29 10:12:17');
INSERT INTO `stu_course_flow` VALUES ('290', '236', '24', '1', '1', '3', '264', '', '5343439755544dd288c54f77ae5fd9b2', '2016-09-29 10:13:53');
INSERT INTO `stu_course_flow` VALUES ('291', '237', '24', '1', '1', '5', '440', '', '4e717dd18a7d4cffa3288a400ed8666c', '2016-09-29 10:14:45');
INSERT INTO `stu_course_flow` VALUES ('292', '238', '24', '1', '1', '3', '264', '', '5e49709e1a64409aac6d4d1f7d557680', '2016-09-29 10:15:51');
INSERT INTO `stu_course_flow` VALUES ('293', '239', '24', '1', '1', '30', '2640', '', 'eb07551075114677a7eabfa6b67eefde', '2016-09-29 10:16:53');
INSERT INTO `stu_course_flow` VALUES ('294', '240', '24', '1', '1', '30', '2552', '', 'ee79e1df930044c7910ae778a670d177', '2016-09-29 10:17:57');
INSERT INTO `stu_course_flow` VALUES ('295', '242', '24', '1', '1', '29', '2552', '', '888ff368a1214608b380bfaaab6f1ad2', '2016-09-29 10:21:26');
INSERT INTO `stu_course_flow` VALUES ('296', '243', '24', '1', '1', '2', '176', '', 'd1f11d4a8c244b6d82d0fba50fc3c537', '2016-09-29 10:22:32');
INSERT INTO `stu_course_flow` VALUES ('299', '255', '22', '1', '1', '11', '440', '', '4e98fb253f3d446595fba59a37b1b964', '2016-09-29 11:01:49');
INSERT INTO `stu_course_flow` VALUES ('300', '256', '22', '1', '1', '1', '40', '', '5a9bd7ef3c164aca897854b4106041f3', '2016-09-29 11:02:58');
INSERT INTO `stu_course_flow` VALUES ('301', '257', '22', '1', '1', '8', '320', '', 'ce53d7c4fed54ae1b82332ef6fc389d5', '2016-09-29 11:04:10');
INSERT INTO `stu_course_flow` VALUES ('303', '262', '22', '1', '1', '10', '400', '', '7a036d41fadb422da5fc82c7769b5c9c', '2016-09-29 11:07:48');
INSERT INTO `stu_course_flow` VALUES ('306', '266', '22', '1', '1', '4', '160', '', '4aa5427f67bc4ba0893f7a6bb5fbe060', '2016-09-29 11:54:18');
INSERT INTO `stu_course_flow` VALUES ('307', '267', '22', '1', '1', '2', '80', '', '39d354ada7e3457b88345919ff8ec10c', '2016-09-29 11:55:48');
INSERT INTO `stu_course_flow` VALUES ('308', '268', '22', '1', '1', '4', '160', '', '456ad01dd2554ae1a32a047fd6c8a9df', '2016-09-29 12:00:18');
INSERT INTO `stu_course_flow` VALUES ('309', '269', '22', '1', '1', '2', '80', '', '38b8d83c68344f4bb81dc6f7988208a9', '2016-09-29 12:02:54');
INSERT INTO `stu_course_flow` VALUES ('310', '270', '22', '1', '1', '5', '200', '', 'c9960f3f071647c78ff4bdb35d21dc0a', '2016-09-29 12:03:37');
INSERT INTO `stu_course_flow` VALUES ('312', '273', '22', '1', '1', '2', '80', '', '77503e29e28343cab6e3c9f40b0d5409', '2016-09-29 12:27:05');
INSERT INTO `stu_course_flow` VALUES ('313', '274', '22', '1', '1', '9', '360', '', '074681a59eb84bd1833694103c43812e', '2016-09-29 12:27:49');
INSERT INTO `stu_course_flow` VALUES ('315', '276', '22', '1', '1', '12', '480', '', '79b7c4ea60194c27b1e143d0777a183d', '2016-09-29 12:42:47');
INSERT INTO `stu_course_flow` VALUES ('316', '277', '22', '1', '1', '2', '80', '', '921a7fac6b554765905da17363619b55', '2016-09-29 12:43:34');
INSERT INTO `stu_course_flow` VALUES ('317', '278', '22', '1', '1', '17', '680', '', '34f69b0cdb404f81bd9b9b12b6dd99f0', '2016-09-29 12:44:28');
INSERT INTO `stu_course_flow` VALUES ('319', '280', '22', '1', '1', '6', '240', '', '8110289ba7e94018843abbe30c1e04f5', '2016-09-29 12:52:04');
INSERT INTO `stu_course_flow` VALUES ('324', '288', '22', '1', '1', '3', '120', '', 'a484bc94020b4c8dac83a38d15630923', '2016-09-29 13:02:25');
INSERT INTO `stu_course_flow` VALUES ('325', '289', '22', '1', '1', '12', '480', '', '6e758df12d7c4ba7acb8940f92d1059c', '2016-09-29 13:03:15');
INSERT INTO `stu_course_flow` VALUES ('327', '296', '28', '1', '1', '1', '108', '', '09f778e43438458c9cd7098c08625696', '2016-09-29 13:13:57');
INSERT INTO `stu_course_flow` VALUES ('333', '301', '16', '1', '1', '55', '4900', '', '0ca29d02659a4d49a46d1f68c0719802', '2016-09-30 08:47:06');
INSERT INTO `stu_course_flow` VALUES ('334', '276', '22', '1', '1', '15', '580', '', '6644d260ae3140c582e56ee31c9a70c4', '2016-09-30 08:59:06');
INSERT INTO `stu_course_flow` VALUES ('336', '48', '23', '1', '1', '15', '580', '', 'e586cffeaac54afa8db7eeb6dd752892', '2016-09-30 09:26:26');
INSERT INTO `stu_course_flow` VALUES ('338', '78', '16', '1', '1', '55', '4900', '', '4a8e59ada65c4e0dbe7fa39563be797a', '2016-09-30 09:46:56');
INSERT INTO `stu_course_flow` VALUES ('339', '303', '20', '1', '1', '8', '785', '', '378793eb7a364567a5a75465d8796e91', '2016-09-30 09:50:32');
INSERT INTO `stu_course_flow` VALUES ('340', '34', '16', '1', '1', '55', '4900', '', 'eaae4e2865bc4a37bc00e6085448b3cf', '2016-09-30 09:51:10');
INSERT INTO `stu_course_flow` VALUES ('341', '158', '25', '1', '1', '13', '589', '', '42b56ddf8fbb4ab18d3a7caff36d7bff', '2016-09-30 10:38:42');
INSERT INTO `stu_course_flow` VALUES ('342', '159', '25', '1', '1', '13', '589', '', 'bb39158885b94ccfb820803f46357eb6', '2016-09-30 10:39:16');
INSERT INTO `stu_course_flow` VALUES ('343', '160', '25', '1', '1', '13', '589', '', '328a43f4e2c44c168baf0daa0d88a55b', '2016-09-30 10:39:45');
INSERT INTO `stu_course_flow` VALUES ('344', '161', '25', '1', '1', '13', '589', '', '52efab6cebb64ed9abe493b89331bfa3', '2016-09-30 10:40:15');
INSERT INTO `stu_course_flow` VALUES ('345', '167', '25', '1', '1', '13', '589', '', 'bb62fd7697a94d73bc9042cf636e5aac', '2016-09-30 10:41:52');
INSERT INTO `stu_course_flow` VALUES ('346', '168', '25', '1', '1', '13', '589', '', '2ec29826d588430db50c4d88e5340215', '2016-09-30 10:42:24');
INSERT INTO `stu_course_flow` VALUES ('347', '169', '25', '1', '1', '13', '589', '', 'ddff62b53d234b94b02d4e287d34556d', '2016-09-30 10:43:12');
INSERT INTO `stu_course_flow` VALUES ('348', '165', '25', '1', '1', '13', '589', '', 'b71d7a2496a34ed980aa65c93fc9f79b', '2016-09-30 10:45:45');
INSERT INTO `stu_course_flow` VALUES ('350', '171', '25', '1', '1', '13', '589', '', '9c1ed395550d4098b72db2afcb8ead37', '2016-09-30 10:46:50');
INSERT INTO `stu_course_flow` VALUES ('351', '145', '25', '1', '1', '13', '589', '', '30ec308bf2a648ffbd33dee8e1413759', '2016-09-30 10:47:49');
INSERT INTO `stu_course_flow` VALUES ('352', '174', '25', '1', '1', '13', '589', '', '2d36933fae7a44f1b5898da8fb87dc48', '2016-09-30 10:49:07');
INSERT INTO `stu_course_flow` VALUES ('353', '175', '25', '1', '1', '13', '589', '', '72cc87898dd24c2597352ac24095ea3e', '2016-09-30 10:49:37');
INSERT INTO `stu_course_flow` VALUES ('354', '176', '25', '1', '1', '13', '589', '', 'bea4252373ef48d896662b6cce6cc90d', '2016-09-30 10:50:01');
INSERT INTO `stu_course_flow` VALUES ('355', '118', '25', '1', '1', '13', '589', '', 'cd3b822deccb42b8a63b5622d55ac079', '2016-09-30 10:50:38');
INSERT INTO `stu_course_flow` VALUES ('356', '123', '25', '1', '1', '13', '589', '', '438f734661b34e7f91c4ff283ea5ea1a', '2016-09-30 10:51:14');
INSERT INTO `stu_course_flow` VALUES ('357', '179', '25', '1', '1', '13', '589', '', '14e6e4587efb4e63bc85a9316862c7f7', '2016-09-30 10:51:40');
INSERT INTO `stu_course_flow` VALUES ('358', '277', '25', '1', '1', '13', '589', '', '0775e61d3d2b4829995a65685066c7e5', '2016-09-30 10:52:52');
INSERT INTO `stu_course_flow` VALUES ('359', '304', '25', '1', '1', '13', '589', '', '3b3898b5484c4c44affe8054f08ad126', '2016-09-30 10:53:55');
INSERT INTO `stu_course_flow` VALUES ('360', '87', '25', '1', '1', '13', '589', '', '293bc4a716ce4359b18e9841b15e90bb', '2016-09-30 10:55:03');
INSERT INTO `stu_course_flow` VALUES ('361', '177', '25', '1', '1', '13', '589', '', '109301937f194d40891448f95899da70', '2016-09-30 10:55:29');
INSERT INTO `stu_course_flow` VALUES ('362', '53', '25', '1', '1', '13', '589', '', '430116a7f42f43b489f979c42926abb0', '2016-09-30 10:56:43');
INSERT INTO `stu_course_flow` VALUES ('364', '115', '26', '1', '1', '13', '589', '', '3243268bb0284f7c80b4914583e22c9c', '2016-09-30 10:58:06');
INSERT INTO `stu_course_flow` VALUES ('365', '180', '26', '1', '1', '13', '589', '', 'b44ffd99f41543f7ae849ab66e698c45', '2016-09-30 10:58:32');
INSERT INTO `stu_course_flow` VALUES ('366', '81', '26', '1', '1', '13', '589', '', '5061ba0aabc74e348440bdb9b847f4ab', '2016-09-30 10:58:56');
INSERT INTO `stu_course_flow` VALUES ('367', '181', '26', '1', '1', '13', '589', '', '33ded5d356214713ab375c3b40a023f0', '2016-09-30 10:59:26');
INSERT INTO `stu_course_flow` VALUES ('368', '316', '22', '1', '1', '14', '541', '', '18e389016cd54fe3910a2d6b98ee4fc7', '2016-09-30 14:07:02');
INSERT INTO `stu_course_flow` VALUES ('369', '317', '22', '1', '1', '6', '231', '', 'd1f55e5d1b3c4197be0a4f7c85be22c6', '2016-09-30 14:09:29');
INSERT INTO `stu_course_flow` VALUES ('370', '293', '16', '1', '1', '11', '572', '', '20f76100a39241ff9db4064e3cde798e', '2016-09-30 14:12:02');
INSERT INTO `stu_course_flow` VALUES ('371', '279', '22', '1', '1', '20', '800', '', '7ebf7fd366564b7cb3916f521c0f9943', '2016-09-30 14:17:26');
INSERT INTO `stu_course_flow` VALUES ('372', '291', '22', '1', '1', '11', '440', '', '4cc036f256aa4815a2ecfd4761698374', '2016-09-30 14:18:58');
INSERT INTO `stu_course_flow` VALUES ('373', '318', '22', '1', '1', '31', '1240', '', '052acaa00cad4c1286a6e9a3c47dcaec', '2016-09-30 14:37:24');
INSERT INTO `stu_course_flow` VALUES ('374', '294', '22', '1', '1', '7', '280', '', '8055628dfbca4b27a8b45b9680e7deeb', '2016-09-30 14:41:18');
INSERT INTO `stu_course_flow` VALUES ('375', '91', '31', '1', '1', '2', '80', '', '2af9f85a589f4f009c9de716a61b5556', '2016-09-30 15:27:22');
INSERT INTO `stu_course_flow` VALUES ('376', '95', '31', '1', '1', '7', '280', '', '5877e040e00a489db305a57736842966', '2016-09-30 15:29:37');
INSERT INTO `stu_course_flow` VALUES ('377', '81', '31', '1', '1', '9', '360', '', 'b9da8befe70c4c5e8c19727558682d7d', '2016-09-30 15:31:04');
INSERT INTO `stu_course_flow` VALUES ('378', '84', '31', '1', '1', '1', '60', '', '811a226d0b364ca88a02ee5186f5ff79', '2016-09-30 15:31:27');
INSERT INTO `stu_course_flow` VALUES ('379', '98', '31', '1', '1', '5', '200', '', '07fec23893f6486ea29db8d57c13fc7e', '2016-09-30 15:33:39');
INSERT INTO `stu_course_flow` VALUES ('380', '320', '18', '1', '1', '60', '5400', '中级\r\n', '5d3747d1a221446aa9b9af4c2003763e', '2016-10-06 20:50:50');
INSERT INTO `stu_course_flow` VALUES ('381', '321', '22', '1', '1', '18', '720', '', 'bc8b6ae0b7764c4ea610a6b79ecf8a27', '2016-10-06 20:54:08');
INSERT INTO `stu_course_flow` VALUES ('382', '321', '25', '1', '1', '13', '589', '', '04b9f9df3dea4860a232df90a149a27d', '2016-10-06 20:54:28');
INSERT INTO `stu_course_flow` VALUES ('383', '322', '25', '1', '1', '13', '589', '', '9db94433109b4f71ba55df7489ba1521', '2016-10-06 20:55:19');
INSERT INTO `stu_course_flow` VALUES ('384', '322', '22', '1', '1', '19', '760', '', 'e784e9ad3186479797ca1fc704bfae99', '2016-10-06 20:55:41');
INSERT INTO `stu_course_flow` VALUES ('385', '323', '22', '1', '1', '22', '880', '', '938a14b817d944e582fcd34b78583832', '2016-10-06 20:56:21');
INSERT INTO `stu_course_flow` VALUES ('386', '323', '25', '1', '1', '13', '589', '', 'a469664b2a034692b3cbb9de194d0f78', '2016-10-06 20:56:39');
INSERT INTO `stu_course_flow` VALUES ('387', '324', '22', '1', '1', '30', '1200', '', '06fe2610e8d248ebaa60a9dd7ad0103c', '2016-10-06 20:57:49');
INSERT INTO `stu_course_flow` VALUES ('388', '324', '25', '1', '1', '13', '589', '', '616ae0162f294e72ad58a9520658240e', '2016-10-06 20:58:04');
INSERT INTO `stu_course_flow` VALUES ('389', '325', '22', '1', '1', '10', '400', '', '988b8b0a27d64db8aeb96d1741f41c8b', '2016-10-06 20:59:06');
INSERT INTO `stu_course_flow` VALUES ('390', '325', '25', '1', '1', '13', '589', '', '7fe4656d24ae44089b9b291d84f2c58e', '2016-10-06 20:59:20');
INSERT INTO `stu_course_flow` VALUES ('391', '326', '25', '1', '1', '13', '589', '', '3ba6f7bcf3fd4ebcad5d2b49323fa3fb', '2016-10-06 21:00:18');
INSERT INTO `stu_course_flow` VALUES ('392', '327', '29', '1', '1', '12', '704', '', '44578095dd1a47078e619a46a7c5d58b', '2016-10-06 21:01:46');
INSERT INTO `stu_course_flow` VALUES ('393', '327', '16', '1', '1', '19', '1665', '', 'b1b1a7a7459a4ae798dcbf4ef2158afa', '2016-10-06 21:01:57');
INSERT INTO `stu_course_flow` VALUES ('394', '327', '31', '1', '1', '8', '320', '', 'dc290dd2846b46eebf6cac67cd2dd88d', '2016-10-06 21:02:16');
INSERT INTO `stu_course_flow` VALUES ('395', '328', '22', '1', '1', '9', '360', '', 'f9774929406b4c87983c645c4c4ab18e', '2016-10-06 21:03:14');
INSERT INTO `stu_course_flow` VALUES ('396', '328', '16', '1', '1', '12', '1176', '', 'e746941489ef4df99033f16ce100bac2', '2016-10-06 21:03:26');
INSERT INTO `stu_course_flow` VALUES ('397', '328', '30', '1', '1', '10', '580', '', 'fa2a3a6ae9e340c2ba5f8c20387ee6b4', '2016-10-06 21:03:57');
INSERT INTO `stu_course_flow` VALUES ('398', '329', '16', '1', '1', '19', '1664', '', '1e5db30b1ca9452285317117b24e75ae', '2016-10-06 21:05:12');
INSERT INTO `stu_course_flow` VALUES ('399', '329', '31', '1', '1', '4', '160', '', '486ef7130a7b4d5091844326763deaa2', '2016-10-06 21:05:26');
INSERT INTO `stu_course_flow` VALUES ('400', '329', '29', '1', '1', '12', '704', '', '0a703241a176442ca9757a2c281a93e4', '2016-10-06 21:05:52');
INSERT INTO `stu_course_flow` VALUES ('401', '329', '22', '1', '1', '9', '360', '', '03a49c7c4eab4ccea81d3e980b1750db', '2016-10-06 21:06:05');
INSERT INTO `stu_course_flow` VALUES ('402', '330', '28', '1', '1', '39', '3500', '', '13e62905cf53482d93345b8f9faa4e32', '2016-10-06 21:06:45');
INSERT INTO `stu_course_flow` VALUES ('403', '330', '18', '1', '1', '26', '2288', '', 'c2c2d4cc7024469d8eca2f382cfb4c5e', '2016-10-06 21:06:59');
INSERT INTO `stu_course_flow` VALUES ('404', '331', '16', '1', '1', '44', '4312', '', 'a9f5174e345a456aa8b1b860cdfa2ace', '2016-10-06 21:07:47');
INSERT INTO `stu_course_flow` VALUES ('405', '331', '28', '1', '1', '25', '2500', '', '72c961b5b5bf4f289297fef728d3200b', '2016-10-06 21:08:04');
INSERT INTO `stu_course_flow` VALUES ('406', '332', '16', '1', '1', '32', '2695', '', 'bafd83e299ac411bb681d0e41c4b46c3', '2016-10-06 21:09:47');
INSERT INTO `stu_course_flow` VALUES ('407', '333', '22', '1', '1', '13', '520', '', 'e266a4e1d2f247f3b65f1ea5d1c2271e', '2016-10-06 21:10:39');
INSERT INTO `stu_course_flow` VALUES ('408', '333', '16', '1', '1', '10', '980', '', '89100ce4184740379ae5edf4d190ee8f', '2016-10-06 21:10:50');
INSERT INTO `stu_course_flow` VALUES ('409', '334', '22', '1', '1', '21', '840', '', '82f75e8378d94fc48d01dd20c9228b7d', '2016-10-06 21:11:44');
INSERT INTO `stu_course_flow` VALUES ('410', '335', '16', '1', '1', '19', '1664', '', '486c84174da248f6ae04d20b381f96b5', '2016-10-06 21:12:28');
INSERT INTO `stu_course_flow` VALUES ('411', '335', '22', '1', '1', '17', '680', '', 'd002f73ea42c4bf3ba4a086bcdeaa0b4', '2016-10-06 21:12:40');
INSERT INTO `stu_course_flow` VALUES ('412', '336', '16', '1', '1', '12', '1176', '', '71fbbd7cac2a4099a9ed9c443c6b2334', '2016-10-06 21:13:35');
INSERT INTO `stu_course_flow` VALUES ('413', '337', '16', '1', '1', '57', '4815', '', 'fc21190b0f0a48a4a9112a6299780bf8', '2016-10-06 21:14:19');
INSERT INTO `stu_course_flow` VALUES ('414', '337', '22', '1', '1', '13', '520', '', '4abd284967fa4ccf926453bab3822b25', '2016-10-06 21:14:33');
INSERT INTO `stu_course_flow` VALUES ('415', '338', '16', '1', '1', '15', '1314', '', 'c782015b3fa14a25a665d2deb5d439cc', '2016-10-06 21:15:37');
INSERT INTO `stu_course_flow` VALUES ('416', '338', '22', '1', '1', '13', '520', '', 'a111e6d6fd9d48cb809280c0364823df', '2016-10-06 21:15:52');
INSERT INTO `stu_course_flow` VALUES ('417', '339', '16', '1', '1', '18', '1764', '', '21fa893ce9a04e0f88ae840c34e21ef4', '2016-10-06 21:18:30');
INSERT INTO `stu_course_flow` VALUES ('418', '339', '28', '1', '1', '6', '528', '', '8599577b00e349f3b8f9de42d95e1e66', '2016-10-06 21:18:46');
INSERT INTO `stu_course_flow` VALUES ('419', '339', '31', '1', '1', '8', '480', '', 'fa6129584ecf4e16814590cdfae7bf26', '2016-10-06 21:19:02');
INSERT INTO `stu_course_flow` VALUES ('420', '86', '16', '1', '1', '1080', '10', '', 'e0debad5a3b5474d925d99de0b7e44fe', '2016-10-10 15:54:21');
INSERT INTO `stu_course_flow` VALUES ('421', '277', '22', '1', '1', '15', '580', '', 'c49c38dd122745d6a753f8ba532703c6', '2016-10-10 17:00:57');
INSERT INTO `stu_course_flow` VALUES ('422', '340', '22', '1', '1', '15', '580', '', 'e9cb872167b94a7aad82fe91983e1547', '2016-10-10 21:02:05');
INSERT INTO `stu_course_flow` VALUES ('423', '341', '22', '1', '1', '15', '580', '', 'ef11d85a82294240831d84982d85760a', '2016-10-10 21:04:09');
INSERT INTO `stu_course_flow` VALUES ('424', '342', '29', '1', '1', '15', '880', '', '8b3a960990ab45bd9854c57da98737ea', '2016-10-10 21:04:54');
INSERT INTO `stu_course_flow` VALUES ('425', '343', '25', '1', '1', '15', '580', '', 'ebbb296643ab4e9d9610b42ee4cc71a4', '2016-10-10 21:05:56');
INSERT INTO `stu_course_flow` VALUES ('426', '344', '25', '1', '1', '15', '580', '', '226b95df2b7f4a21942f2d6d74d40279', '2016-10-10 21:08:24');
INSERT INTO `stu_course_flow` VALUES ('427', '35', '29', '1', '1', '15', '580', '', 'bb13ba4066aa442890bca7961f87bffd', '2016-10-10 21:08:53');
INSERT INTO `stu_course_flow` VALUES ('428', '346', '24', '1', '1', '10', '580', '', 'bcdaabff0bca4b509c667f3375b07fa3', '2016-10-10 21:10:06');
INSERT INTO `stu_course_flow` VALUES ('429', '347', '16', '1', '1', '12', '980', '', '7b9ea25252704ff4a72fb346b4d5f499', '2016-10-11 16:20:31');
INSERT INTO `stu_course_flow` VALUES ('430', '349', '22', '1', '1', '15', '580', '', '8cb3a390b6844b34aad086eea228ee1e', '2016-10-11 18:47:32');
INSERT INTO `stu_course_flow` VALUES ('431', '349', '25', '1', '1', '15', '580', '', '4e6b8422cc494008a9a6c58efbd641e5', '2016-10-11 18:47:54');
INSERT INTO `stu_course_flow` VALUES ('432', '349', '22', '1', '1', '15', '580', '', '7abffb12d0ea42f2a18fc3b1b16de524', '2016-10-11 18:48:50');
INSERT INTO `stu_course_flow` VALUES ('433', '350', '22', '1', '1', '15', '580', '', '6ebb838404054004bcebc6828111aa95', '2016-10-11 18:49:35');
INSERT INTO `stu_course_flow` VALUES ('434', '345', '22', '1', '1', '15', '580', '', '0af696d866a940e7a0e24f3381153d8f', '2016-10-11 19:09:59');
INSERT INTO `stu_course_flow` VALUES ('435', '348', '16', '1', '1', '39', '3416', '', '206bd455315546bf807c5a24b811390d', '2016-10-11 19:12:05');

-- ----------------------------
-- Table structure for stu_course_remain
-- ----------------------------
DROP TABLE IF EXISTS `stu_course_remain`;
CREATE TABLE `stu_course_remain` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `student_id` int(11) NOT NULL,
  `course_id` int(11) NOT NULL,
  `remain` int(10) NOT NULL COMMENT '剩余课程数',
  `already_study` int(10) NOT NULL COMMENT '已上课总数',
  `create_time` datetime NOT NULL,
  `update_time` datetime DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=323 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of stu_course_remain
-- ----------------------------
INSERT INTO `stu_course_remain` VALUES ('29', '28', '16', '1', '2', '2016-08-22 14:16:55', '2016-09-16 10:37:04');
INSERT INTO `stu_course_remain` VALUES ('30', '29', '16', '32', '0', '2016-09-16 10:13:08', null);
INSERT INTO `stu_course_remain` VALUES ('31', '30', '16', '3', '0', '2016-09-16 10:18:58', null);
INSERT INTO `stu_course_remain` VALUES ('32', '32', '16', '23', '0', '2016-09-16 10:41:49', null);
INSERT INTO `stu_course_remain` VALUES ('33', '33', '16', '17', '0', '2016-09-16 10:42:58', null);
INSERT INTO `stu_course_remain` VALUES ('34', '34', '16', '56', '0', '2016-09-16 10:44:53', '2016-09-30 09:51:10');
INSERT INTO `stu_course_remain` VALUES ('35', '35', '16', '43', '0', '2016-09-16 10:46:35', null);
INSERT INTO `stu_course_remain` VALUES ('36', '36', '16', '45', '0', '2016-09-16 10:52:30', null);
INSERT INTO `stu_course_remain` VALUES ('37', '37', '16', '4', '0', '2016-09-16 11:12:19', null);
INSERT INTO `stu_course_remain` VALUES ('38', '38', '16', '27', '0', '2016-09-16 11:18:36', null);
INSERT INTO `stu_course_remain` VALUES ('39', '39', '16', '25', '0', '2016-09-16 11:27:54', null);
INSERT INTO `stu_course_remain` VALUES ('40', '40', '16', '2', '0', '2016-09-16 11:39:24', null);
INSERT INTO `stu_course_remain` VALUES ('41', '42', '16', '33', '0', '2016-09-16 11:46:41', null);
INSERT INTO `stu_course_remain` VALUES ('42', '43', '16', '28', '0', '2016-09-16 11:48:44', null);
INSERT INTO `stu_course_remain` VALUES ('43', '44', '16', '5', '0', '2016-09-16 11:49:31', null);
INSERT INTO `stu_course_remain` VALUES ('44', '45', '16', '30', '0', '2016-09-16 11:53:37', null);
INSERT INTO `stu_course_remain` VALUES ('45', '46', '16', '12', '0', '2016-09-16 11:54:22', null);
INSERT INTO `stu_course_remain` VALUES ('46', '47', '16', '29', '0', '2016-09-16 11:56:45', null);
INSERT INTO `stu_course_remain` VALUES ('47', '48', '16', '10', '0', '2016-09-16 11:57:50', null);
INSERT INTO `stu_course_remain` VALUES ('48', '50', '16', '6', '0', '2016-09-16 12:01:46', null);
INSERT INTO `stu_course_remain` VALUES ('49', '51', '16', '8', '0', '2016-09-16 12:05:01', null);
INSERT INTO `stu_course_remain` VALUES ('50', '52', '16', '3', '0', '2016-09-16 12:05:43', null);
INSERT INTO `stu_course_remain` VALUES ('51', '53', '16', '25', '0', '2016-09-16 12:06:30', null);
INSERT INTO `stu_course_remain` VALUES ('52', '54', '16', '3', '0', '2016-09-16 12:07:56', null);
INSERT INTO `stu_course_remain` VALUES ('53', '55', '16', '3', '0', '2016-09-16 12:09:16', null);
INSERT INTO `stu_course_remain` VALUES ('54', '57', '16', '2', '0', '2016-09-16 12:11:46', null);
INSERT INTO `stu_course_remain` VALUES ('56', '56', '24', '15', '2', '2016-09-17 16:32:11', '2016-09-29 10:09:49');
INSERT INTO `stu_course_remain` VALUES ('57', '60', '16', '9', '0', '2016-09-28 11:00:24', null);
INSERT INTO `stu_course_remain` VALUES ('58', '61', '16', '10', '0', '2016-09-28 11:12:24', null);
INSERT INTO `stu_course_remain` VALUES ('60', '63', '16', '0', '0', '2016-09-28 11:17:07', null);
INSERT INTO `stu_course_remain` VALUES ('62', '65', '16', '1', '0', '2016-09-28 11:23:53', null);
INSERT INTO `stu_course_remain` VALUES ('63', '66', '16', '1', '0', '2016-09-28 11:25:33', null);
INSERT INTO `stu_course_remain` VALUES ('65', '68', '16', '8', '0', '2016-09-28 11:47:03', null);
INSERT INTO `stu_course_remain` VALUES ('66', '69', '16', '10', '0', '2016-09-28 12:39:11', null);
INSERT INTO `stu_course_remain` VALUES ('67', '70', '16', '9', '0', '2016-09-28 12:40:43', null);
INSERT INTO `stu_course_remain` VALUES ('68', '71', '16', '14', '0', '2016-09-28 12:42:59', null);
INSERT INTO `stu_course_remain` VALUES ('69', '72', '16', '21', '0', '2016-09-28 12:44:57', null);
INSERT INTO `stu_course_remain` VALUES ('70', '73', '16', '11', '0', '2016-09-28 12:48:06', null);
INSERT INTO `stu_course_remain` VALUES ('71', '77', '16', '28', '0', '2016-09-28 13:00:01', null);
INSERT INTO `stu_course_remain` VALUES ('72', '78', '16', '56', '0', '2016-09-28 13:02:49', '2016-09-30 09:46:56');
INSERT INTO `stu_course_remain` VALUES ('73', '79', '16', '57', '0', '2016-09-28 13:05:16', null);
INSERT INTO `stu_course_remain` VALUES ('74', '81', '16', '12', '0', '2016-09-28 13:10:59', null);
INSERT INTO `stu_course_remain` VALUES ('75', '82', '16', '21', '0', '2016-09-28 13:13:02', null);
INSERT INTO `stu_course_remain` VALUES ('76', '84', '16', '23', '0', '2016-09-28 13:15:11', null);
INSERT INTO `stu_course_remain` VALUES ('77', '87', '16', '9', '0', '2016-09-28 13:22:17', null);
INSERT INTO `stu_course_remain` VALUES ('79', '90', '16', '38', '0', '2016-09-28 13:27:36', null);
INSERT INTO `stu_course_remain` VALUES ('80', '91', '16', '1', '0', '2016-09-28 13:28:41', null);
INSERT INTO `stu_course_remain` VALUES ('81', '92', '16', '18', '0', '2016-09-28 13:30:36', null);
INSERT INTO `stu_course_remain` VALUES ('82', '94', '16', '14', '0', '2016-09-28 13:33:19', '2016-09-28 13:34:35');
INSERT INTO `stu_course_remain` VALUES ('83', '95', '16', '46', '0', '2016-09-28 13:37:19', null);
INSERT INTO `stu_course_remain` VALUES ('85', '97', '16', '18', '0', '2016-09-28 13:41:24', null);
INSERT INTO `stu_course_remain` VALUES ('86', '98', '16', '3', '0', '2016-09-28 13:42:34', null);
INSERT INTO `stu_course_remain` VALUES ('88', '100', '16', '18', '0', '2016-09-28 13:50:11', '2016-09-28 13:50:36');
INSERT INTO `stu_course_remain` VALUES ('90', '102', '16', '13', '0', '2016-09-28 13:55:30', null);
INSERT INTO `stu_course_remain` VALUES ('91', '104', '16', '1', '0', '2016-09-28 13:57:45', null);
INSERT INTO `stu_course_remain` VALUES ('92', '105', '16', '23', '0', '2016-09-28 14:11:16', '2016-09-28 14:11:56');
INSERT INTO `stu_course_remain` VALUES ('93', '106', '16', '31', '0', '2016-09-28 14:15:48', null);
INSERT INTO `stu_course_remain` VALUES ('94', '107', '16', '18', '0', '2016-09-28 14:17:57', '2016-09-28 14:18:23');
INSERT INTO `stu_course_remain` VALUES ('95', '108', '16', '41', '0', '2016-09-28 14:20:18', null);
INSERT INTO `stu_course_remain` VALUES ('96', '109', '16', '1', '0', '2016-09-28 14:28:14', null);
INSERT INTO `stu_course_remain` VALUES ('97', '110', '16', '1', '0', '2016-09-28 14:29:07', null);
INSERT INTO `stu_course_remain` VALUES ('99', '112', '16', '37', '0', '2016-09-28 14:35:14', null);
INSERT INTO `stu_course_remain` VALUES ('101', '115', '16', '1', '0', '2016-09-28 14:43:02', null);
INSERT INTO `stu_course_remain` VALUES ('102', '116', '16', '5', '0', '2016-09-28 14:45:10', null);
INSERT INTO `stu_course_remain` VALUES ('103', '117', '16', '27', '0', '2016-09-28 14:46:17', null);
INSERT INTO `stu_course_remain` VALUES ('104', '118', '16', '26', '0', '2016-09-28 14:52:20', null);
INSERT INTO `stu_course_remain` VALUES ('106', '120', '16', '6', '0', '2016-09-28 14:56:36', null);
INSERT INTO `stu_course_remain` VALUES ('108', '121', '16', '2', '0', '2016-09-28 14:59:38', null);
INSERT INTO `stu_course_remain` VALUES ('109', '122', '16', '36', '0', '2016-09-28 15:05:52', null);
INSERT INTO `stu_course_remain` VALUES ('110', '124', '16', '37', '0', '2016-09-28 15:10:30', null);
INSERT INTO `stu_course_remain` VALUES ('111', '127', '16', '10', '0', '2016-09-28 15:16:35', null);
INSERT INTO `stu_course_remain` VALUES ('112', '128', '16', '5', '0', '2016-09-28 15:17:57', null);
INSERT INTO `stu_course_remain` VALUES ('113', '129', '16', '4', '0', '2016-09-28 15:19:43', null);
INSERT INTO `stu_course_remain` VALUES ('114', '131', '16', '8', '0', '2016-09-28 15:24:35', null);
INSERT INTO `stu_course_remain` VALUES ('115', '130', '16', '9', '0', '2016-09-28 15:24:54', null);
INSERT INTO `stu_course_remain` VALUES ('116', '132', '16', '9', '0', '2016-09-28 15:25:57', null);
INSERT INTO `stu_course_remain` VALUES ('117', '133', '18', '31', '0', '2016-09-28 15:57:19', null);
INSERT INTO `stu_course_remain` VALUES ('118', '134', '18', '19', '0', '2016-09-28 20:17:23', null);
INSERT INTO `stu_course_remain` VALUES ('119', '135', '18', '35', '0', '2016-09-28 20:18:59', null);
INSERT INTO `stu_course_remain` VALUES ('120', '136', '18', '2', '0', '2016-09-28 20:23:04', null);
INSERT INTO `stu_course_remain` VALUES ('121', '137', '16', '18', '0', '2016-09-28 20:27:27', null);
INSERT INTO `stu_course_remain` VALUES ('122', '138', '20', '4', '0', '2016-09-28 20:28:59', null);
INSERT INTO `stu_course_remain` VALUES ('123', '139', '20', '3', '0', '2016-09-28 20:31:33', null);
INSERT INTO `stu_course_remain` VALUES ('124', '140', '20', '2', '0', '2016-09-28 20:33:05', null);
INSERT INTO `stu_course_remain` VALUES ('125', '141', '20', '35', '0', '2016-09-28 20:38:01', null);
INSERT INTO `stu_course_remain` VALUES ('126', '142', '20', '8', '0', '2016-09-28 20:39:42', null);
INSERT INTO `stu_course_remain` VALUES ('127', '143', '16', '8', '0', '2016-09-28 20:40:55', null);
INSERT INTO `stu_course_remain` VALUES ('128', '143', '20', '5', '0', '2016-09-28 20:41:46', null);
INSERT INTO `stu_course_remain` VALUES ('129', '145', '20', '55', '0', '2016-09-28 20:44:36', null);
INSERT INTO `stu_course_remain` VALUES ('130', '144', '20', '12', '0', '2016-09-28 20:48:08', null);
INSERT INTO `stu_course_remain` VALUES ('131', '146', '20', '24', '0', '2016-09-28 20:48:51', null);
INSERT INTO `stu_course_remain` VALUES ('132', '147', '20', '47', '0', '2016-09-28 20:50:06', null);
INSERT INTO `stu_course_remain` VALUES ('133', '148', '20', '43', '0', '2016-09-28 20:52:41', null);
INSERT INTO `stu_course_remain` VALUES ('134', '149', '20', '8', '0', '2016-09-28 20:54:18', null);
INSERT INTO `stu_course_remain` VALUES ('135', '150', '20', '5', '0', '2016-09-28 20:56:51', null);
INSERT INTO `stu_course_remain` VALUES ('136', '151', '16', '20', '0', '2016-09-28 20:58:14', null);
INSERT INTO `stu_course_remain` VALUES ('137', '152', '20', '7', '0', '2016-09-28 21:06:00', null);
INSERT INTO `stu_course_remain` VALUES ('138', '153', '20', '7', '0', '2016-09-28 21:07:14', null);
INSERT INTO `stu_course_remain` VALUES ('139', '154', '20', '4', '0', '2016-09-28 21:08:40', null);
INSERT INTO `stu_course_remain` VALUES ('140', '155', '20', '8', '0', '2016-09-28 21:10:00', null);
INSERT INTO `stu_course_remain` VALUES ('141', '156', '20', '9', '0', '2016-09-28 21:11:05', null);
INSERT INTO `stu_course_remain` VALUES ('142', '157', '20', '9', '0', '2016-09-28 21:12:11', null);
INSERT INTO `stu_course_remain` VALUES ('145', '183', '18', '9', '0', '2016-09-29 08:51:39', null);
INSERT INTO `stu_course_remain` VALUES ('146', '184', '18', '9', '0', '2016-09-29 08:52:24', null);
INSERT INTO `stu_course_remain` VALUES ('147', '185', '18', '8', '0', '2016-09-29 08:53:48', null);
INSERT INTO `stu_course_remain` VALUES ('148', '186', '18', '8', '0', '2016-09-29 08:54:41', null);
INSERT INTO `stu_course_remain` VALUES ('149', '187', '18', '7', '0', '2016-09-29 08:56:19', null);
INSERT INTO `stu_course_remain` VALUES ('150', '188', '18', '7', '0', '2016-09-29 08:57:13', null);
INSERT INTO `stu_course_remain` VALUES ('151', '190', '18', '8', '0', '2016-09-29 08:58:42', null);
INSERT INTO `stu_course_remain` VALUES ('152', '191', '18', '7', '0', '2016-09-29 08:59:53', null);
INSERT INTO `stu_course_remain` VALUES ('153', '192', '18', '8', '0', '2016-09-29 09:00:52', null);
INSERT INTO `stu_course_remain` VALUES ('154', '193', '18', '6', '0', '2016-09-29 09:01:51', null);
INSERT INTO `stu_course_remain` VALUES ('155', '194', '18', '5', '0', '2016-09-29 09:02:39', null);
INSERT INTO `stu_course_remain` VALUES ('156', '195', '18', '5', '0', '2016-09-29 09:06:32', null);
INSERT INTO `stu_course_remain` VALUES ('157', '196', '18', '4', '0', '2016-09-29 09:07:25', null);
INSERT INTO `stu_course_remain` VALUES ('158', '197', '18', '7', '0', '2016-09-29 09:09:57', null);
INSERT INTO `stu_course_remain` VALUES ('160', '199', '18', '8', '0', '2016-09-29 09:13:05', null);
INSERT INTO `stu_course_remain` VALUES ('162', '201', '18', '3', '0', '2016-09-29 09:16:25', null);
INSERT INTO `stu_course_remain` VALUES ('163', '203', '18', '10', '0', '2016-09-29 09:18:14', null);
INSERT INTO `stu_course_remain` VALUES ('164', '204', '18', '1', '0', '2016-09-29 09:20:04', null);
INSERT INTO `stu_course_remain` VALUES ('165', '205', '18', '5', '0', '2016-09-29 09:21:27', null);
INSERT INTO `stu_course_remain` VALUES ('166', '206', '18', '38', '0', '2016-09-29 09:22:55', null);
INSERT INTO `stu_course_remain` VALUES ('167', '202', '18', '8', '0', '2016-09-29 09:23:25', null);
INSERT INTO `stu_course_remain` VALUES ('168', '207', '18', '3', '0', '2016-09-29 09:26:55', null);
INSERT INTO `stu_course_remain` VALUES ('169', '209', '18', '4', '0', '2016-09-29 09:31:29', null);
INSERT INTO `stu_course_remain` VALUES ('170', '211', '18', '5', '0', '2016-09-29 09:34:31', null);
INSERT INTO `stu_course_remain` VALUES ('171', '212', '18', '4', '0', '2016-09-29 09:38:50', null);
INSERT INTO `stu_course_remain` VALUES ('172', '214', '18', '6', '0', '2016-09-29 09:42:20', null);
INSERT INTO `stu_course_remain` VALUES ('173', '218', '18', '5', '0', '2016-09-29 09:46:32', null);
INSERT INTO `stu_course_remain` VALUES ('174', '219', '18', '9', '0', '2016-09-29 09:47:35', null);
INSERT INTO `stu_course_remain` VALUES ('175', '220', '18', '7', '0', '2016-09-29 09:49:20', null);
INSERT INTO `stu_course_remain` VALUES ('176', '221', '18', '1', '0', '2016-09-29 09:51:08', null);
INSERT INTO `stu_course_remain` VALUES ('177', '222', '18', '3', '0', '2016-09-29 09:52:27', null);
INSERT INTO `stu_course_remain` VALUES ('179', '224', '18', '7', '0', '2016-09-29 09:56:02', null);
INSERT INTO `stu_course_remain` VALUES ('181', '181', '24', '10', '0', '2016-09-29 10:07:45', null);
INSERT INTO `stu_course_remain` VALUES ('182', '234', '24', '5', '0', '2016-09-29 10:11:08', null);
INSERT INTO `stu_course_remain` VALUES ('183', '235', '24', '26', '0', '2016-09-29 10:12:17', null);
INSERT INTO `stu_course_remain` VALUES ('184', '236', '24', '3', '0', '2016-09-29 10:13:53', null);
INSERT INTO `stu_course_remain` VALUES ('185', '237', '24', '5', '0', '2016-09-29 10:14:45', null);
INSERT INTO `stu_course_remain` VALUES ('186', '238', '24', '3', '0', '2016-09-29 10:15:51', null);
INSERT INTO `stu_course_remain` VALUES ('187', '239', '24', '30', '0', '2016-09-29 10:16:53', null);
INSERT INTO `stu_course_remain` VALUES ('188', '240', '24', '30', '0', '2016-09-29 10:17:57', null);
INSERT INTO `stu_course_remain` VALUES ('189', '242', '24', '29', '0', '2016-09-29 10:21:26', null);
INSERT INTO `stu_course_remain` VALUES ('190', '243', '24', '2', '0', '2016-09-29 10:22:32', null);
INSERT INTO `stu_course_remain` VALUES ('193', '255', '22', '11', '0', '2016-09-29 11:01:49', null);
INSERT INTO `stu_course_remain` VALUES ('194', '256', '22', '1', '0', '2016-09-29 11:02:58', null);
INSERT INTO `stu_course_remain` VALUES ('195', '257', '22', '8', '0', '2016-09-29 11:04:10', null);
INSERT INTO `stu_course_remain` VALUES ('197', '262', '22', '10', '0', '2016-09-29 11:07:48', null);
INSERT INTO `stu_course_remain` VALUES ('200', '266', '22', '4', '0', '2016-09-29 11:54:18', null);
INSERT INTO `stu_course_remain` VALUES ('201', '267', '22', '2', '0', '2016-09-29 11:55:48', null);
INSERT INTO `stu_course_remain` VALUES ('202', '268', '22', '4', '0', '2016-09-29 12:00:18', null);
INSERT INTO `stu_course_remain` VALUES ('203', '269', '22', '2', '0', '2016-09-29 12:02:54', null);
INSERT INTO `stu_course_remain` VALUES ('204', '270', '22', '5', '0', '2016-09-29 12:03:37', null);
INSERT INTO `stu_course_remain` VALUES ('206', '273', '22', '2', '0', '2016-09-29 12:27:05', null);
INSERT INTO `stu_course_remain` VALUES ('207', '274', '22', '9', '0', '2016-09-29 12:27:49', null);
INSERT INTO `stu_course_remain` VALUES ('209', '276', '22', '27', '0', '2016-09-29 12:42:47', '2016-09-30 08:59:06');
INSERT INTO `stu_course_remain` VALUES ('210', '277', '22', '17', '0', '2016-09-29 12:43:34', '2016-10-10 17:00:57');
INSERT INTO `stu_course_remain` VALUES ('211', '278', '22', '17', '0', '2016-09-29 12:44:28', null);
INSERT INTO `stu_course_remain` VALUES ('213', '280', '22', '6', '0', '2016-09-29 12:52:04', null);
INSERT INTO `stu_course_remain` VALUES ('218', '288', '22', '3', '0', '2016-09-29 13:02:25', null);
INSERT INTO `stu_course_remain` VALUES ('219', '289', '22', '12', '0', '2016-09-29 13:03:15', null);
INSERT INTO `stu_course_remain` VALUES ('221', '296', '28', '1', '0', '2016-09-29 13:13:57', null);
INSERT INTO `stu_course_remain` VALUES ('226', '301', '16', '55', '0', '2016-09-30 08:47:06', null);
INSERT INTO `stu_course_remain` VALUES ('228', '48', '23', '15', '0', '2016-09-30 09:26:26', null);
INSERT INTO `stu_course_remain` VALUES ('230', '303', '20', '8', '0', '2016-09-30 09:50:32', null);
INSERT INTO `stu_course_remain` VALUES ('231', '158', '25', '13', '0', '2016-09-30 10:38:42', null);
INSERT INTO `stu_course_remain` VALUES ('232', '159', '25', '13', '0', '2016-09-30 10:39:16', null);
INSERT INTO `stu_course_remain` VALUES ('233', '160', '25', '13', '0', '2016-09-30 10:39:45', null);
INSERT INTO `stu_course_remain` VALUES ('234', '161', '25', '13', '0', '2016-09-30 10:40:15', null);
INSERT INTO `stu_course_remain` VALUES ('235', '167', '25', '13', '0', '2016-09-30 10:41:52', null);
INSERT INTO `stu_course_remain` VALUES ('236', '168', '25', '13', '0', '2016-09-30 10:42:24', null);
INSERT INTO `stu_course_remain` VALUES ('237', '169', '25', '13', '0', '2016-09-30 10:43:12', null);
INSERT INTO `stu_course_remain` VALUES ('238', '165', '25', '13', '0', '2016-09-30 10:45:45', null);
INSERT INTO `stu_course_remain` VALUES ('240', '171', '25', '13', '0', '2016-09-30 10:46:50', null);
INSERT INTO `stu_course_remain` VALUES ('241', '145', '25', '13', '0', '2016-09-30 10:47:49', null);
INSERT INTO `stu_course_remain` VALUES ('242', '174', '25', '13', '0', '2016-09-30 10:49:07', null);
INSERT INTO `stu_course_remain` VALUES ('243', '175', '25', '13', '0', '2016-09-30 10:49:37', null);
INSERT INTO `stu_course_remain` VALUES ('244', '176', '25', '13', '0', '2016-09-30 10:50:01', null);
INSERT INTO `stu_course_remain` VALUES ('245', '118', '25', '13', '0', '2016-09-30 10:50:38', null);
INSERT INTO `stu_course_remain` VALUES ('246', '123', '25', '13', '0', '2016-09-30 10:51:14', null);
INSERT INTO `stu_course_remain` VALUES ('247', '179', '25', '13', '0', '2016-09-30 10:51:40', null);
INSERT INTO `stu_course_remain` VALUES ('248', '277', '25', '13', '0', '2016-09-30 10:52:52', null);
INSERT INTO `stu_course_remain` VALUES ('249', '304', '25', '13', '0', '2016-09-30 10:53:55', null);
INSERT INTO `stu_course_remain` VALUES ('250', '87', '25', '13', '0', '2016-09-30 10:55:03', null);
INSERT INTO `stu_course_remain` VALUES ('251', '177', '25', '13', '0', '2016-09-30 10:55:29', null);
INSERT INTO `stu_course_remain` VALUES ('252', '53', '25', '13', '0', '2016-09-30 10:56:43', null);
INSERT INTO `stu_course_remain` VALUES ('253', '115', '26', '13', '0', '2016-09-30 10:58:06', null);
INSERT INTO `stu_course_remain` VALUES ('254', '180', '26', '13', '0', '2016-09-30 10:58:32', null);
INSERT INTO `stu_course_remain` VALUES ('255', '81', '26', '13', '0', '2016-09-30 10:58:56', null);
INSERT INTO `stu_course_remain` VALUES ('256', '181', '26', '13', '0', '2016-09-30 10:59:26', null);
INSERT INTO `stu_course_remain` VALUES ('257', '316', '22', '14', '0', '2016-09-30 14:07:02', null);
INSERT INTO `stu_course_remain` VALUES ('258', '317', '22', '6', '0', '2016-09-30 14:09:29', null);
INSERT INTO `stu_course_remain` VALUES ('259', '293', '16', '11', '0', '2016-09-30 14:12:02', null);
INSERT INTO `stu_course_remain` VALUES ('260', '279', '22', '20', '0', '2016-09-30 14:17:26', null);
INSERT INTO `stu_course_remain` VALUES ('261', '291', '22', '11', '0', '2016-09-30 14:18:58', null);
INSERT INTO `stu_course_remain` VALUES ('262', '318', '22', '31', '0', '2016-09-30 14:37:24', null);
INSERT INTO `stu_course_remain` VALUES ('263', '294', '22', '7', '0', '2016-09-30 14:41:18', null);
INSERT INTO `stu_course_remain` VALUES ('264', '91', '31', '2', '0', '2016-09-30 15:27:22', null);
INSERT INTO `stu_course_remain` VALUES ('265', '95', '31', '7', '0', '2016-09-30 15:29:37', null);
INSERT INTO `stu_course_remain` VALUES ('266', '81', '31', '9', '0', '2016-09-30 15:31:04', null);
INSERT INTO `stu_course_remain` VALUES ('267', '84', '31', '1', '0', '2016-09-30 15:31:27', null);
INSERT INTO `stu_course_remain` VALUES ('268', '98', '31', '5', '0', '2016-09-30 15:33:39', null);
INSERT INTO `stu_course_remain` VALUES ('269', '320', '18', '60', '0', '2016-10-06 20:50:50', null);
INSERT INTO `stu_course_remain` VALUES ('270', '321', '22', '18', '0', '2016-10-06 20:54:08', null);
INSERT INTO `stu_course_remain` VALUES ('271', '321', '25', '13', '0', '2016-10-06 20:54:28', null);
INSERT INTO `stu_course_remain` VALUES ('272', '322', '25', '13', '0', '2016-10-06 20:55:19', null);
INSERT INTO `stu_course_remain` VALUES ('273', '322', '22', '19', '0', '2016-10-06 20:55:41', null);
INSERT INTO `stu_course_remain` VALUES ('274', '323', '22', '22', '0', '2016-10-06 20:56:21', null);
INSERT INTO `stu_course_remain` VALUES ('275', '323', '25', '13', '0', '2016-10-06 20:56:39', null);
INSERT INTO `stu_course_remain` VALUES ('276', '324', '22', '30', '0', '2016-10-06 20:57:49', null);
INSERT INTO `stu_course_remain` VALUES ('277', '324', '25', '13', '0', '2016-10-06 20:58:04', null);
INSERT INTO `stu_course_remain` VALUES ('278', '325', '22', '10', '0', '2016-10-06 20:59:06', null);
INSERT INTO `stu_course_remain` VALUES ('279', '325', '25', '13', '0', '2016-10-06 20:59:20', null);
INSERT INTO `stu_course_remain` VALUES ('280', '326', '25', '13', '0', '2016-10-06 21:00:18', null);
INSERT INTO `stu_course_remain` VALUES ('281', '327', '29', '12', '0', '2016-10-06 21:01:46', null);
INSERT INTO `stu_course_remain` VALUES ('282', '327', '16', '19', '0', '2016-10-06 21:01:57', null);
INSERT INTO `stu_course_remain` VALUES ('283', '327', '31', '8', '0', '2016-10-06 21:02:16', null);
INSERT INTO `stu_course_remain` VALUES ('284', '328', '22', '9', '0', '2016-10-06 21:03:14', null);
INSERT INTO `stu_course_remain` VALUES ('285', '328', '16', '12', '0', '2016-10-06 21:03:26', null);
INSERT INTO `stu_course_remain` VALUES ('286', '328', '30', '10', '0', '2016-10-06 21:03:57', null);
INSERT INTO `stu_course_remain` VALUES ('287', '329', '16', '19', '0', '2016-10-06 21:05:12', null);
INSERT INTO `stu_course_remain` VALUES ('288', '329', '31', '4', '0', '2016-10-06 21:05:26', null);
INSERT INTO `stu_course_remain` VALUES ('289', '329', '29', '12', '0', '2016-10-06 21:05:52', null);
INSERT INTO `stu_course_remain` VALUES ('290', '329', '22', '9', '0', '2016-10-06 21:06:05', null);
INSERT INTO `stu_course_remain` VALUES ('291', '330', '28', '39', '0', '2016-10-06 21:06:45', null);
INSERT INTO `stu_course_remain` VALUES ('292', '330', '18', '26', '0', '2016-10-06 21:06:59', null);
INSERT INTO `stu_course_remain` VALUES ('293', '331', '16', '44', '0', '2016-10-06 21:07:47', null);
INSERT INTO `stu_course_remain` VALUES ('294', '331', '28', '25', '0', '2016-10-06 21:08:04', null);
INSERT INTO `stu_course_remain` VALUES ('295', '332', '16', '32', '0', '2016-10-06 21:09:47', null);
INSERT INTO `stu_course_remain` VALUES ('296', '333', '22', '13', '0', '2016-10-06 21:10:39', null);
INSERT INTO `stu_course_remain` VALUES ('297', '333', '16', '10', '0', '2016-10-06 21:10:50', null);
INSERT INTO `stu_course_remain` VALUES ('298', '334', '22', '21', '0', '2016-10-06 21:11:44', null);
INSERT INTO `stu_course_remain` VALUES ('299', '335', '16', '19', '0', '2016-10-06 21:12:28', null);
INSERT INTO `stu_course_remain` VALUES ('300', '335', '22', '17', '0', '2016-10-06 21:12:40', null);
INSERT INTO `stu_course_remain` VALUES ('301', '336', '16', '12', '0', '2016-10-06 21:13:35', null);
INSERT INTO `stu_course_remain` VALUES ('302', '337', '16', '57', '0', '2016-10-06 21:14:19', null);
INSERT INTO `stu_course_remain` VALUES ('303', '337', '22', '13', '0', '2016-10-06 21:14:33', null);
INSERT INTO `stu_course_remain` VALUES ('304', '338', '16', '15', '0', '2016-10-06 21:15:37', null);
INSERT INTO `stu_course_remain` VALUES ('305', '338', '22', '13', '0', '2016-10-06 21:15:52', null);
INSERT INTO `stu_course_remain` VALUES ('306', '339', '16', '18', '0', '2016-10-06 21:18:30', null);
INSERT INTO `stu_course_remain` VALUES ('307', '339', '28', '6', '0', '2016-10-06 21:18:46', null);
INSERT INTO `stu_course_remain` VALUES ('308', '339', '31', '8', '0', '2016-10-06 21:19:02', null);
INSERT INTO `stu_course_remain` VALUES ('309', '86', '16', '1080', '0', '2016-10-10 15:54:21', null);
INSERT INTO `stu_course_remain` VALUES ('310', '340', '22', '15', '0', '2016-10-10 21:02:05', null);
INSERT INTO `stu_course_remain` VALUES ('311', '341', '22', '15', '0', '2016-10-10 21:04:09', null);
INSERT INTO `stu_course_remain` VALUES ('312', '342', '29', '15', '0', '2016-10-10 21:04:54', null);
INSERT INTO `stu_course_remain` VALUES ('313', '343', '25', '15', '0', '2016-10-10 21:05:56', null);
INSERT INTO `stu_course_remain` VALUES ('314', '344', '25', '15', '0', '2016-10-10 21:08:24', null);
INSERT INTO `stu_course_remain` VALUES ('315', '35', '29', '15', '0', '2016-10-10 21:08:53', null);
INSERT INTO `stu_course_remain` VALUES ('316', '346', '24', '10', '0', '2016-10-10 21:10:06', null);
INSERT INTO `stu_course_remain` VALUES ('317', '347', '16', '12', '0', '2016-10-11 16:20:31', null);
INSERT INTO `stu_course_remain` VALUES ('318', '349', '22', '30', '0', '2016-10-11 18:47:32', '2016-10-11 18:48:50');
INSERT INTO `stu_course_remain` VALUES ('319', '349', '25', '15', '0', '2016-10-11 18:47:54', null);
INSERT INTO `stu_course_remain` VALUES ('320', '350', '22', '15', '0', '2016-10-11 18:49:35', null);
INSERT INTO `stu_course_remain` VALUES ('321', '345', '22', '15', '0', '2016-10-11 19:09:59', null);
INSERT INTO `stu_course_remain` VALUES ('322', '348', '16', '39', '0', '2016-10-11 19:12:05', null);

-- ----------------------------
-- Table structure for student
-- ----------------------------
DROP TABLE IF EXISTS `student`;
CREATE TABLE `student` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(20) NOT NULL,
  `phone` varchar(20) NOT NULL,
  `contact_name` varchar(20) NOT NULL,
  `total_fee` int(10) NOT NULL COMMENT '总充值费用',
  `stus` int(1) DEFAULT NULL COMMENT '0:删除 1:正常',
  `birthday` date DEFAULT NULL,
  `school` varchar(30) DEFAULT NULL COMMENT '所属学校',
  `remark` varchar(255) DEFAULT NULL,
  `open_id` varchar(50) DEFAULT NULL,
  `create_time` datetime NOT NULL,
  `update_time` datetime DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `name` (`name`)
) ENGINE=InnoDB AUTO_INCREMENT=351 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of student
-- ----------------------------
INSERT INTO `student` VALUES ('28', '樊画奇', '18962527004', '妈妈', '294', '1', null, '待定', '暑期在苏州过渡', null, '2016-08-22 14:14:56', '2016-08-22 14:16:13');
INSERT INTO `student` VALUES ('29', '袁梦婷', '18605128599', '妈妈', '2628', '1', null, '待定', '', null, '2016-09-16 10:12:04', null);
INSERT INTO `student` VALUES ('30', '王梦涵', '18913189669', '家长', '294', '1', null, '待定', '', null, '2016-09-16 10:18:27', null);
INSERT INTO `student` VALUES ('31', '薛苏艺', '13656224738', '家长', '0', '1', null, '待定', '', null, '2016-09-16 10:22:38', null);
INSERT INTO `student` VALUES ('32', '梅千汇', '13861304526', '妈妈', '2015', '1', null, '待定', '', null, '2016-09-16 10:41:15', null);
INSERT INTO `student` VALUES ('33', '周若娴', '13776082045', '家长', '1666', '1', null, '待定', '', null, '2016-09-16 10:42:31', null);
INSERT INTO `student` VALUES ('34', '邓奕岑', '15962118630', '家长', '4998', '1', null, '待定', '', null, '2016-09-16 10:44:39', null);
INSERT INTO `student` VALUES ('35', '苏津禾', '18014008362', '妈妈', '4172', '1', null, '待定', '', null, '2016-09-16 10:45:56', null);
INSERT INTO `student` VALUES ('36', '朱奕函', '18662436360', '妈妈', '3767', '1', null, '待定', '', null, '2016-09-16 10:51:50', '2016-09-16 11:11:02');
INSERT INTO `student` VALUES ('37', '蒋睿涵', '18914000693', '妈妈', '392', '1', null, '平江新城小学', '', null, '2016-09-16 11:12:00', null);
INSERT INTO `student` VALUES ('38', '储曹珏', '13912774907', '妈妈', '2366', '1', null, '待定', '', null, '2016-09-16 11:18:10', null);
INSERT INTO `student` VALUES ('39', '金语菲', '13814891080', '妈妈', '2190', '1', null, '待定', '', null, '2016-09-16 11:19:46', null);
INSERT INTO `student` VALUES ('40', '金子渲', '15850234982', '家长', '196', '1', null, '待定', '', null, '2016-09-16 11:39:08', null);
INSERT INTO `student` VALUES ('41', '何鑫睿', '18962169695', '家长', '0', '1', null, '待定', '', null, '2016-09-16 11:44:16', null);
INSERT INTO `student` VALUES ('42', '叶子峰', '18915529205', '妈妈', '2891', '1', null, '相城实验小学', '', null, '2016-09-16 11:46:18', null);
INSERT INTO `student` VALUES ('43', '李亦烁', '13862099075', '家长', '2453', '1', null, '待定', '', null, '2016-09-16 11:47:59', null);
INSERT INTO `student` VALUES ('44', '胡裔博', '13913564882', '家长', '490', '1', null, '待定', '', null, '2016-09-16 11:49:10', null);
INSERT INTO `student` VALUES ('45', '查雨薇', '13814894865', '家长', '2628', '1', null, '待定', '', null, '2016-09-16 11:53:17', null);
INSERT INTO `student` VALUES ('46', '吴少', '18912617725', '家长', '1176', '1', null, '待定', '', null, '2016-09-16 11:54:04', null);
INSERT INTO `student` VALUES ('47', '谢思哲', '13913511239', '家长', '2541', '1', null, '待定', '', null, '2016-09-16 11:56:23', null);
INSERT INTO `student` VALUES ('48', '张心怡', '13906138123', '家长', '1560', '1', null, '待定', '', null, '2016-09-16 11:57:37', null);
INSERT INTO `student` VALUES ('49', '黄韵清', '15370081757', '妈妈', '0', '1', null, '待定', '', null, '2016-09-16 12:00:39', null);
INSERT INTO `student` VALUES ('50', '许可', '15371815889', '家长', '588', '1', null, '待定', '', null, '2016-09-16 12:01:29', null);
INSERT INTO `student` VALUES ('51', '韦文浩', '13656234076', '爸爸', '784', '1', null, '待定', '', null, '2016-09-16 12:04:44', null);
INSERT INTO `student` VALUES ('52', '康然然', '18551134290', '妈妈', '294', '1', null, '待定', '', null, '2016-09-16 12:05:27', null);
INSERT INTO `student` VALUES ('53', '陆思伊', '13776120529', '家长', '2779', '1', null, '待定', '', null, '2016-09-16 12:06:11', null);
INSERT INTO `student` VALUES ('54', '张松彦', '13812659359', '家长', '210', '1', null, '待定', '', null, '2016-09-16 12:07:18', null);
INSERT INTO `student` VALUES ('55', '吴亮莹', '13862636984', '家长', '294', '1', null, '待定', '', null, '2016-09-16 12:08:57', '2016-09-16 12:10:04');
INSERT INTO `student` VALUES ('56', '何峻熙', '13915588877', '家长', '1496', '1', null, '待定', '', null, '2016-09-16 12:10:49', null);
INSERT INTO `student` VALUES ('57', '邹一鸣', '13776062396', '家长', '196', '1', null, '待定', '', null, '2016-09-16 12:11:36', null);
INSERT INTO `student` VALUES ('58', '薛睿', '13776064701', '家长', '0', '1', null, '待定', '', null, '2016-09-16 12:12:11', null);
INSERT INTO `student` VALUES ('60', '易雪', '13815257049', '妈妈', '882', '1', null, '待定', '', null, '2016-09-28 10:57:42', '2016-09-28 10:58:41');
INSERT INTO `student` VALUES ('61', '余曼琳', '15206218741', '家长', '980', '1', null, '待定', '', null, '2016-09-28 11:11:59', '2016-09-29 15:54:55');
INSERT INTO `student` VALUES ('63', '何华芹', '15050432954', '家长', '0', '1', null, '待定', '', null, '2016-09-28 11:16:30', null);
INSERT INTO `student` VALUES ('65', '高卉茹', '18118103053', '妈妈', '98', '1', null, '待定', '', null, '2016-09-28 11:23:41', null);
INSERT INTO `student` VALUES ('66', '阮楚涵', '18625278599', '妈妈', '98', '1', null, '待定', '', null, '2016-09-28 11:25:17', null);
INSERT INTO `student` VALUES ('68', '周阿琴', '18013880086', '自己', '784', '1', null, '待定', '', null, '2016-09-28 11:45:49', null);
INSERT INTO `student` VALUES ('69', '李佳潆', '15371819281', '妈妈', '980', '1', null, '待定', '', null, '2016-09-28 12:38:51', null);
INSERT INTO `student` VALUES ('70', '许琳惠', '18913156655', '家长', '882', '1', null, '待定', '', null, '2016-09-28 12:40:18', null);
INSERT INTO `student` VALUES ('71', '陈滢颖', '13912612616', '妈妈', '1372', '1', null, '待定', '', null, '2016-09-28 12:41:52', null);
INSERT INTO `student` VALUES ('72', '沐语曈', '13915414386', '妈妈', '2058', '1', null, '待定', '中级4级', null, '2016-09-28 12:44:35', '2016-09-28 20:11:22');
INSERT INTO `student` VALUES ('73', '陆煜然', '15895572902', '妈妈', '1078', '1', null, '待定', '', null, '2016-09-28 12:47:35', null);
INSERT INTO `student` VALUES ('74', '张欣怡', '15151506889', '家长', '0', '1', null, '待定', '暑假生', null, '2016-09-28 12:50:37', '2016-09-29 14:03:07');
INSERT INTO `student` VALUES ('75', '唐文豪', '13862565038', '家长', '0', '1', null, '待定', '暑假生', null, '2016-09-28 12:51:28', '2016-09-29 13:56:42');
INSERT INTO `student` VALUES ('76', '夏柏怡', '051268181511', '家长', '0', '1', null, '待定', '暑假生', null, '2016-09-28 12:52:36', null);
INSERT INTO `student` VALUES ('77', '马忞孜', '15962211018', '妈妈', '2190', '1', null, '待定', '', null, '2016-09-28 12:58:27', null);
INSERT INTO `student` VALUES ('78', '张诗涵', '18951115618', '妈妈', '4998', '1', null, '待定', '', null, '2016-09-28 13:02:31', null);
INSERT INTO `student` VALUES ('79', '郑雨泽', '13912639263', '家长', '4655', '1', null, '待定', '', null, '2016-09-28 13:05:03', null);
INSERT INTO `student` VALUES ('80', '李惜玥', '18351630609', '妈妈', '0', '1', null, '待定', '', null, '2016-09-28 13:07:02', null);
INSERT INTO `student` VALUES ('81', '杨静', '13701549746', '妈妈', '1871', '1', null, '待定', '', null, '2016-09-28 13:09:49', null);
INSERT INTO `student` VALUES ('82', '顾欣杨', '13771860189', '妈妈', '1803', '1', null, '待定', '', null, '2016-09-28 13:12:11', null);
INSERT INTO `student` VALUES ('83', '杨严笃一', '13616209607', '家长', '0', '1', null, '待定', '', null, '2016-09-28 13:13:51', null);
INSERT INTO `student` VALUES ('84', '唐萌', '15862364939', '妈妈', '2075', '1', null, '待定', '中级6级', null, '2016-09-28 13:14:36', '2016-09-28 20:21:58');
INSERT INTO `student` VALUES ('85', '秦妍', '13962642029', '妈妈', '0', '1', null, '待定', '', null, '2016-09-28 13:16:48', null);
INSERT INTO `student` VALUES ('86', '顾雨薇', '13912775719', '成人', '10', '1', null, '待定', '中级4级', null, '2016-09-28 13:18:49', '2016-09-28 20:21:07');
INSERT INTO `student` VALUES ('87', '戴涵灵', '13951114745', '妈妈', '1471', '1', null, '待定', '', null, '2016-09-28 13:19:48', null);
INSERT INTO `student` VALUES ('89', '储欣然', '13616275551', '妈妈', '0', '1', null, '待定', '', null, '2016-09-28 13:25:27', null);
INSERT INTO `student` VALUES ('90', '刘若涵', '13771790045', '妈妈', '3329', '1', null, '待定', '', null, '2016-09-28 13:26:11', null);
INSERT INTO `student` VALUES ('91', '王睿', '15370085158', '妈妈', '178', '1', null, '待定', '', null, '2016-09-28 13:28:13', null);
INSERT INTO `student` VALUES ('92', '李静萱', '17761871841', '妈妈', '1576', '1', null, '待定', '', null, '2016-09-28 13:29:36', null);
INSERT INTO `student` VALUES ('93', '万成喜', '13771747281', '妈妈', '0', '1', null, '待定', '', null, '2016-09-28 13:31:20', null);
INSERT INTO `student` VALUES ('94', '张忆佳', '13328006116', '妈妈', '1234', '1', null, '待定', '', null, '2016-09-28 13:32:27', '2016-09-28 20:11:51');
INSERT INTO `student` VALUES ('95', '王芷茜', '18626296528', '妈妈', '4788', '1', null, '待定', '', null, '2016-09-28 13:35:37', null);
INSERT INTO `student` VALUES ('97', '陈悠然', '18626261122', '妈妈', '1516', '1', null, '待定', '', null, '2016-09-28 13:40:39', null);
INSERT INTO `student` VALUES ('98', '洪靖雯', '13776238777', '妈妈', '494', '1', null, '待定', '', null, '2016-09-28 13:42:14', null);
INSERT INTO `student` VALUES ('100', '罗诺欣', '13451529150', '妈妈', '1764', '1', null, '待定', '', null, '2016-09-28 13:49:37', null);
INSERT INTO `student` VALUES ('102', '张景然', '13625282972', '家长', '1139', '1', null, '待定', '', null, '2016-09-28 13:54:53', null);
INSERT INTO `student` VALUES ('103', '程添乐', '15371875266', '家长', '0', '1', null, '待定', '', null, '2016-09-28 13:56:37', null);
INSERT INTO `student` VALUES ('104', '程苏阳', '15371875266', '家长', '98', '1', null, '待定', '', null, '2016-09-28 13:57:32', null);
INSERT INTO `student` VALUES ('105', '苏锦汐', '13962108348', '妈妈', '2254', '1', null, '待定', '', null, '2016-09-28 14:07:30', null);
INSERT INTO `student` VALUES ('106', '杨承熹', '13771714997', '家长', '2716', '1', null, '待定', '', null, '2016-09-28 14:14:57', null);
INSERT INTO `student` VALUES ('107', '张晓冉', '13915549435', '妈妈', '1629', '1', null, '待定', '', null, '2016-09-28 14:17:22', null);
INSERT INTO `student` VALUES ('108', '张伊淼', '18662519121', '家长', '4018', '1', null, '待定', '', null, '2016-09-28 14:19:50', null);
INSERT INTO `student` VALUES ('109', '朱悦娍', '051265800007', '家长', '98', '1', null, '待定', '', null, '2016-09-28 14:28:02', null);
INSERT INTO `student` VALUES ('110', '马雪馨', '13776094583', '家长', '98', '1', null, '待定', '', null, '2016-09-28 14:28:55', null);
INSERT INTO `student` VALUES ('112', '王泽芊', '18913556115', '家长', '3241', '1', null, '待定', '', null, '2016-09-28 14:34:06', null);
INSERT INTO `student` VALUES ('115', '张昊阳', '13306215689', '家长', '687', '1', null, '待定', '', null, '2016-09-28 14:41:44', null);
INSERT INTO `student` VALUES ('116', '魏珺瑶', '13913176621', '家长', '490', '1', null, '待定', '', null, '2016-09-28 14:44:54', null);
INSERT INTO `student` VALUES ('117', '庄雅钧', '13812627331', '家长', '2365', '1', null, '待定', '', null, '2016-09-28 14:45:51', null);
INSERT INTO `student` VALUES ('118', '李文博', '18914055677', '家长', '2867', '1', null, '待定', '', null, '2016-09-28 14:49:30', '2016-09-28 16:06:51');
INSERT INTO `student` VALUES ('120', '潘志瑞', '15962117936', '家长', '588', '1', null, '待定', '', null, '2016-09-28 14:56:15', null);
INSERT INTO `student` VALUES ('121', '蒋雨晴', '13205132229', '家长', '196', '1', null, '待定', '', null, '2016-09-28 14:58:55', null);
INSERT INTO `student` VALUES ('122', '章迅怡', '13806215667', '家长', '3154', '1', null, '待定', '', null, '2016-09-28 15:05:13', '2016-09-28 15:40:14');
INSERT INTO `student` VALUES ('123', '霍妍博', '13390848796', '家长', '589', '1', null, '待定', '', null, '2016-09-28 15:06:42', null);
INSERT INTO `student` VALUES ('124', '封锦宜', '13912797395', '家长', '3241', '1', null, '待定', '', null, '2016-09-28 15:09:52', '2016-09-28 15:45:17');
INSERT INTO `student` VALUES ('125', '蒋采宸', '18606336397', '家长', '0', '1', null, '待定', '中级5级寒暑假生', null, '2016-09-28 15:11:22', '2016-09-30 15:11:14');
INSERT INTO `student` VALUES ('126', '吴芸辉', '18361112016', '家长', '0', '1', null, '待定', '寒暑假生', null, '2016-09-28 15:12:29', '2016-09-30 15:16:55');
INSERT INTO `student` VALUES ('127', '嵇涵琪', '15250050295', '家长', '980', '1', null, '待定', '', null, '2016-09-28 15:14:34', '2016-09-28 15:40:50');
INSERT INTO `student` VALUES ('128', '朱佳琦', '13328006116', '家长', '445', '1', null, '待定', '', null, '2016-09-28 15:17:29', '2016-09-28 15:53:02');
INSERT INTO `student` VALUES ('129', '杨嘉诚', '13451524690', '家长', '392', '1', null, '待定', '', null, '2016-09-28 15:19:26', '2016-09-28 15:42:07');
INSERT INTO `student` VALUES ('130', '杨欢', '18257342201', '家长', '882', '1', null, '待定', '', null, '2016-09-28 15:21:21', '2016-09-28 19:00:37');
INSERT INTO `student` VALUES ('131', '程嘉祺', '18006133566', '家长', '784', '1', null, '待定', '中级4级', null, '2016-09-28 15:24:15', '2016-09-28 19:02:45');
INSERT INTO `student` VALUES ('132', '姚雨佳', '15306133600', '家长', '882', '1', null, '待定', '', null, '2016-09-28 15:25:42', null);
INSERT INTO `student` VALUES ('133', '顾逸恺', '18662150155', '家长', '2728', '1', null, '待定', '', null, '2016-09-28 15:55:53', '2016-09-28 16:08:27');
INSERT INTO `student` VALUES ('134', '孙小铭', '18662196828', '家长', '1672', '1', null, '待定', '', null, '2016-09-28 20:16:40', null);
INSERT INTO `student` VALUES ('135', '吕雨诺', '18915500684', '家长', '3080', '1', null, '待定', '', null, '2016-09-28 20:18:17', null);
INSERT INTO `student` VALUES ('136', '俞智豪', '13862113997', '家长', '176', '1', null, '待定', '', null, '2016-09-28 20:19:56', null);
INSERT INTO `student` VALUES ('137', '腾会', '13222299808', '成人', '1604', '1', null, '待定', '', null, '2016-09-28 20:25:58', null);
INSERT INTO `student` VALUES ('138', '俞文豪', '13862113997', '家长', '432', '1', null, '待定', '', null, '2016-09-28 20:28:27', null);
INSERT INTO `student` VALUES ('139', '王仕鹏', '18962131169', '家长', '324', '1', null, '待定', '', null, '2016-09-28 20:31:07', null);
INSERT INTO `student` VALUES ('140', '梁一', '15950083505', '家长', '216', '1', null, '待定', '', null, '2016-09-28 20:32:36', null);
INSERT INTO `student` VALUES ('141', '万舸', '13092656399', '家长', '3780', '1', null, '待定', '', null, '2016-09-28 20:37:12', null);
INSERT INTO `student` VALUES ('142', '李昊宇', '18662603664', '家长', '648', '1', null, '待定', '', null, '2016-09-28 20:38:47', null);
INSERT INTO `student` VALUES ('143', '陈伟豪', '18915431228', '家长', '1188', '1', null, '待定', '', null, '2016-09-28 20:40:16', null);
INSERT INTO `student` VALUES ('144', '王子天', '13771944152', '家长', '1296', '1', null, '待定', '', null, '2016-09-28 20:42:43', null);
INSERT INTO `student` VALUES ('145', '许俞涛', '13962193512', '家长', '5710', '1', null, '待定', '', null, '2016-09-28 20:43:43', null);
INSERT INTO `student` VALUES ('146', '吴袁辰希', '18651105182', '家长', '2592', '1', null, '待定', '', null, '2016-09-28 20:45:30', null);
INSERT INTO `student` VALUES ('147', '王良宇', '15806208311', '家长', '5076', '1', null, '待定', '', null, '2016-09-28 20:49:31', null);
INSERT INTO `student` VALUES ('148', '倪天林', '13814893815', '家长', '4644', '1', null, '待定', '', null, '2016-09-28 20:52:12', null);
INSERT INTO `student` VALUES ('149', '刘思熙', '13773175481', '家长', '864', '1', null, '待定', '', null, '2016-09-28 20:53:23', null);
INSERT INTO `student` VALUES ('150', '李宇宸', '18912627527', '家长', '540', '1', null, '待定', '', null, '2016-09-28 20:56:20', null);
INSERT INTO `student` VALUES ('151', '单秋鸿', '18962175190', '家长', '1836', '1', null, '待定', '', null, '2016-09-28 20:57:44', null);
INSERT INTO `student` VALUES ('152', '林祖鑫', '13914042822', '家长', '756', '1', null, '待定', '', null, '2016-09-28 21:05:36', null);
INSERT INTO `student` VALUES ('153', '高季雯', '13584862373', '家长', '756', '1', null, '待定', '', null, '2016-09-28 21:06:48', null);
INSERT INTO `student` VALUES ('154', '杨牧也', '13914052246', '家长', '432', '1', null, '待定', '', null, '2016-09-28 21:08:15', null);
INSERT INTO `student` VALUES ('155', '陈玮婷', '13032538488', '家长', '756', '1', null, '待定', '', null, '2016-09-28 21:09:29', null);
INSERT INTO `student` VALUES ('156', '汤笑宇', '15862467305', '家长', '864', '1', null, '待定', '', null, '2016-09-28 21:10:37', null);
INSERT INTO `student` VALUES ('157', '华亿闻', '13814897708', '家长', '972', '1', null, '待定', '', null, '2016-09-28 21:11:45', null);
INSERT INTO `student` VALUES ('158', '李木子玥', '13861308123', '家长', '589', '1', null, '待定', '', null, '2016-09-28 21:18:54', '2016-09-29 13:58:40');
INSERT INTO `student` VALUES ('159', '李昱成', '15850152775', '家长', '589', '1', null, '待定', '', null, '2016-09-28 21:19:28', '2016-09-29 14:04:48');
INSERT INTO `student` VALUES ('160', '郭金轩', '11111111111', '家长', '589', '1', null, '待定', '', null, '2016-09-28 21:19:56', null);
INSERT INTO `student` VALUES ('161', '周宸菡', '11111111111', '家长', '589', '1', null, '待定', '', null, '2016-09-28 21:20:44', null);
INSERT INTO `student` VALUES ('165', '王萌', '18913151483', '家长', '589', '1', null, '待定', '', null, '2016-09-28 21:22:32', '2016-09-29 14:15:08');
INSERT INTO `student` VALUES ('167', '葛泽霖', '111', '家长', '589', '1', null, '待定', '', null, '2016-09-28 21:23:38', '2016-11-06 20:41:01');
INSERT INTO `student` VALUES ('168', '何梓淇', '11111', '家长', '589', '1', null, '待定', '', null, '2016-09-28 21:24:25', null);
INSERT INTO `student` VALUES ('169', '俞思琦', '13812684661', '家长', '589', '1', null, '待定', '', null, '2016-09-28 21:25:00', '2016-09-29 13:51:15');
INSERT INTO `student` VALUES ('171', '卞佳妮', '1111', '家长', '589', '1', null, '待定', '', null, '2016-09-28 21:26:12', null);
INSERT INTO `student` VALUES ('174', '邢王星', '18550097730', '家长', '589', '1', null, '待定', '', null, '2016-09-28 21:28:24', '2016-09-29 14:13:29');
INSERT INTO `student` VALUES ('175', '王瑞', '13815922392', '家长', '589', '1', null, '待定', '', null, '2016-09-28 21:29:28', null);
INSERT INTO `student` VALUES ('176', '尤奕睿', '13451971807', '家长', '589', '1', null, '待定', '', null, '2016-09-28 21:30:11', '2016-09-29 13:47:27');
INSERT INTO `student` VALUES ('177', '陆漪铭', '13862037325', '家长', '589', '1', null, '待定', '', null, '2016-09-28 21:31:08', '2016-09-29 13:59:20');
INSERT INTO `student` VALUES ('179', '沈思铭', '15250116926', '家长', '589', '1', null, '待定', '', null, '2016-09-28 21:32:56', '2016-09-29 16:13:35');
INSERT INTO `student` VALUES ('180', '刘珏', '11111', '家长', '589', '1', null, '待定', '', null, '2016-09-28 21:33:38', null);
INSERT INTO `student` VALUES ('181', '罗婉宁', '111111', '家长', '1469', '1', null, '待定', '', null, '2016-09-28 21:34:07', null);
INSERT INTO `student` VALUES ('183', '王梦丽', '18118120196', '家长', '792', '1', null, '待定', '', null, '2016-09-29 08:51:14', '2016-09-29 15:23:32');
INSERT INTO `student` VALUES ('184', '王胥', '13584857412', '家长', '792', '1', null, '待定', '', null, '2016-09-29 08:52:02', '2016-09-29 14:12:12');
INSERT INTO `student` VALUES ('185', '蔡鑫涛', '15851410035', '家长', '704', '1', null, '待定', '', null, '2016-09-29 08:53:14', '2016-09-29 15:24:28');
INSERT INTO `student` VALUES ('186', '邱健成', '18012620303', '家长', '704', '1', null, '待定', '', null, '2016-09-29 08:54:24', '2016-09-29 08:55:06');
INSERT INTO `student` VALUES ('187', '居晨夕', '13862113863', '家长', '616', '1', null, '待定', '', null, '2016-09-29 08:55:50', '2016-09-29 16:10:20');
INSERT INTO `student` VALUES ('188', '王越', '13862043689', '家长', '616', '1', null, '待定', '', null, '2016-09-29 08:56:47', '2016-09-29 14:13:05');
INSERT INTO `student` VALUES ('189', '李雯杰', '1111', '家长', '0', '1', null, '待定', '', null, '2016-09-29 08:57:44', null);
INSERT INTO `student` VALUES ('190', '冯宇豪', '115150466961', '家长', '704', '1', null, '待定', '', null, '2016-09-29 08:58:22', '2016-09-29 16:36:13');
INSERT INTO `student` VALUES ('191', '陈鹏', '13222217758', '家长', '528', '1', null, '待定', '', null, '2016-09-29 08:59:29', null);
INSERT INTO `student` VALUES ('192', '韩雅萱', '118021301906', '家长', '704', '1', null, '待定', '', null, '2016-09-29 09:00:33', '2016-09-29 16:35:45');
INSERT INTO `student` VALUES ('193', '周霞', '13814807006', '成人', '528', '1', null, '待定', '', null, '2016-09-29 09:01:22', '2016-09-29 15:28:39');
INSERT INTO `student` VALUES ('194', '杨震浩', '13915557211', '家长', '440', '1', null, '待定', '', null, '2016-09-29 09:02:19', '2016-09-29 16:22:34');
INSERT INTO `student` VALUES ('195', '朱玘轩', '13812699729', '家长', '440', '1', null, '待定', '', null, '2016-09-29 09:06:15', '2016-09-29 13:53:02');
INSERT INTO `student` VALUES ('196', '顾政', '18662610322', '家长', '352', '1', null, '待定', '', null, '2016-09-29 09:06:55', '2016-09-29 15:58:08');
INSERT INTO `student` VALUES ('197', '刘明轩', '15850157569', '家长', '616', '1', null, '待定', '', null, '2016-09-29 09:09:24', null);
INSERT INTO `student` VALUES ('199', '陆子谦', '13814863031', '家长', '704', '1', null, '待定', '', null, '2016-09-29 09:12:34', '2016-09-29 16:22:11');
INSERT INTO `student` VALUES ('201', '樊依婷', '13962165956', '家长', '264', '1', null, '待定', '', null, '2016-09-29 09:15:59', '2016-09-29 15:58:56');
INSERT INTO `student` VALUES ('202', '汪铖', '15051456316', '家长', '704', '1', null, '待定', '', null, '2016-09-29 09:16:55', '2016-09-29 15:59:13');
INSERT INTO `student` VALUES ('203', '许镔涛', '15862330551', '家长', '880', '1', null, '待定', '', null, '2016-09-29 09:17:50', '2016-09-29 09:18:32');
INSERT INTO `student` VALUES ('204', '王岩', '13815922392', '家长', '0', '1', null, '待定', '', null, '2016-09-29 09:19:21', null);
INSERT INTO `student` VALUES ('205', '李勇杰', '13405022958', '家长', '440', '1', null, '待定', '', null, '2016-09-29 09:20:55', null);
INSERT INTO `student` VALUES ('206', '陈霖煊', '18934589325', '家长', '3344', '1', null, '待定', '', null, '2016-09-29 09:22:23', null);
INSERT INTO `student` VALUES ('207', '顾嶔', '13771797515', '家长', '264', '1', null, '待定', '', null, '2016-09-29 09:26:35', null);
INSERT INTO `student` VALUES ('208', '成贝迪', '15151405236', '家长', '0', '1', null, '待定', '', null, '2016-09-29 09:27:44', null);
INSERT INTO `student` VALUES ('209', '金翌烨', '13812662025', '家长', '352', '1', null, '待定', '', null, '2016-09-29 09:31:05', '2016-09-29 16:00:46');
INSERT INTO `student` VALUES ('210', '刘恒硕', '13771868703', '家长', '0', '1', null, '待定', '', null, '2016-09-29 09:32:11', '2016-09-29 15:55:15');
INSERT INTO `student` VALUES ('211', '吴旭超', '13584880848', '家长', '440', '1', null, '待定', '', null, '2016-09-29 09:33:41', null);
INSERT INTO `student` VALUES ('212', '王振力', '15862330912', '家长', '352', '1', null, '待定', '', null, '2016-09-29 09:37:20', '2016-09-29 16:14:06');
INSERT INTO `student` VALUES ('213', '刘济枢', '15862490569', '家长', '0', '1', null, '待定', '', null, '2016-09-29 09:40:19', null);
INSERT INTO `student` VALUES ('214', '张陈沭阳', '18021271730', '家长', '528', '1', null, '待定', '', null, '2016-09-29 09:41:31', null);
INSERT INTO `student` VALUES ('215', '谢雨彤', '13151191371', '家长', '0', '1', null, '待定', '', null, '2016-09-29 09:43:04', null);
INSERT INTO `student` VALUES ('216', '周宇恒', '15995848340', '家长', '0', '1', null, '待定', '', null, '2016-09-29 09:44:19', '2016-09-29 15:53:02');
INSERT INTO `student` VALUES ('217', '金浩阳', '13913299933', '家长', '0', '1', null, '待定', '', null, '2016-09-29 09:45:03', '2016-09-29 15:52:37');
INSERT INTO `student` VALUES ('218', '李子熙', '18912627527', '家长', '440', '1', null, '待定', '', null, '2016-09-29 09:45:54', null);
INSERT INTO `student` VALUES ('219', '张博超', '13584846482', '家长', '528', '1', null, '待定', '', null, '2016-09-29 09:47:09', '2016-09-29 15:51:56');
INSERT INTO `student` VALUES ('220', '冀翔', '13915535073', '家长', '616', '1', null, '待定', '', null, '2016-09-29 09:48:58', '2016-09-29 15:51:15');
INSERT INTO `student` VALUES ('221', '孟冯薇', '15952447286', '家长', '88', '1', null, '待定', '', null, '2016-09-29 09:50:21', null);
INSERT INTO `student` VALUES ('222', '巩欢', '18662536651', '家长', '176', '1', null, '待定', '', null, '2016-09-29 09:52:05', null);
INSERT INTO `student` VALUES ('224', '顾工', '18912608992', '家长', '616', '1', null, '待定', '', null, '2016-09-29 09:55:44', null);
INSERT INTO `student` VALUES ('225', '李瑶', '18351630609', '家长', '0', '0', null, '待定', '', null, '2016-09-29 09:56:46', null);
INSERT INTO `student` VALUES ('226', '夏亮', '111', '家长', '0', '1', null, '待定', '', null, '2016-09-29 09:57:29', null);
INSERT INTO `student` VALUES ('227', '王溢炜', '18550277566', '家长', '0', '1', null, '待定', '', null, '2016-09-29 10:00:28', null);
INSERT INTO `student` VALUES ('228', '龙宇', '111', '家长', '0', '1', null, '待定', '', null, '2016-09-29 10:01:01', null);
INSERT INTO `student` VALUES ('229', '李加兵', '111', '家长', '0', '1', null, '待定', '', null, '2016-09-29 10:01:42', null);
INSERT INTO `student` VALUES ('230', '李平', '15995828798', '家长', '0', '1', null, '待定', '', null, '2016-09-29 10:02:20', null);
INSERT INTO `student` VALUES ('231', '金语诺', '13814891080', '家长', '0', '1', null, '待定', '', null, '2016-09-29 10:03:03', null);
INSERT INTO `student` VALUES ('234', '陈玉婷', '111', '家长', '440', '1', null, '待定', '', null, '2016-09-29 10:10:43', null);
INSERT INTO `student` VALUES ('235', '宋清晨', '13656235418', '家长', '2288', '1', null, '待定', '', null, '2016-09-29 10:11:50', null);
INSERT INTO `student` VALUES ('236', '毛梓煜', '13913129678', '家长', '264', '1', null, '待定', '', null, '2016-09-29 10:13:17', null);
INSERT INTO `student` VALUES ('237', '赵木楠', '18018121969', '家长', '440', '1', null, '待定', '', null, '2016-09-29 10:14:25', '2016-09-29 15:50:25');
INSERT INTO `student` VALUES ('238', '陈张心依', '18021271730', '家长', '264', '1', null, '待定', '', null, '2016-09-29 10:15:33', null);
INSERT INTO `student` VALUES ('239', '周佳奕', '13776188662', '家长', '2640', '1', null, '待定', '', null, '2016-09-29 10:16:25', '2016-09-29 15:49:30');
INSERT INTO `student` VALUES ('240', '潘亦彤', '18913553733', '家长', '2552', '1', null, '待定', '', null, '2016-09-29 10:17:32', '2016-09-29 15:49:53');
INSERT INTO `student` VALUES ('241', '夏雨', '13776012207', '家长', '0', '1', null, '待定', '', null, '2016-09-29 10:19:35', null);
INSERT INTO `student` VALUES ('242', '高嘉晨', '13912777870', '家长', '2552', '1', null, '待定', '', null, '2016-09-29 10:21:02', null);
INSERT INTO `student` VALUES ('243', '孙雨竹', '15862463039', '家长', '176', '1', null, '待定', '', null, '2016-09-29 10:22:10', null);
INSERT INTO `student` VALUES ('244', '殷天懿', '13771761508', '家长', '0', '1', null, '待定', '高级8级', null, '2016-09-29 10:24:25', null);
INSERT INTO `student` VALUES ('245', '杨雪瑶', '111', '家长', '0', '1', null, '待定', '', null, '2016-09-29 10:26:15', null);
INSERT INTO `student` VALUES ('246', '陈茉妍', '13912625697', '家长', '0', '1', null, '待定', '', null, '2016-09-29 10:27:20', null);
INSERT INTO `student` VALUES ('248', '路金旭', '111', '家长', '0', '1', null, '待定', '寒暑假生', null, '2016-09-29 10:32:02', null);
INSERT INTO `student` VALUES ('249', '丁云梅', '1111', '家长', '0', '1', null, '待定', '', null, '2016-09-29 10:33:04', null);
INSERT INTO `student` VALUES ('250', '闫丽萍', '13916508781', '家长', '0', '1', null, '待定', '', null, '2016-09-29 10:33:56', null);
INSERT INTO `student` VALUES ('251', '刘苏', '1111', '家长', '0', '1', null, '待定', '', null, '2016-09-29 10:34:51', null);
INSERT INTO `student` VALUES ('253', '陈梓妍', '111', '妈妈', '0', '1', null, '待定', '', null, '2016-09-29 10:59:18', null);
INSERT INTO `student` VALUES ('255', '梁舒羽', '1', '妈妈', '440', '1', null, '待定', '', null, '2016-09-29 11:01:23', '2016-09-29 15:47:43');
INSERT INTO `student` VALUES ('256', '刘嘉欣', '11111', '家长', '40', '1', null, '待定', '', null, '2016-09-29 11:02:16', null);
INSERT INTO `student` VALUES ('257', '薛佳琪', '111', '家长', '320', '1', null, '待定', '', null, '2016-09-29 11:03:51', '2016-09-29 15:47:10');
INSERT INTO `student` VALUES ('262', '陈艾', '18114361263', '家长', '400', '1', null, '待定', '', null, '2016-09-29 11:07:21', '2016-09-29 14:11:39');
INSERT INTO `student` VALUES ('266', '马佳妮', '13912739804', '家长', '160', '1', null, '待定', '', null, '2016-09-29 11:53:44', '2016-09-29 15:46:33');
INSERT INTO `student` VALUES ('267', '谢睿琪', '13771983115', '家长', '80', '1', null, '待定', '', null, '2016-09-29 11:55:15', '2016-09-29 16:30:19');
INSERT INTO `student` VALUES ('268', '谢睿曦', '13771983115', '家长', '160', '1', null, '待定', '', null, '2016-09-29 11:56:22', '2016-09-29 15:46:10');
INSERT INTO `student` VALUES ('269', '陈宇暄', '18362598191', '家长', '80', '1', null, '待定', '', null, '2016-09-29 11:59:19', '2016-09-29 15:45:50');
INSERT INTO `student` VALUES ('270', '马一航', '13814899572', '家长', '200', '1', null, '待定', '', null, '2016-09-29 12:03:20', '2016-09-29 14:10:54');
INSERT INTO `student` VALUES ('271', '徐欣菲', '18901437545', '家长', '0', '1', null, '待定', '', null, '2016-09-29 12:24:39', '2016-09-29 15:45:28');
INSERT INTO `student` VALUES ('273', '金韵妃', '13913147860', '家长', '80', '1', null, '待定', '', null, '2016-09-29 12:26:45', '2016-09-29 15:44:58');
INSERT INTO `student` VALUES ('274', '付靖宸', '111', '家长', '360', '1', null, '待定', '', null, '2016-09-29 12:27:31', '2016-09-29 15:44:35');
INSERT INTO `student` VALUES ('276', '王昕琰', '15862326550', '家长', '1060', '1', null, '待定', '', null, '2016-09-29 12:42:27', '2016-09-29 15:43:48');
INSERT INTO `student` VALUES ('277', '王姿', '13732628540', '妈妈', '1249', '1', null, '待定', '', null, '2016-09-29 12:43:14', '2016-10-10 17:01:31');
INSERT INTO `student` VALUES ('278', '孟子涵', '15335285856', '家长', '680', '1', null, '待定', '', null, '2016-09-29 12:44:04', '2016-09-29 15:43:28');
INSERT INTO `student` VALUES ('279', '吕梓荣', '15862355869', '家长', '800', '1', null, '待定', '', null, '2016-09-29 12:47:17', '2016-09-29 15:42:13');
INSERT INTO `student` VALUES ('280', '储欣羽', '13402535171', '家长', '240', '1', null, '待定', '', null, '2016-09-29 12:51:46', '2016-09-29 13:51:59');
INSERT INTO `student` VALUES ('282', '骆苏瑞', '18015594878', '家长', '0', '1', null, '待定', '', null, '2016-09-29 12:55:05', '2016-09-29 14:02:23');
INSERT INTO `student` VALUES ('283', '王朵朵', '13914046157', '家长', '0', '1', null, '待定', '', null, '2016-09-29 12:55:48', '2016-09-29 13:49:24');
INSERT INTO `student` VALUES ('285', '仓恒雨', '15295620447', '家长', '0', '1', null, '待定', '', null, '2016-09-29 12:57:49', '2016-09-29 14:05:41');
INSERT INTO `student` VALUES ('288', '郁忆歆', '13814838507', '家长', '120', '1', null, '待定', '', null, '2016-09-29 13:02:04', '2016-09-29 15:39:12');
INSERT INTO `student` VALUES ('289', '袁陈希', '13862120147', '妈妈', '480', '1', null, '待定', '', null, '2016-09-29 13:02:56', '2016-10-11 17:10:45');
INSERT INTO `student` VALUES ('291', '杨睿', '1111', '家长', '440', '1', null, '待定', '', null, '2016-09-29 13:06:54', null);
INSERT INTO `student` VALUES ('293', '朱允绮', '15895567707', '家长', '572', '1', null, '待定', '', null, '2016-09-29 13:09:12', '2016-09-29 13:57:50');
INSERT INTO `student` VALUES ('294', '李宝韵', '18550211396', '家长', '280', '1', null, '待定', '', null, '2016-09-29 13:09:41', '2016-09-29 15:13:43');
INSERT INTO `student` VALUES ('296', '许芯菲', '13915559627', '家长', '108', '1', null, '待定', '', null, '2016-09-29 13:13:12', '2016-09-29 13:15:16');
INSERT INTO `student` VALUES ('301', '钱古丽', '13776120585', '家长', '4900', '1', null, '待定', '', null, '2016-09-30 08:46:53', null);
INSERT INTO `student` VALUES ('303', '刘权今', '18912615573', '家长', '785', '1', null, '待定', '', null, '2016-09-30 09:49:29', null);
INSERT INTO `student` VALUES ('304', '叶泽凯', '111', '家长', '589', '1', null, '待定', '', null, '2016-09-30 10:53:41', null);
INSERT INTO `student` VALUES ('305', '金凡舒', '13951322528', '家长', '0', '1', null, '待定', '', null, '2016-09-30 13:20:24', null);
INSERT INTO `student` VALUES ('306', '张皓哲', '18625002526', '家长', '0', '1', null, '待定', '', null, '2016-09-30 13:22:07', '2016-09-30 13:32:56');
INSERT INTO `student` VALUES ('307', '王姣予', '13771783005', '妈妈', '0', '1', null, '待定', '', null, '2016-09-30 13:23:55', null);
INSERT INTO `student` VALUES ('308', '罗婉玉', '111', '家长', '0', '1', null, '待定', '', null, '2016-09-30 13:24:48', null);
INSERT INTO `student` VALUES ('309', '苏雅诺', '18662338188', '家长', '0', '1', null, '待定', '', null, '2016-09-30 13:27:03', null);
INSERT INTO `student` VALUES ('310', '叶锦上', '1111', '家长', '0', '1', null, '待定', '', null, '2016-09-30 13:28:27', null);
INSERT INTO `student` VALUES ('311', '彭以林', '13814898779', '家长', '0', '1', null, '待定', '', null, '2016-09-30 13:29:17', null);
INSERT INTO `student` VALUES ('312', '张青钰', '15962222148', '家长', '0', '1', null, '待定', '', null, '2016-09-30 13:30:39', null);
INSERT INTO `student` VALUES ('313', '邱欣雨', '1111', '家长', '0', '1', null, '待定', '', null, '2016-09-30 13:32:10', null);
INSERT INTO `student` VALUES ('314', '苏雅琰', '18662338188', '妈妈', '0', '1', null, '待定', '', null, '2016-09-30 13:34:30', null);
INSERT INTO `student` VALUES ('315', '朱雨婷', '18351129662', '家长', '0', '1', null, '待定', '', null, '2016-09-30 13:37:35', null);
INSERT INTO `student` VALUES ('316', '刘婉晴', '13092612258', '家长', '541', '1', null, '待定', '', null, '2016-09-30 14:05:32', null);
INSERT INTO `student` VALUES ('317', '尹悦', '1111', '家长', '231', '1', null, '待定', '', null, '2016-09-30 14:08:45', null);
INSERT INTO `student` VALUES ('318', '周雅轩', '13451989129', '妈妈', '1240', '1', null, '待定', '', null, '2016-09-30 14:36:40', null);
INSERT INTO `student` VALUES ('319', '卢芊羽', '13666809590', '家长', '0', '1', null, '待定', '', null, '2016-09-30 15:22:44', null);
INSERT INTO `student` VALUES ('320', '祁悦', '13812791189', '家长', '5400', '1', null, '待定', '', null, '2016-10-06 20:50:16', '2016-10-06 21:24:18');
INSERT INTO `student` VALUES ('321', '陆鑫慧', '111', '家长', '1309', '1', null, '待定', '', null, '2016-10-06 20:51:39', null);
INSERT INTO `student` VALUES ('322', '张欣玥', '111', '家长', '1349', '1', null, '待定', '', null, '2016-10-06 20:55:01', null);
INSERT INTO `student` VALUES ('323', '朱宇萌', '13862105452', '家长', '1469', '1', null, '待定', '', null, '2016-10-06 20:56:03', '2016-11-18 19:49:28');
INSERT INTO `student` VALUES ('324', '李元灿', '18012633588', '家长', '1789', '1', null, '待定', '', null, '2016-10-06 20:57:26', null);
INSERT INTO `student` VALUES ('325', '严歆怡', '111', '家长', '989', '1', null, '待定', '', null, '2016-10-06 20:58:46', null);
INSERT INTO `student` VALUES ('326', '吕梓萌', '111', '家长', '589', '1', null, '待定', '', null, '2016-10-06 21:00:03', null);
INSERT INTO `student` VALUES ('327', '王梓涵', '18662208960', '家长', '2689', '1', null, '待定', '', null, '2016-10-06 21:01:05', '2016-10-06 21:38:52');
INSERT INTO `student` VALUES ('328', '娄心湉', '15850135713', '爸爸', '2116', '1', null, '待定', '', null, '2016-10-06 21:02:56', '2016-10-10 15:00:13');
INSERT INTO `student` VALUES ('329', '沈馨妍', '18912606280', '家长', '2888', '1', null, '待定', '', null, '2016-10-06 21:04:58', '2016-10-10 15:04:57');
INSERT INTO `student` VALUES ('330', '陈子鹏', '18896996282', '家长', '5788', '1', null, '待定', '', null, '2016-10-06 21:06:27', '2016-10-10 15:03:58');
INSERT INTO `student` VALUES ('331', '孔繁夕', '13405046966', '家长', '6812', '1', null, '待定', '声乐中级', null, '2016-10-06 21:07:32', '2016-10-10 15:02:59');
INSERT INTO `student` VALUES ('332', '方辰熙', '111', '家长', '2695', '1', null, '待定', '', null, '2016-10-06 21:09:26', null);
INSERT INTO `student` VALUES ('333', '邱睿莹', '13962196465', '家长', '1500', '1', null, '待定', '', null, '2016-10-06 21:10:25', '2016-10-10 15:08:31');
INSERT INTO `student` VALUES ('334', '曹语桐', '111', '家长', '840', '1', null, '待定', '', null, '2016-10-06 21:11:25', null);
INSERT INTO `student` VALUES ('335', '胡优璇', '13951102949', '家长', '2344', '1', null, '待定', '', null, '2016-10-06 21:12:14', '2016-10-10 15:01:41');
INSERT INTO `student` VALUES ('336', '宋犁萍', '13606204706', '家长', '1176', '1', null, '待定', '', null, '2016-10-06 21:13:18', '2016-10-06 21:28:02');
INSERT INTO `student` VALUES ('337', '江梓晗', '111', '家长', '5335', '1', null, '待定', '', null, '2016-10-06 21:14:05', null);
INSERT INTO `student` VALUES ('338', '窦硕琪', '13862164582', '妈妈', '1834', '1', null, '待定', '', null, '2016-10-06 21:15:22', null);
INSERT INTO `student` VALUES ('339', '刘吚熳', '18550010766', '妈妈', '2772', '1', null, '待定', '', null, '2016-10-06 21:17:09', '2016-10-06 21:29:59');
INSERT INTO `student` VALUES ('340', '王文琪', '18112607257', '家长', '580', '1', null, '待定', '', null, '2016-10-10 21:01:33', '2016-10-10 21:03:14');
INSERT INTO `student` VALUES ('341', '杨沛瑶', '15862652765', '家长', '580', '1', null, '待定', '', null, '2016-10-10 21:02:52', null);
INSERT INTO `student` VALUES ('342', '李雪儿', '13914072470', '家长', '880', '1', null, '待定', '', null, '2016-10-10 21:03:53', null);
INSERT INTO `student` VALUES ('343', '姚钧瀚', '111', '家长', '580', '1', null, '待定', '', null, '2016-10-10 21:05:38', null);
INSERT INTO `student` VALUES ('344', '蔡殷富', '18915542398', '家长', '580', '1', null, '待定', '', null, '2016-10-10 21:06:51', null);
INSERT INTO `student` VALUES ('345', '陈梓涵', '15851498455', '家长', '580', '1', null, '待定', '', null, '2016-10-10 21:07:30', null);
INSERT INTO `student` VALUES ('346', '单青松', '15862452692', '成人', '580', '1', null, '待定', '', null, '2016-10-10 21:09:34', '2016-10-10 21:09:50');
INSERT INTO `student` VALUES ('347', '温媛媛', '13402509963', '家长', '980', '1', null, '待定', '', null, '2016-10-11 16:20:21', null);
INSERT INTO `student` VALUES ('348', '张依淼', '18662519121', '妈妈', '3416', '1', null, '待定', '', null, '2016-10-11 18:10:38', null);
INSERT INTO `student` VALUES ('349', '王美涵', '18014000668', '妈妈', '1740', '1', null, '待定', '', null, '2016-10-11 18:47:19', null);
INSERT INTO `student` VALUES ('350', '毛嘉悦', '18915433811', '妈妈', '580', '1', null, '待定', '', null, '2016-10-11 18:48:39', null);

-- ----------------------------
-- Table structure for teacher_work_flow
-- ----------------------------
DROP TABLE IF EXISTS `teacher_work_flow`;
CREATE TABLE `teacher_work_flow` (
  `id` varchar(50) NOT NULL DEFAULT '' COMMENT 'uuid主键',
  `teacher_id` int(11) NOT NULL,
  `course_id` int(11) NOT NULL,
  `course_count` int(2) NOT NULL,
  `stu_count` int(11) NOT NULL COMMENT '听课学生数量',
  `remark` varchar(255) NOT NULL,
  `create_time` datetime NOT NULL,
  PRIMARY KEY (`id`),
  KEY `id` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of teacher_work_flow
-- ----------------------------
INSERT INTO `teacher_work_flow` VALUES ('7b26d4d87c414470959e4466e98b985f', '29', '16', '1', '1', '2016.8.12', '2016-09-16 10:36:50');
INSERT INTO `teacher_work_flow` VALUES ('80b0b12d83e3497aa503b75ec70cb2d8', '39', '24', '1', '1', '9月10日\r\n', '2016-09-17 16:36:07');
INSERT INTO `teacher_work_flow` VALUES ('c3b2fb2f782d4ccd8eb1aa539c4fc454', '39', '24', '1', '1', '9月3号', '2016-09-17 16:35:55');
INSERT INTO `teacher_work_flow` VALUES ('d98f8a46b8164be593504a531db0a38f', '29', '16', '1', '1', '2016.9.12', '2016-09-16 10:37:04');

-- ----------------------------
-- Table structure for user
-- ----------------------------
DROP TABLE IF EXISTS `user`;
CREATE TABLE `user` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `account` varchar(20) NOT NULL,
  `password` varchar(32) NOT NULL,
  `name` varchar(20) NOT NULL,
  `phone` varchar(20) NOT NULL,
  `type` int(2) NOT NULL COMMENT '0:教师　1:管理员',
  `entry_time` date DEFAULT NULL,
  `course_arr` varchar(255) DEFAULT NULL COMMENT '指导的课程列表,以英文逗号分开',
  `stus` int(2) NOT NULL COMMENT '用户状态 1：正常，0：冻结',
  `remark` varchar(255) DEFAULT NULL,
  `create_time` datetime NOT NULL,
  `update_time` datetime DEFAULT NULL,
  `openid` varchar(50) DEFAULT NULL COMMENT '用于教师进行微信绑定',
  PRIMARY KEY (`id`),
  UNIQUE KEY `account_unique` (`account`),
  UNIQUE KEY `name` (`name`)
) ENGINE=InnoDB AUTO_INCREMENT=40 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of user
-- ----------------------------
INSERT INTO `user` VALUES ('1', 'szlzs', 'b9979d181ac6cad9c8304df14c273d77', 'szlzs', '17707119188', '1', '2016-06-23', '1,2,14,15', '1', '我是管理员', '2016-06-23 22:44:24', '2016-07-18 14:02:48', null);
INSERT INTO `user` VALUES ('29', 'gqyj', '883fc99983773cfcc6c33bdf0b2ec010', '杨洁', '13776005584', '0', '2015-10-01', '16,17', '1', '', '2016-08-22 14:26:40', null, null);
INSERT INTO `user` VALUES ('30', 'gqlr', '883fc99983773cfcc6c33bdf0b2ec010', '李芮', '15962171641', '0', '2015-04-01', '16,17', '1', '', '2016-08-22 14:28:02', null, null);
INSERT INTO `user` VALUES ('31', 'gqbsh', '883fc99983773cfcc6c33bdf0b2ec010', '毕帅花', '15851875989', '0', '2016-04-01', '16,17', '1', '', '2016-08-22 14:31:11', null, null);
INSERT INTO `user` VALUES ('32', 'cjpu', '883fc99983773cfcc6c33bdf0b2ec010', '曹家谱', '13771733927', '0', '2015-03-01', '16,18,20,21', '1', '', '2016-08-22 14:33:00', null, null);
INSERT INTO `user` VALUES ('33', 'xfei', '883fc99983773cfcc6c33bdf0b2ec010', '夏飞', '15851875173', '0', '2015-09-01', '18,19', '1', '', '2016-08-22 14:34:52', null, null);
INSERT INTO `user` VALUES ('34', 'cppan', '883fc99983773cfcc6c33bdf0b2ec010', '陈盼盼', '15250049122', '0', null, '16,28,29', '1', '', '2016-08-22 14:35:22', null, null);
INSERT INTO `user` VALUES ('35', 'hmeng', '883fc99983773cfcc6c33bdf0b2ec010', '惠萌', '15861652341', '0', '2015-03-01', '22', '1', '', '2016-08-22 14:37:28', null, null);
INSERT INTO `user` VALUES ('36', 'dyang', '883fc99983773cfcc6c33bdf0b2ec010', '丁杨', '13545911732', '0', '2016-04-01', '23', '1', '', '2016-08-22 14:39:14', null, null);
INSERT INTO `user` VALUES ('37', 'yyan', '883fc99983773cfcc6c33bdf0b2ec010', '杨岩', '13646228435', '0', '2016-07-01', '25', '1', '', '2016-08-22 14:40:25', null, null);
INSERT INTO `user` VALUES ('38', 'zaqin', '883fc99983773cfcc6c33bdf0b2ec010', '周阿芹', '18013880086', '0', '2016-07-01', '25,26', '1', '', '2016-08-22 14:42:02', null, null);
INSERT INTO `user` VALUES ('39', 'zqi', '883fc99983773cfcc6c33bdf0b2ec010', '张琦', '1', '0', null, '24', '1', '', '2016-08-22 15:46:16', null, null);
