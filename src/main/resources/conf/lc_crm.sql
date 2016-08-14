/*
Navicat MySQL Data Transfer

Source Server         : localhost
Source Server Version : 50621
Source Host           : localhost:3306
Source Database       : lc_crm

Target Server Type    : MYSQL
Target Server Version : 50621
File Encoding         : 65001

Date: 2016-07-18 14:19:40
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
) ENGINE=InnoDB AUTO_INCREMENT=16 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of course
-- ----------------------------
INSERT INTO `course` VALUES ('1', '钢琴', '0', '一对一教学', '2016-06-23 09:53:54', '2016-06-24 20:19:46');
INSERT INTO `course` VALUES ('2', '拉丁', '1', '集体课', '2016-06-23 09:54:10', null);
INSERT INTO `course` VALUES ('3', '吉他', '0', '一对一教学', '2016-06-23 09:54:41', null);
INSERT INTO `course` VALUES ('4', 'tango', '1', '集体课', '2016-06-23 09:55:40', null);
INSERT INTO `course` VALUES ('5', '古筝', '0', '一对一教学', '2016-06-23 09:55:58', null);
INSERT INTO `course` VALUES ('14', '数学', '1', '数学是一门艺术', '2016-06-24 17:16:11', null);
INSERT INTO `course` VALUES ('15', '跑马', '0', '跑马慢慢来吧', '2016-06-24 17:17:43', null);

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
) ENGINE=InnoDB AUTO_INCREMENT=15 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of grp
-- ----------------------------
INSERT INTO `grp` VALUES ('2', '天下钢琴提高班', '4', '1', '天下老师水平很好哦', '2016-06-27 18:45:17', null);
INSERT INTO `grp` VALUES ('6', '刘老师钢琴1班', '26', '1', '刘老师很和蔼', '2016-06-27 20:47:39', null);
INSERT INTO `grp` VALUES ('7', 'hexiao拉丁办', '3', '2', 'hexiao拉丁办hexiao拉丁办222333', '2016-06-28 12:48:43', '2016-06-28 14:11:38');
INSERT INTO `grp` VALUES ('8', '我老师吉他提高班', '28', '3', '我老师吉他提高班', '2016-06-28 21:38:38', null);
INSERT INTO `grp` VALUES ('9', '我老师钢琴提高班', '28', '1', '我老师钢琴提高班111', '2016-06-29 22:00:27', null);
INSERT INTO `grp` VALUES ('10', '我老师拉丁大气班', '28', '2', '我老师拉丁大气班', '2016-06-29 22:00:49', '2016-07-18 14:03:50');
INSERT INTO `grp` VALUES ('11', 'kevin数学指导班', '1', '14', 'kevin数学指导班kevin数学指导班', '2016-07-04 23:55:29', '2016-07-05 22:44:08');
INSERT INTO `grp` VALUES ('14', 'kevin钢琴班', '1', '1', 'kevin亲自指导', '2016-07-18 14:03:23', null);

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
) ENGINE=InnoDB AUTO_INCREMENT=30 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of grp_stu_mapping
-- ----------------------------
INSERT INTO `grp_stu_mapping` VALUES ('3', '1', '6', '2016-06-27 20:47:39');
INSERT INTO `grp_stu_mapping` VALUES ('9', '15', '7', '2016-06-28 14:10:22');
INSERT INTO `grp_stu_mapping` VALUES ('11', '5', '7', '2016-06-28 14:11:38');
INSERT INTO `grp_stu_mapping` VALUES ('12', '3', '8', '2016-06-28 21:38:38');
INSERT INTO `grp_stu_mapping` VALUES ('13', '17', '8', '2016-06-28 21:38:38');
INSERT INTO `grp_stu_mapping` VALUES ('14', '2', '9', '2016-06-29 22:00:27');
INSERT INTO `grp_stu_mapping` VALUES ('15', '17', '9', '2016-06-29 22:00:27');
INSERT INTO `grp_stu_mapping` VALUES ('16', '17', '10', '2016-06-29 22:00:49');
INSERT INTO `grp_stu_mapping` VALUES ('17', '18', '10', '2016-07-04 23:39:57');
INSERT INTO `grp_stu_mapping` VALUES ('25', '19', '11', '2016-07-05 22:44:08');
INSERT INTO `grp_stu_mapping` VALUES ('26', '20', '11', '2016-07-05 22:44:08');
INSERT INTO `grp_stu_mapping` VALUES ('27', '26', '14', '2016-07-18 14:03:23');
INSERT INTO `grp_stu_mapping` VALUES ('28', '27', '14', '2016-07-18 14:03:23');
INSERT INTO `grp_stu_mapping` VALUES ('29', '26', '10', '2016-07-18 14:03:50');

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
) ENGINE=InnoDB AUTO_INCREMENT=28 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of student
-- ----------------------------
INSERT INTO `student` VALUES ('1', '小阿妹', '18997777661', '李源', '1000', '1', '2016-06-03', '1', '学的不错', null, '2016-06-25 11:23:58', null);
INSERT INTO `student` VALUES ('2', '大冬瓜', '13627898876', '王梅', '500', '1', '2016-06-08', '1', '兴趣浓厚', null, '2016-06-25 11:37:23', '2016-06-25 17:08:08');
INSERT INTO `student` VALUES ('3', '小雨', '188997788823', '大雨', '0', '1', '2016-06-01', '1', '很有兴趣', null, '2016-06-25 15:29:25', '2016-06-25 15:53:57');
INSERT INTO `student` VALUES ('5', '李萍', '178098987678', '李为生', '1700', '1', '2016-06-07', '1', '不错', null, '2016-06-26 22:04:59', null);
INSERT INTO `student` VALUES ('15', '王悦', '18976788921', '王恬', '1800', '1', '2016-06-26', '1', '还好', null, '2016-06-26 22:05:39', null);
INSERT INTO `student` VALUES ('16', 'test', '17756986326', 'testfu', '2000', '1', '2016-06-09', '1', 'testtesttesttest', null, '2016-06-28 18:12:49', null);
INSERT INTO `student` VALUES ('17', '小军', '18977878221', '王建瓯', '15379', '1', '2016-06-04', '1', '暗室逢灯', null, '2016-06-28 21:32:01', null);
INSERT INTO `student` VALUES ('18', '小明', '100909121212', '111', '1000', '1', '2016-07-01', '1', 'afsd ', null, '2016-07-04 23:39:28', null);
INSERT INTO `student` VALUES ('19', '1001', '111', '111', '1323', '1', '2016-06-30', '1', '111', null, '2016-07-04 23:52:41', null);
INSERT INTO `student` VALUES ('20', '1002', '111', '111', '12', '1', '2016-06-30', '1', '111', null, '2016-07-04 23:52:55', null);
INSERT INTO `student` VALUES ('21', '1003', '1212', '按时发的', '578', '1', '2016-07-01', '1', '阿斯蒂芬', null, '2016-07-04 23:53:10', null);
INSERT INTO `student` VALUES ('22', '1004', '11313', '按时发的', '13', '1', '2016-06-30', '1', '萨芬的', null, '2016-07-04 23:53:56', null);
INSERT INTO `student` VALUES ('23', '甜蜜蜜', '111121212', '阿斯蒂芬', '1112', '1', '2016-06-30', '美丽中学', '12121', null, '2016-07-05 23:33:25', '2016-07-17 14:39:12');
INSERT INTO `student` VALUES ('24', '三分', '11212', '啊啊啊', '1', '1', '2016-06-29', '育才中学', '萨芬的', null, '2016-07-05 23:34:59', '2016-07-17 14:39:03');
INSERT INTO `student` VALUES ('25', 'w山', '121299911', '搭讪', '1', '1', '2016-07-07', '江湖中学2', '2去', null, '2016-07-17 14:38:35', '2016-07-17 14:38:54');
INSERT INTO `student` VALUES ('26', '王一凡', '17705177022', '老爸', '420', '1', '1991-10-11', '舒城一中', '舒城一中', null, '2016-07-18 13:57:58', null);
INSERT INTO `student` VALUES ('27', '王君帆', '17705177022', '我爸', '1200', '1', '1992-12-10', '书城中学', '书城中学', null, '2016-07-18 14:00:41', '2016-07-18 14:01:34');

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
) ENGINE=InnoDB AUTO_INCREMENT=125 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of stu_course_flow
-- ----------------------------
INSERT INTO `stu_course_flow` VALUES ('85', '3', '3', '0', '28', '1', '0', '6月18号，上课2节', '820a9a862d9341b7ad599fdc2472d552', '2016-07-17 21:17:19');
INSERT INTO `stu_course_flow` VALUES ('86', '17', '3', '0', '28', '4', '0', '天天', 'e685df2b8c234df8a465778fddd08619', '2016-07-17 21:18:10');
INSERT INTO `stu_course_flow` VALUES ('87', '17', '3', '0', '28', '2', '0', '按时发的', '60f75fb3ea654e81813a379ce7da277d', '2016-07-17 21:18:32');
INSERT INTO `stu_course_flow` VALUES ('88', '17', '2', '0', '28', '2', '0', '哈哈', 'f2426c0b2a0341f58618af76ba9a5bdc', '2016-07-17 21:19:10');
INSERT INTO `stu_course_flow` VALUES ('89', '18', '2', '0', '28', '2', '0', '哈哈', 'f2426c0b2a0341f58618af76ba9a5bdc', '2016-07-17 21:19:10');
INSERT INTO `stu_course_flow` VALUES ('90', '17', '2', '0', '28', '2', '0', '按时发的无法', 'fe495162af954f988c69842bd5fa88f4', '2016-07-17 21:19:28');
INSERT INTO `stu_course_flow` VALUES ('91', '18', '2', '0', '28', '2', '0', '按时发的无法', 'fe495162af954f988c69842bd5fa88f4', '2016-07-17 21:19:28');
INSERT INTO `stu_course_flow` VALUES ('92', '17', '1', '0', '28', '1', '0', '二哥', '8e2230caf80e4e8993b91d6037728802', '2016-07-17 21:20:31');
INSERT INTO `stu_course_flow` VALUES ('93', '17', '1', '0', '28', '1', '0', '温柔俺323', 'e0a14fe792a2477db09f88dd413c347f', '2016-07-17 21:21:55');
INSERT INTO `stu_course_flow` VALUES ('94', '17', '1', '0', '28', '1', '0', '区分', 'b352b5a47c8f42c49f5e689a68e4ea56', '2016-07-17 21:22:40');
INSERT INTO `stu_course_flow` VALUES ('95', '17', '1', '0', '28', '1', '0', '按时发的问问', '590ec5dc8e474d778621b365a77872d6', '2016-07-17 21:25:14');
INSERT INTO `stu_course_flow` VALUES ('96', '17', '1', '0', '28', '1', '0', '分阿斯蒂芬', '2c7f5351a80e448687b8c4021ff7973a', '2016-07-17 21:26:13');
INSERT INTO `stu_course_flow` VALUES ('97', '19', '14', '0', '1', '2', '0', '我爱我家', '270fb277cb1746c1bd4acd3c90246f9b', '2016-07-17 21:31:09');
INSERT INTO `stu_course_flow` VALUES ('98', '20', '14', '0', '1', '2', '0', '我爱我家', '270fb277cb1746c1bd4acd3c90246f9b', '2016-07-17 21:31:09');
INSERT INTO `stu_course_flow` VALUES ('99', '20', '14', '0', '1', '1', '0', '1111', 'e9c671ae12574feba5320bb7ed19a0f7', '2016-07-17 21:42:42');
INSERT INTO `stu_course_flow` VALUES ('100', '19', '14', '0', '1', '1', '0', '1212', '43f1f2023d864add9e94957533b6370c', '2016-07-17 21:53:52');
INSERT INTO `stu_course_flow` VALUES ('101', '20', '14', '0', '1', '1', '0', '1212', '43f1f2023d864add9e94957533b6370c', '2016-07-17 21:53:52');
INSERT INTO `stu_course_flow` VALUES ('102', '17', '1', '0', '28', '1', '0', '···', 'b30d87fc4e0f43f7a75ed75ddd77783a', '2016-07-17 22:16:51');
INSERT INTO `stu_course_flow` VALUES ('103', '17', '1', '0', '28', '1', '0', '121', '3e7b8b52a47e40c6bf10e26e759a0220', '2016-07-17 22:16:56');
INSERT INTO `stu_course_flow` VALUES ('104', '17', '1', '0', '28', '1', '0', '121', 'a4719bda5f0b41c7b4e44d58855509d3', '2016-07-17 22:17:01');
INSERT INTO `stu_course_flow` VALUES ('105', '17', '1', '0', '28', '1', '0', '1212', '6fadf1615ea14982ab1c94d8dc543e08', '2016-07-17 22:17:05');
INSERT INTO `stu_course_flow` VALUES ('106', '17', '1', '0', '28', '1', '0', '1212', 'a483554bd8e14aa588b3c02106163ac9', '2016-07-17 22:17:09');
INSERT INTO `stu_course_flow` VALUES ('107', '17', '1', '0', '28', '1', '0', '1212', '2991607070814da0a7fd532752c133c6', '2016-07-17 22:17:13');
INSERT INTO `stu_course_flow` VALUES ('108', '17', '1', '0', '28', '1', '0', '1212', '74c90f64be3e4a69b24d503bf484c4d5', '2016-07-17 22:17:20');
INSERT INTO `stu_course_flow` VALUES ('109', '17', '1', '0', '28', '1', '0', '12121', 'cd2568e79cb047eb98fea31aa09b8a1b', '2016-07-17 22:17:24');
INSERT INTO `stu_course_flow` VALUES ('110', '17', '1', '0', '28', '1', '0', '1212', '97965513fb4e48d0ae780800ef7e0632', '2016-07-17 22:17:29');
INSERT INTO `stu_course_flow` VALUES ('111', '17', '1', '0', '28', '1', '0', '1212', '29ee5f4ce0744a8da3ce78c3b7776c2e', '2016-07-17 22:17:33');
INSERT INTO `stu_course_flow` VALUES ('112', '17', '1', '0', '28', '1', '0', '1212', '67be8ac64cb24a0da4f45038147e45ef', '2016-07-17 22:17:38');
INSERT INTO `stu_course_flow` VALUES ('113', '17', '1', '0', '28', '1', '0', '1212', '8d238c1792e048739a434967d2627ca7', '2016-07-17 22:17:42');
INSERT INTO `stu_course_flow` VALUES ('114', '19', '14', '0', '1', '1', '0', 'asfd 34t区而过', '758b4372c6a84f73b8fe51546634737f', '2016-07-18 11:25:57');
INSERT INTO `stu_course_flow` VALUES ('115', '20', '14', '0', '1', '1', '0', 'asfd 34t区而过', '758b4372c6a84f73b8fe51546634737f', '2016-07-18 11:25:57');
INSERT INTO `stu_course_flow` VALUES ('116', '19', '14', '1', '1', '10', '222', '阿斯蒂芬', '15b0056f0fa74887b53f6362d6400f7d', '2016-07-18 11:30:49');
INSERT INTO `stu_course_flow` VALUES ('117', '19', '14', '1', '1', '1', '100', '121撒地方', 'd7b42ec91daa4c48956305c90625c3ab', '2016-07-18 11:32:03');
INSERT INTO `stu_course_flow` VALUES ('118', '26', '1', '1', '1', '12', '120', '充值12节钢琴课', 'f46806355d884b78852a234eb0006fab', '2016-07-18 13:59:07');
INSERT INTO `stu_course_flow` VALUES ('119', '26', '2', '1', '1', '5', '300', '充值5节拉丁课', 'b9001125c90747aea481a3bb206b1c1d', '2016-07-18 13:59:30');
INSERT INTO `stu_course_flow` VALUES ('120', '27', '1', '1', '1', '12', '1200', '充值10节钢琴', 'bb115077086f4fc3a0952f9d446b5fc2', '2016-07-18 14:01:12');
INSERT INTO `stu_course_flow` VALUES ('121', '26', '1', '0', '1', '1', '0', '20160718周一上了一节课', 'ae0b5fc8e4b44feeb571ea1ca2967867', '2016-07-18 14:04:16');
INSERT INTO `stu_course_flow` VALUES ('122', '27', '1', '0', '1', '2', '0', '20160718周一上了两节课', 'b551e7e6a3914c42a4cb299e192535a2', '2016-07-18 14:04:32');
INSERT INTO `stu_course_flow` VALUES ('123', '26', '1', '0', '1', '1', '0', '周一又上上一节课', '9bf9ba56a61a4fb98cd1f55d9e978c8d', '2016-07-18 14:04:58');
INSERT INTO `stu_course_flow` VALUES ('124', '26', '2', '0', '28', '3', '0', '20160718周一上了3节拉丁课', '58a05f0474834f36a9cbc7fe1650562c', '2016-07-18 14:06:07');

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
) ENGINE=InnoDB AUTO_INCREMENT=29 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of stu_course_remain
-- ----------------------------
INSERT INTO `stu_course_remain` VALUES ('1', '1', '1', '30', '0', '2016-06-26 11:16:53', null);
INSERT INTO `stu_course_remain` VALUES ('2', '2', '1', '-1', '31', '2016-06-26 11:17:04', '2016-07-04 22:47:26');
INSERT INTO `stu_course_remain` VALUES ('3', '3', '3', '10', '12', '2016-06-26 12:30:07', '2016-07-17 21:17:19');
INSERT INTO `stu_course_remain` VALUES ('4', '5', '2', '12', '18', '2016-06-26 22:06:40', null);
INSERT INTO `stu_course_remain` VALUES ('5', '15', '2', '18', '12', '2016-06-26 22:06:51', null);
INSERT INTO `stu_course_remain` VALUES ('6', '16', '4', '10', '0', '2016-06-28 21:22:42', null);
INSERT INTO `stu_course_remain` VALUES ('7', '16', '5', '3', '0', '2016-06-28 21:28:02', null);
INSERT INTO `stu_course_remain` VALUES ('9', '17', '1', '269', '27', '2016-06-28 21:32:37', '2016-07-17 22:17:42');
INSERT INTO `stu_course_remain` VALUES ('10', '17', '3', '25', '10', '2016-06-28 21:33:53', '2016-07-17 21:18:32');
INSERT INTO `stu_course_remain` VALUES ('11', '17', '2', '0', '11', '2016-06-28 23:07:01', '2016-07-17 21:19:28');
INSERT INTO `stu_course_remain` VALUES ('12', '17', '5', '12', '0', '2016-06-28 23:07:11', '2016-06-28 23:07:41');
INSERT INTO `stu_course_remain` VALUES ('13', '18', '2', '0', '10', '2016-07-04 23:39:43', '2016-07-17 21:19:28');
INSERT INTO `stu_course_remain` VALUES ('14', '19', '14', '14', '12', '2016-07-04 23:53:27', '2016-07-18 11:32:03');
INSERT INTO `stu_course_remain` VALUES ('15', '20', '14', '0', '10', '2016-07-04 23:54:08', '2016-07-18 11:25:57');
INSERT INTO `stu_course_remain` VALUES ('16', '21', '15', '50', '2', '2016-07-04 23:54:44', '2016-07-17 15:10:30');
INSERT INTO `stu_course_remain` VALUES ('17', '22', '15', '-1', '12', '2016-07-04 23:54:58', '2016-07-17 15:10:22');
INSERT INTO `stu_course_remain` VALUES ('18', '23', '5', '11', '0', '2016-07-05 23:34:17', null);
INSERT INTO `stu_course_remain` VALUES ('19', '25', '15', '1', '0', '2016-07-17 15:09:49', null);
INSERT INTO `stu_course_remain` VALUES ('20', '24', '15', '1', '0', '2016-07-17 15:10:00', null);
INSERT INTO `stu_course_remain` VALUES ('21', '23', '15', '1', '0', '2016-07-17 15:10:09', null);
INSERT INTO `stu_course_remain` VALUES ('22', '19', '15', '1', '0', '2016-07-17 15:10:37', null);
INSERT INTO `stu_course_remain` VALUES ('26', '26', '1', '10', '2', '2016-07-18 13:59:07', '2016-07-18 14:04:58');
INSERT INTO `stu_course_remain` VALUES ('27', '26', '2', '2', '3', '2016-07-18 13:59:30', '2016-07-18 14:06:07');
INSERT INTO `stu_course_remain` VALUES ('28', '27', '1', '10', '2', '2016-07-18 14:01:12', '2016-07-18 14:04:32');

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
INSERT INTO `teacher_work_flow` VALUES ('270fb277cb1746c1bd4acd3c90246f9b', '1', '14', '2', '2', '我爱我家', '2016-07-17 21:31:09');
INSERT INTO `teacher_work_flow` VALUES ('2991607070814da0a7fd532752c133c6', '28', '1', '1', '1', '1212', '2016-07-17 22:17:13');
INSERT INTO `teacher_work_flow` VALUES ('29ee5f4ce0744a8da3ce78c3b7776c2e', '28', '1', '1', '1', '1212', '2016-07-17 22:17:33');
INSERT INTO `teacher_work_flow` VALUES ('2c7f5351a80e448687b8c4021ff7973a', '28', '1', '1', '1', '分阿斯蒂芬', '2016-07-17 21:27:07');
INSERT INTO `teacher_work_flow` VALUES ('3e7b8b52a47e40c6bf10e26e759a0220', '28', '1', '1', '1', '121', '2016-07-17 22:16:56');
INSERT INTO `teacher_work_flow` VALUES ('43f1f2023d864add9e94957533b6370c', '1', '14', '1', '2', '1212', '2016-07-17 21:53:52');
INSERT INTO `teacher_work_flow` VALUES ('58a05f0474834f36a9cbc7fe1650562c', '28', '2', '3', '1', '20160718周一上了3节拉丁课', '2016-07-18 14:06:07');
INSERT INTO `teacher_work_flow` VALUES ('590ec5dc8e474d778621b365a77872d6', '28', '1', '1', '1', '按时发的问问', '2016-07-17 21:25:14');
INSERT INTO `teacher_work_flow` VALUES ('60f75fb3ea654e81813a379ce7da277d', '28', '3', '2', '1', '按时发的', '2016-07-17 21:18:32');
INSERT INTO `teacher_work_flow` VALUES ('67be8ac64cb24a0da4f45038147e45ef', '28', '1', '1', '1', '1212', '2016-07-17 22:17:38');
INSERT INTO `teacher_work_flow` VALUES ('6fadf1615ea14982ab1c94d8dc543e08', '28', '1', '1', '1', '1212', '2016-07-17 22:17:05');
INSERT INTO `teacher_work_flow` VALUES ('74c90f64be3e4a69b24d503bf484c4d5', '28', '1', '1', '1', '1212', '2016-07-17 22:17:20');
INSERT INTO `teacher_work_flow` VALUES ('758b4372c6a84f73b8fe51546634737f', '1', '14', '1', '2', 'asfd 34t区而过', '2016-07-18 11:25:57');
INSERT INTO `teacher_work_flow` VALUES ('820a9a862d9341b7ad599fdc2472d552', '28', '3', '1', '1', '6月18号，上课2节', '2016-07-17 21:17:19');
INSERT INTO `teacher_work_flow` VALUES ('8d238c1792e048739a434967d2627ca7', '28', '1', '1', '1', '1212', '2016-07-17 22:17:42');
INSERT INTO `teacher_work_flow` VALUES ('8e2230caf80e4e8993b91d6037728802', '28', '1', '1', '1', '二哥', '2016-07-17 21:20:31');
INSERT INTO `teacher_work_flow` VALUES ('97965513fb4e48d0ae780800ef7e0632', '28', '1', '1', '1', '1212', '2016-07-17 22:17:29');
INSERT INTO `teacher_work_flow` VALUES ('9bf9ba56a61a4fb98cd1f55d9e978c8d', '1', '1', '1', '1', '周一又上上一节课', '2016-07-18 14:04:58');
INSERT INTO `teacher_work_flow` VALUES ('a4719bda5f0b41c7b4e44d58855509d3', '28', '1', '1', '1', '121', '2016-07-17 22:17:01');
INSERT INTO `teacher_work_flow` VALUES ('a483554bd8e14aa588b3c02106163ac9', '28', '1', '1', '1', '1212', '2016-07-17 22:17:09');
INSERT INTO `teacher_work_flow` VALUES ('ae0b5fc8e4b44feeb571ea1ca2967867', '1', '1', '1', '1', '20160718周一上了一节课', '2016-07-18 14:04:16');
INSERT INTO `teacher_work_flow` VALUES ('b30d87fc4e0f43f7a75ed75ddd77783a', '28', '1', '1', '1', '···', '2016-07-17 22:16:51');
INSERT INTO `teacher_work_flow` VALUES ('b352b5a47c8f42c49f5e689a68e4ea56', '28', '1', '1', '1', '区分', '2016-07-17 21:22:40');
INSERT INTO `teacher_work_flow` VALUES ('b551e7e6a3914c42a4cb299e192535a2', '1', '1', '2', '1', '20160718周一上了两节课', '2016-07-18 14:04:32');
INSERT INTO `teacher_work_flow` VALUES ('cd2568e79cb047eb98fea31aa09b8a1b', '28', '1', '1', '1', '12121', '2016-07-17 22:17:24');
INSERT INTO `teacher_work_flow` VALUES ('e0a14fe792a2477db09f88dd413c347f', '28', '1', '1', '1', '温柔俺323', '2016-07-17 21:21:55');
INSERT INTO `teacher_work_flow` VALUES ('e685df2b8c234df8a465778fddd08619', '28', '3', '4', '1', '天天', '2016-07-17 21:18:10');
INSERT INTO `teacher_work_flow` VALUES ('e9c671ae12574feba5320bb7ed19a0f7', '1', '14', '1', '2', '1111', '2016-07-17 21:42:42');
INSERT INTO `teacher_work_flow` VALUES ('f2426c0b2a0341f58618af76ba9a5bdc', '28', '2', '2', '2', '哈哈', '2016-07-17 21:19:10');
INSERT INTO `teacher_work_flow` VALUES ('fe495162af954f988c69842bd5fa88f4', '28', '2', '2', '2', '按时发的无法', '2016-07-17 21:19:28');

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
  PRIMARY KEY (`id`),
  UNIQUE KEY `account_unique` (`account`),
  UNIQUE KEY `name` (`name`)
) ENGINE=InnoDB AUTO_INCREMENT=29 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of user
-- ----------------------------
INSERT INTO `user` VALUES ('1', '19012402', 'b9979d181ac6cad9c8304df14c273d77', 'kevin', '17707119188', '1', '2016-06-23', '1,2,14,15', '1', '我是管理员', '2016-06-23 22:44:24', '2016-07-18 14:02:48');
INSERT INTO `user` VALUES ('2', '19012403', '883fc99983773cfcc6c33bdf0b2ec010', 'tony', '18890877678', '0', '2016-06-23', '15', '1', 'i am tony', '2016-06-23 22:46:13', '2016-06-25 22:25:19');
INSERT INTO `user` VALUES ('3', '19012404', '883fc99983773cfcc6c33bdf0b2ec010', '何晓', '15563698256', '0', '2016-06-24', '2', '1', '12121', '2016-06-24 16:09:44', '2016-07-05 23:37:53');
INSERT INTO `user` VALUES ('4', '19011111', '883fc99983773cfcc6c33bdf0b2ec010', '天下', '17705177022', '0', '2016-06-16', '1,14', '1', '', '2016-06-24 23:18:42', '2016-06-25 19:09:54');
INSERT INTO `user` VALUES ('26', '19101120', '883fc99983773cfcc6c33bdf0b2ec010', '刘老师', '18977886789', '0', '2016-06-01', '1,4', '1', '刘老师擅长钢琴和tango', '2016-06-26 22:34:02', null);
INSERT INTO `user` VALUES ('27', '1112', '883fc99983773cfcc6c33bdf0b2ec010', '22', '1112', '0', '2016-06-22', '1,14', '0', '222', '2016-06-27 15:06:19', '2016-06-27 21:37:18');
INSERT INTO `user` VALUES ('28', '113', 'b9979d181ac6cad9c8304df14c273d77', '我老师', '19088998876', '0', '2016-06-01', '1,2,3,4', '1', 'asfd', '2016-06-28 21:38:04', '2016-06-30 21:56:05');
