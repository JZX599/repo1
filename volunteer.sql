/*
 Navicat Premium Data Transfer

 Source Server         : localhost_3306
 Source Server Type    : MySQL
 Source Server Version : 50027
 Source Host           : localhost:3306
 Source Schema         : volunteer

 Target Server Type    : MySQL
 Target Server Version : 50027
 File Encoding         : 65001

 Date: 06/06/2020 00:17:52
*/

SET NAMES utf8mb4;
SET FOREIGN_KEY_CHECKS = 0;

-- ----------------------------
-- Table structure for activity
-- ----------------------------
DROP TABLE IF EXISTS `activity`;
CREATE TABLE `activity`  (
  `AId` int(20) NOT NULL AUTO_INCREMENT COMMENT '活动表id',
  `AName` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL DEFAULT '' COMMENT '活动名称',
  `OId` int(20) NOT NULL DEFAULT '' COMMENT '组织id',
  `AStartDate` varchar(20) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL DEFAULT '' COMMENT '活动开始时间',
  `AEndDate` varchar(20) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL DEFAULT '' COMMENT '活动结束时间',
  `APerson` varchar(20) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL DEFAULT '' COMMENT '活动联系人',
  `APhone` varchar(20) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL DEFAULT '' COMMENT '活动联系人电话',
  `AEstimate` int(20) NOT NULL DEFAULT 0 COMMENT '活动预计招募人数',
  `AIntegral` int(20) NOT NULL DEFAULT 0 COMMENT '活动积分',
  `ASynopsis` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '活动简介',
  `AKzTime` varchar(20) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL DEFAULT '' COMMENT '开始招募时间',
  `AHours` double(255, 2) NOT NULL DEFAULT '' COMMENT '活动时长',
  `AAddress` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '活动地址',
  `CId` int(20) NOT NULL DEFAULT '' COMMENT '分类id',
  PRIMARY KEY USING BTREE (`AId`),
  INDEX `for_act_oid` USING BTREE(`OId`),
  INDEX `for_act_cid` USING BTREE(`CId`),
  CONSTRAINT `for_act_cid` FOREIGN KEY (`CId`) REFERENCES `category` (`CId`) ON DELETE RESTRICT ON UPDATE RESTRICT,
  CONSTRAINT `for_act_oid` FOREIGN KEY (`OId`) REFERENCES `organize` (`OId`) ON DELETE CASCADE ON UPDATE RESTRICT
) ENGINE = InnoDB AUTO_INCREMENT = 631 CHARACTER SET = utf8 COLLATE = utf8_general_ci COMMENT = 'InnoDB free: 8192 kB; (`CId`) REFER `volunteer/category`(`CId`); (`OId`) REFER `' ROW_FORMAT = Compact;

-- ----------------------------
-- Records of activity
-- ----------------------------
INSERT INTO `activity` VALUES (11, '防控新型冠状病毒1', 1, '2020-03-05 23:31:40', '2020-03-06 23:31:40', '小王1', '18650170313', 20, 20, '帮助每个需要帮助的人', '2020-03-03 23:31:40', 24.00, '集美区孙坂南路1', 1);
INSERT INTO `activity` VALUES (13, '防控新型冠状病毒2', 1, '2020-03-09 23:31:40', '2020-03-10 23:31:40', '小王2', '18650170313', 20, 30, '帮助每个需要帮助的人', '2020-03-07 23:31:40', 24.00, '集美区孙坂南路2', 2);
INSERT INTO `activity` VALUES (15, '防控新型冠状病毒3', 1, '2020-03-19 23:31:40', '2020-03-20 23:31:40', '小王3', '18650170313', 3, 50, '帮助每个需要帮助的人', '2020-03-16 23:31:40', 24.00, '集美区孙坂南路3', 3);
INSERT INTO `activity` VALUES (18, '防控新型冠状病毒4', 1, '2020-03-05 23:31:40', '2020-03-06 23:31:44', '小王4', '18650170313', 56, 56, '帮助每个需要帮助的人', '2020-03-05 23:31:40', 24.00, '集美区孙坂南路4', 4);
INSERT INTO `activity` VALUES (19, '防控新型冠状病毒5', 1, '2020-03-05 23:31:40', '2020-03-06 23:31:44', '小王5', '18650170313', 56, 56, '帮助每个需要帮助的人', '2020-03-05 23:31:40', 24.00, '集美区孙坂南路5', 5);
INSERT INTO `activity` VALUES (33, '防控新型冠状病毒6', 1, '2020-03-14 22:52:45', '2020-03-14 23:52:28', '小王6', '18650170313', 22, 10, '帮助每个需要帮助的人', '2020-03-05 23:31:40', 1.00, '集美区孙坂南路6', 6);
INSERT INTO `activity` VALUES (35, '防控新型冠状病毒7', 8, '2020-03-05 23:31:40', '2020-03-06 23:31:44', '小王7', '18650170313', 55, 56, '帮助每个需要帮助的人', '2020-03-05 23:31:40', 24.00, '集美区孙坂南路7', 7);
INSERT INTO `activity` VALUES (44, '防控新型冠状病毒8', 9, '2020-03-05 20:31:40', '2020-03-05 23:31:44', '小王8', '18650170313', 55, 10, '帮助每个需要帮助的人', '2020-03-05 23:31:40', 3.00, '集美区孙坂南路8', 8);
INSERT INTO `activity` VALUES (55, '防控新型冠状病毒9', 7, '2020-03-05 23:31:40', '2020-03-06 23:31:44', '小王9', '18650170313', 55, 10, '帮助每个需要帮助的人', '2020-03-05 23:31:40', 24.00, '集美区孙坂南路9', 9);
INSERT INTO `activity` VALUES (88, '防控新型冠状病毒5', 3, '2020-03-05 23:31:40', '2020-03-12 23:31:44', '小王10', '18650170313', 56, 56, '帮助每个需要帮助的人', '2020-03-05 23:31:40', 0.00, '集美区孙坂南路10', 10);
INSERT INTO `activity` VALUES (90, '防控新型冠状病毒6', 1, '2020-03-19 13:41:43', '2020-03-19 16:41:43', '小王11', '18650170313', 33, 22, '帮助每个需要帮助的人', '2020-03-15 23:31:40', 3.00, '集美区孙坂南路11', 11);
INSERT INTO `activity` VALUES (91, '防控新型冠状病毒7', 1, '2020-03-19 13:41:43', '2020-03-19 18:41:43', '小王12', '18650170313', 33, 22, '帮助每个需要帮助的人', '2020-03-15 23:31:40', 5.00, '集美区孙坂南路12', 12);
INSERT INTO `activity` VALUES (92, '防控新型冠状病毒8', 1, '2020-03-19 13:41:43', '2020-03-19 15:41:43', '小王13', '18650170313', 33, 22, '帮助每个需要帮助的人', '2020-03-15 23:31:40', 2.00, '集美区孙坂南路13', 13);
INSERT INTO `activity` VALUES (93, '防控新型冠状病毒9', 4, '2020-03-19 13:41:43', '2020-03-19 14:41:43', '小王14', '18650170313', 33, 22, '帮助每个需要帮助的人', '2020-03-15 23:31:40', 1.00, '集美区孙坂南路14', 14);
INSERT INTO `activity` VALUES (94, '防控新型冠状病毒10', 1, '2020-03-19 13:41:43', '2020-03-19 15:41:43', '小王15', '18650170313', 33, 22, '帮助每个需要帮助的人', '2020-03-15 23:31:40', 2.00, '集美区孙坂南路15', 15);
INSERT INTO `activity` VALUES (95, '防控新型冠状病毒11', 1, '2020-03-19 13:41:43', '2020-03-19 16:41:43', '小王16', '18650170313', 33, 22, '帮助每个需要帮助的人', '2020-03-15 23:31:40', 3.00, '集美区孙坂南路16', 16);
INSERT INTO `activity` VALUES (96, '防控新型冠状病毒12', 1, '2020-03-19 13:41:43', '2020-03-19 19:41:43', '小王22', '18650170313', 33, 22, '帮助每个需要帮助的人', '2020-03-15 23:31:40', 6.00, '集美区孙坂南路17', 17);
INSERT INTO `activity` VALUES (97, '防控新型冠状病毒13', 5, '2020-03-19 13:41:43', '2020-03-19 18:41:43', '小王24', '18650170313', 33, 22, '帮助每个需要帮助的人', '2020-03-15 23:31:40', 5.00, '集美区孙坂南路18', 3);
INSERT INTO `activity` VALUES (98, '防控新型冠状病毒14', 1, '2020-03-19 13:41:43', '2020-03-19 14:41:43', '小王25', '18650170313', 33, 22, '帮助每个需要帮助的人', '2020-03-15 23:31:40', 1.00, '集美区孙坂南路19', 3);
INSERT INTO `activity` VALUES (111, '防控新型冠状病毒15', 2, '2020-03-24 15:35:20', '2020-03-26 15:35:20', '小王27', '18650170313', 5, 6, '帮助每个需要帮助的人', '2020-03-21 02:53:29', 48.00, '集美区孙坂南路20', 3);
INSERT INTO `activity` VALUES (122, '防控新型冠状病毒16', 2, '2020-03-10 15:34:53', '2020-03-11 15:34:58', '小王28', '18650170313', 0, 0, '帮助每个需要帮助的人', '2020-03-05 23:31:40', 24.00, '集美区孙坂南路109', 3);
INSERT INTO `activity` VALUES (123, '防控新型冠状病毒17', 6, '2020-03-10 15:34:31', '2020-03-10 18:34:33', '小王29', '18650170313', 0, 0, '帮助每个需要帮助的人', '2020-03-05 23:31:40', 3.00, '集美区孙坂南路110', 3);
INSERT INTO `activity` VALUES (333, '防控新型冠状病毒18', 2, '2020-03-10 15:33:34', '2020-03-10 16:33:36', '小王30', '18650170313', 33, 44, '帮助每个需要帮助的人', '2020-03-05 23:31:40', 1.00, '集美区孙坂南路111', 3);
INSERT INTO `activity` VALUES (444, '防控新型冠状病毒19', 2, '2020-03-10 15:32:52', '2020-03-26 17:32:55', '小王31', '18650170313', 33, 33, '帮助每个需要帮助的人', '2020-03-05 23:31:40', 2.00, '集美区孙坂南路112', 3);
INSERT INTO `activity` VALUES (555, '防控新型冠状病毒20', 2, '2020-03-10 15:34:06', '2020-03-10 16:34:08', '小王32', '18650170313', 22, 0, '帮助每个需要帮助的人', '2020-03-15 23:31:40', 1.00, '集美区孙坂南路113', 3);
INSERT INTO `activity` VALUES (556, '防控新型冠状病毒109', 1, '2020-03-19 12:26:53', '2020-03-20 12:26:55', '小王33', '18650170313', 22, 33, '帮助每个需要帮助的人', '2020-03-05 23:31:40', 24.00, '集美区孙坂南路114', 12);
INSERT INTO `activity` VALUES (557, '防控新型冠状病毒110', 1, '2020-03-19 23:31:40', '2020-03-31 04:03:58', '小王34', '18650170313', 22, 33, '帮助每个需要帮助的人', '2020-03-05 23:31:40', 5.00, '集美区孙坂南路115', 7);
INSERT INTO `activity` VALUES (558, '防控新型冠状病毒111', 1, '2020-03-05 23:31:40', '2020-03-05 23:31:40', '小王35', '18650170313', 156, 55, '帮助每个需要帮助的人', '2020-03-05 23:31:40', 55.00, '集美区孙坂南路116', 7);
INSERT INTO `activity` VALUES (559, '防控新型冠状病毒112', 1, '2020-03-13 16:19:50', '2020-03-13 23:31:44', '小王36', '18650170313', 22, 33, '帮助每个需要帮助的人', '2020-03-12 04:11:28', 7.20, '集美区孙坂南路117', 7);
INSERT INTO `activity` VALUES (600, '防控新型冠状病毒123', 1, '2020-03-10 13:41:43', '2020-03-28 13:41:43', '小王37', '18650170313', 66, 66, '帮助每个需要帮助的人', '2020-03-09 13:41:43', 5.00, '集美区孙坂南路116', 7);
INSERT INTO `activity` VALUES (601, '防控新型冠状病毒124', 2, '2020-03-19 13:41:43', '2020-03-20 23:31:44', '小王38', '18650170313', 22, 33, '帮助每个需要帮助的人', '2020-03-14 03:16:40', 33.83, '集美区孙坂南路118', 7);
INSERT INTO `activity` VALUES (602, '防控新型冠状病毒125', 1, '2020-03-26 13:46:43', '2020-03-27 23:31:44', '小王41', '18650170313', 22, 33, '帮助每个需要帮助的人', '2020-03-25 04:09:50', 33.75, '集美区孙坂南路119', 7);
INSERT INTO `activity` VALUES (603, '防控新型冠状病毒126', 1, '2020-03-19 23:31:40', '2020-03-20 23:31:44', '小王42', '18650170313', 22, 33, '帮助每个需要帮助的人', '2020-03-18 07:23:00', 24.00, '集美区孙坂南路120', 7);
INSERT INTO `activity` VALUES (604, '防控新型冠状病毒127', 3, '2020-03-30 20:01:31', '2020-03-30 23:31:44', '小王43', '18650170313', 22, 33, '帮助每个需要帮助的人', '2020-03-28 08:02:10', 3.50, '集美区孙坂南路121', 10);
INSERT INTO `activity` VALUES (605, '防控新型冠状病毒128', 1, '2020-04-06 18:07:02', '2020-04-07 18:07:13', '小王44', '18650170313', 22, 33, '帮助每个需要帮助的人', '2020-04-03 06:07:30', 24.00, '集美区孙坂南路122', 11);
INSERT INTO `activity` VALUES (606, '防控新型冠状病毒222', 5, '2020-04-15 10:00:00', '2020-04-15 18:00:00', '小王66', '18650170231', 66, 66, '组织志愿者在路口检查车辆', '2020-04-12 18:00:00', 8.00, '湖里区围里', 6);
INSERT INTO `activity` VALUES (607, '防控新型冠状病毒777', 9, '2020-04-13 10:00:00', '2020-04-18 10:00:00', '小王77', '18650170212', 20, 30, '组织志愿者在路口检查车辆', '2020-04-11 10:00:00', 96.00, '思明区龙头路', 6);
INSERT INTO `activity` VALUES (608, '防控新型冠状病毒999', 3, '2020-04-20 23:31:40', '2020-04-21 23:31:44', '江智鑫', '18650170313', 15, 60, '6帮助每个需要帮助的人', '2020-04-17 02:39:36', 24.00, '集美区孙坂南路1199号', 6);
INSERT INTO `activity` VALUES (609, '防控新型冠状病毒99', 3, '2020-04-15 23:31:40', '2020-04-20 23:31:40', '江智鑫', '18650170313', 15, 60, '帮助每个需要帮助的人', '2020-04-13 23:31:40', 60.00, '集美区孙坂南路1199号', 6);
INSERT INTO `activity` VALUES (610, '新建活动4.25', 1, '2020-04-27 13:24:48', '2020-04-28 13:24:58', '江智鑫', '18650170313', 33, 60, '治安巡逻', '2020-04-25 01:39:25', 24.00, '集美区孙坂南路1199号', 5);
INSERT INTO `activity` VALUES (611, '防火宣传', 1, '2020-05-12 15:59:07', '2020-05-13 15:59:11', '徐培文', '18650170313', 33, 60, '当前是杨絮飘落季，加大宣传杨絮火灾危害性和防灭火常识，引导群众加强消防安全知识学习，提高消防安全常识，倡导日常文明安全用火，不乱丢烟头，火种。', '2020-05-10 04:00:13', 24.00, '栖山镇王梨园村', 1);
INSERT INTO `activity` VALUES (612, '测试', 1, '2020-05-09 15:59:07', '2020-05-10 15:59:07', '江智鑫', '18650170313', 10, 50, '哈哈哈', '2020-05-09 15:59:07', 24.00, '龙海市', 1);
INSERT INTO `activity` VALUES (613, '慰问生活困难农户', 1, '2020-05-13 03:13:02', '2020-05-14 03:13:04', '章景', '18650170616', 15, 60, '集美区社区组织村干部以及志愿者为生活困难农户送去慰问品。', '2020-05-11 03:15:14', 24.00, '集美区孙坂南路1199号', 14);
INSERT INTO `activity` VALUES (614, '义务献血', 1, '2020-05-14 13:31:40', '2020-05-14 23:31:40', '江智鑫', '18650170313', 15, 60, '倡导人人奉献爱心，帮助他人', '2020-05-11 03:18:37', 10.00, '集美区孙坂南路1199号', 1);
INSERT INTO `activity` VALUES (615, '环境卫生整治活动', 1, '2020-05-20 08:31:40', '2020-05-20 18:31:40', '江智鑫', '18650170313', 20, 60, '招募志愿者进行环境卫生清理', '2020-05-11 03:20:38', 10.00, '集美区孙坂南路1199号', 9);
INSERT INTO `activity` VALUES (616, '无物业小区修剪花草', 1, '2020-05-23 13:31:40', '2020-05-23 16:31:40', '江智鑫', '18650170313', 20, 20, '无物业小区修剪花草', '2020-05-11 03:22:50', 3.00, '集美区孙坂南路1199号', 9);
INSERT INTO `activity` VALUES (617, '关爱留守老人', 1, '2020-05-24 07:31:40', '2020-05-24 17:31:40', '江智鑫', '18650132665', 5, 20, '组织志愿者对本村留守老人关爱慰问', '2020-05-11 03:27:47', 10.00, '集美区孙坂南路1199号', 5);
INSERT INTO `activity` VALUES (618, '世界无烟日宣传', 1, '2020-06-15 09:31:40', '2020-06-15 20:31:40', '戴丽仪', '13776585278', 15, 60, '宣传吸烟危害，引导市民熄灭手中的烟头，赠扇子送清凉。', '2020-05-31 10:37:54', 11.00, '集美区孙坂南路1199号', 1);
INSERT INTO `activity` VALUES (619, '新冠状病毒疫情防控', 1, '2020-06-02 08:00:00', '2020-06-02 11:00:00', '胡红权', '13905187295', 20, 30, '做好对进出人员的排查、登记、测温等工作，充分发挥在疫情防控工作中党组织的战斗堡垒作用和党员干部的先锋模范作用，守好群众生命安全和身体健康的第一道防线。', '2020-05-31 10:54:57', 3.00, '厦门市湖里区围里', 8);
INSERT INTO `activity` VALUES (620, '抗击疫情-火车站小组', 1, '2020-06-03 12:01:57', '2020-06-03 15:01:57', '吉远春', '13776585278', 15, 30, '服从指挥部安排', '2020-05-31 11:04:30', 15.00, '厦门站', 1);
INSERT INTO `activity` VALUES (621, '整理图书', 1, '2020-06-05 08:00:00', '2020-06-05 18:00:00', '张振刚', '13905187295', 5, 60, '整理图书', '2020-05-31 11:12:13', 10.00, '厦门理工学院图书馆', 1);
INSERT INTO `activity` VALUES (622, '全民健身', 3, '2020-06-05 14:00:00', '2020-06-05 18:00:00', '庞勤', '18066193019', 5, 20, '全民健身', '2020-05-31 11:38:08', 4.00, '厦门思明区湖滨东路408号', 7);
INSERT INTO `activity` VALUES (623, '垃圾分类', 3, '2020-06-08 08:00:00', '2020-06-08 18:00:00', '朱永', '13776585278', 20, 60, '', '2020-05-31 11:46:30', 10.00, '厦门市湖里区围里', 10);
INSERT INTO `activity` VALUES (624, '义务献血', 3, '2020-06-09 08:00:00', '2020-06-09 18:00:00', '李晓龙', '13776758159', 50, 60, '倡导人人参与，帮助他人', '2020-05-31 11:49:34', 10.00, '厦门市思明区', 1);
INSERT INTO `activity` VALUES (625, '环境空间治理', 3, '2020-06-10 09:00:00', '2020-06-10 19:00:00', '徐培文', '18650132665', 20, 60, '环境空间治理', '2020-05-31 11:52:37', 10.00, '厦门市湖里区围里', 10);
INSERT INTO `activity` VALUES (626, '志愿者普法宣传', 3, '2020-06-10 11:00:00', '2020-06-10 12:30:00', '杨晓丽', '13776585278', 5, 20, '志愿者普法宣传', '2020-06-01 12:21:23', 1.50, '集美区孙坂南路1199号', 11);
INSERT INTO `activity` VALUES (627, '美丽中国，我是行动者1', 1, '2020-06-07 08:56:58', '2020-06-07 09:57:06', '惠慧', '13776585278', 20, 60, '六五环境日 弘扬生态文化和生态道德 倡导生态价值观念\r\n', '2020-06-05 09:00:34', 1.02, '集美区孙坂南路1199号', 1);
INSERT INTO `activity` VALUES (630, '无拘无塑环保志愿活动', 1, '2020-06-12 15:30:00', '2020-06-12 17:30:00', '江智鑫', '18650170313', 20, 60, '1111', '2020-06-05 02:43:21', 2.00, '集美区孙坂南路1199号', 3);

-- ----------------------------
-- Table structure for admin
-- ----------------------------
DROP TABLE IF EXISTS `admin`;
CREATE TABLE `admin`  (
  `AId` int(20) NOT NULL AUTO_INCREMENT COMMENT '系统管理员id',
  `AName` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL DEFAULT '' COMMENT '账户名',
  `APwd` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL DEFAULT '' COMMENT '密码',
  `APower` int(1) NOT NULL DEFAULT 0 COMMENT '0为普通1为超级',
  PRIMARY KEY USING BTREE (`AId`)
) ENGINE = InnoDB AUTO_INCREMENT = 25 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Compact;

-- ----------------------------
-- Records of admin
-- ----------------------------
INSERT INTO `admin` VALUES (1, '超级管理员1', 'f379eaf3c831b04de153469d1bec345e', 1);
INSERT INTO `admin` VALUES (2, 'i志愿管理员2', 'f379eaf3c831b04de153469d1bec345e', 0);
INSERT INTO `admin` VALUES (3, 'i志愿管理员3', 'f379eaf3c831b04de153469d1bec345e', 0);
INSERT INTO `admin` VALUES (4, 'i志愿管理员4', 'f379eaf3c831b04de153469d1bec345e', 0);
INSERT INTO `admin` VALUES (5, 'i志愿管理员5', 'f379eaf3c831b04de153469d1bec345e', 0);
INSERT INTO `admin` VALUES (6, 'i志愿管理员6', 'f379eaf3c831b04de153469d1bec345e', 1);
INSERT INTO `admin` VALUES (7, 'i志愿管理员7', 'f379eaf3c831b04de153469d1bec345e', 0);
INSERT INTO `admin` VALUES (8, 'i志愿管理员8', 'f379eaf3c831b04de153469d1bec345e', 0);
INSERT INTO `admin` VALUES (9, 'i志愿管理员9', 'f379eaf3c831b04de153469d1bec345e', 0);
INSERT INTO `admin` VALUES (11, 'i志愿管理员11', 'f379eaf3c831b04de153469d1bec345e', 0);
INSERT INTO `admin` VALUES (12, 'i志愿管理员12', 'f379eaf3c831b04de153469d1bec345e', 0);
INSERT INTO `admin` VALUES (13, 'i志愿管理员13', 'f379eaf3c831b04de153469d1bec345e', 1);
INSERT INTO `admin` VALUES (14, 'i志愿管理员14', 'f379eaf3c831b04de153469d1bec345e', 0);
INSERT INTO `admin` VALUES (15, 'i志愿管理员15', 'f379eaf3c831b04de153469d1bec345e', 1);
INSERT INTO `admin` VALUES (16, 'i志愿管理员16', 'f379eaf3c831b04de153469d1bec345e', 0);
INSERT INTO `admin` VALUES (17, 'i志愿管理员17', 'f379eaf3c831b04de153469d1bec345e', 0);
INSERT INTO `admin` VALUES (18, 'i志愿管理员18', 'f379eaf3c831b04de153469d1bec345e', 0);
INSERT INTO `admin` VALUES (19, 'i志愿管理员19', 'f379eaf3c831b04de153469d1bec345e', 0);
INSERT INTO `admin` VALUES (20, 'i志愿管理员20', 'f379eaf3c831b04de153469d1bec345e', 0);
INSERT INTO `admin` VALUES (21, 'i志愿管理员21', 'f379eaf3c831b04de153469d1bec345e', 0);

-- ----------------------------
-- Table structure for category
-- ----------------------------
DROP TABLE IF EXISTS `category`;
CREATE TABLE `category`  (
  `CId` int(20) NOT NULL AUTO_INCREMENT COMMENT '分类id',
  `CName` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL DEFAULT '' COMMENT '分类名称',
  PRIMARY KEY USING BTREE (`CId`)
) ENGINE = InnoDB AUTO_INCREMENT = 19 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Compact;

-- ----------------------------
-- Records of category
-- ----------------------------
INSERT INTO `category` VALUES (1, '文明实践');
INSERT INTO `category` VALUES (2, '法律咨询');
INSERT INTO `category` VALUES (3, '维权服务');
INSERT INTO `category` VALUES (4, '心理健康');
INSERT INTO `category` VALUES (5, '敬老助残');
INSERT INTO `category` VALUES (6, '文化娱乐');
INSERT INTO `category` VALUES (7, '全民健身');
INSERT INTO `category` VALUES (8, '治安巡逻');
INSERT INTO `category` VALUES (9, '环保绿化');
INSERT INTO `category` VALUES (10, '卫生保洁');
INSERT INTO `category` VALUES (11, '教育培训');
INSERT INTO `category` VALUES (12, '纠纷调解');
INSERT INTO `category` VALUES (13, '减灾救灾');
INSERT INTO `category` VALUES (14, '扶贫济困');
INSERT INTO `category` VALUES (15, '科技创新');
INSERT INTO `category` VALUES (16, '医疗保健');
INSERT INTO `category` VALUES (17, '其他');

-- ----------------------------
-- Table structure for enlist
-- ----------------------------
DROP TABLE IF EXISTS `enlist`;
CREATE TABLE `enlist`  (
  `EId` int(20) NOT NULL AUTO_INCREMENT COMMENT '活动报名表id',
  `UId` int(20) NOT NULL DEFAULT '' COMMENT '用户id',
  `AId` int(20) NOT NULL DEFAULT '' COMMENT '活动id',
  `EState` int(1) NOT NULL DEFAULT 0 COMMENT '活动报名状态0已报名1已通过2已拒绝',
  `EFlag` int(1) NOT NULL DEFAULT 0 COMMENT '活动参加确认0未确认1通过2未通过',
  `EAssess` int(1) NOT NULL DEFAULT 0 COMMENT '评价确认0未评价1已好评2已差评3已中评',
  PRIMARY KEY USING BTREE (`EId`),
  INDEX `for_user` USING BTREE(`UId`),
  INDEX `for_act` USING BTREE(`AId`),
  CONSTRAINT `for_act` FOREIGN KEY (`AId`) REFERENCES `activity` (`AId`) ON DELETE CASCADE ON UPDATE RESTRICT,
  CONSTRAINT `for_user` FOREIGN KEY (`UId`) REFERENCES `user` (`UId`) ON DELETE CASCADE ON UPDATE RESTRICT
) ENGINE = InnoDB AUTO_INCREMENT = 706 CHARACTER SET = utf8 COLLATE = utf8_general_ci COMMENT = 'InnoDB free: 8192 kB; (`AId`) REFER `volunteer/activity`(`AId`) ON DELETE CASCAD' ROW_FORMAT = Compact;

-- ----------------------------
-- Records of enlist
-- ----------------------------
INSERT INTO `enlist` VALUES (1, 1, 35, 0, 0, 0);
INSERT INTO `enlist` VALUES (2, 2, 19, 1, 2, 0);
INSERT INTO `enlist` VALUES (3, 3, 19, 2, 2, 3);
INSERT INTO `enlist` VALUES (4, 2, 33, 2, 0, 0);
INSERT INTO `enlist` VALUES (5, 3, 33, 1, 1, 2);
INSERT INTO `enlist` VALUES (6, 5, 13, 1, 1, 3);
INSERT INTO `enlist` VALUES (7, 2, 123, 1, 1, 0);
INSERT INTO `enlist` VALUES (8, 3, 333, 0, 0, 0);
INSERT INTO `enlist` VALUES (9, 5, 444, 1, 2, 0);
INSERT INTO `enlist` VALUES (10, 5, 444, 0, 0, 0);
INSERT INTO `enlist` VALUES (11, 5, 444, 0, 0, 0);
INSERT INTO `enlist` VALUES (12, 5, 559, 0, 0, 0);
INSERT INTO `enlist` VALUES (13, 5, 556, 2, 0, 0);
INSERT INTO `enlist` VALUES (14, 5, 557, 2, 0, 0);
INSERT INTO `enlist` VALUES (15, 1, 556, 2, 0, 0);
INSERT INTO `enlist` VALUES (16, 2, 11, 1, 1, 0);
INSERT INTO `enlist` VALUES (17, 3, 600, 1, 2, 0);
INSERT INTO `enlist` VALUES (18, 3, 18, 1, 1, 3);
INSERT INTO `enlist` VALUES (19, 5, 18, 1, 1, 3);
INSERT INTO `enlist` VALUES (20, 1, 555, 1, 1, 0);
INSERT INTO `enlist` VALUES (21, 5, 44, 1, 2, 1);
INSERT INTO `enlist` VALUES (23, 2, 556, 1, 1, 0);
INSERT INTO `enlist` VALUES (24, 3, 95, 1, 1, 1);
INSERT INTO `enlist` VALUES (25, 2, 96, 2, 0, 0);
INSERT INTO `enlist` VALUES (26, 3, 35, 1, 2, 0);
INSERT INTO `enlist` VALUES (27, 1, 44, 1, 1, 2);
INSERT INTO `enlist` VALUES (28, 3, 44, 2, 0, 0);
INSERT INTO `enlist` VALUES (29, 1, 557, 2, 0, 0);
INSERT INTO `enlist` VALUES (30, 7, 33, 1, 1, 2);
INSERT INTO `enlist` VALUES (31, 3, 33, 1, 1, 2);
INSERT INTO `enlist` VALUES (32, 1, 33, 1, 1, 3);
INSERT INTO `enlist` VALUES (33, 5, 33, 1, 1, 3);
INSERT INTO `enlist` VALUES (34, 6, 33, 0, 0, 0);
INSERT INTO `enlist` VALUES (35, 7, 33, 0, 1, 2);
INSERT INTO `enlist` VALUES (36, 8, 33, 0, 0, 0);
INSERT INTO `enlist` VALUES (37, 9, 33, 0, 0, 0);
INSERT INTO `enlist` VALUES (38, 10, 33, 0, 0, 0);
INSERT INTO `enlist` VALUES (39, 11, 33, 0, 0, 0);
INSERT INTO `enlist` VALUES (40, 12, 33, 0, 0, 0);
INSERT INTO `enlist` VALUES (41, 1, 15, 2, 0, 0);
INSERT INTO `enlist` VALUES (42, 2, 15, 2, 0, 0);
INSERT INTO `enlist` VALUES (43, 3, 15, 0, 0, 0);
INSERT INTO `enlist` VALUES (44, 5, 15, 0, 0, 0);
INSERT INTO `enlist` VALUES (46, 7, 15, 0, 0, 0);
INSERT INTO `enlist` VALUES (47, 6, 15, 0, 0, 0);
INSERT INTO `enlist` VALUES (48, 8, 15, 0, 0, 0);
INSERT INTO `enlist` VALUES (49, 9, 15, 0, 0, 0);
INSERT INTO `enlist` VALUES (50, 10, 15, 0, 0, 0);
INSERT INTO `enlist` VALUES (51, 11, 15, 2, 0, 0);
INSERT INTO `enlist` VALUES (52, 12, 15, 0, 0, 0);
INSERT INTO `enlist` VALUES (53, 14, 601, 0, 0, 0);
INSERT INTO `enlist` VALUES (54, 14, 556, 0, 0, 0);
INSERT INTO `enlist` VALUES (55, 14, 557, 0, 0, 0);
INSERT INTO `enlist` VALUES (56, 3, 601, 0, 0, 0);
INSERT INTO `enlist` VALUES (57, 3, 557, 0, 0, 0);
INSERT INTO `enlist` VALUES (58, 3, 556, 0, 0, 0);
INSERT INTO `enlist` VALUES (59, 5, 602, 2, 0, 0);
INSERT INTO `enlist` VALUES (60, 5, 601, 0, 0, 0);
INSERT INTO `enlist` VALUES (61, 5, 603, 0, 0, 0);
INSERT INTO `enlist` VALUES (62, 3, 602, 2, 0, 0);
INSERT INTO `enlist` VALUES (64, 8, 602, 1, 1, 0);
INSERT INTO `enlist` VALUES (663, 6, 602, 1, 1, 0);
INSERT INTO `enlist` VALUES (664, 9, 602, 1, 1, 1);
INSERT INTO `enlist` VALUES (665, 10, 602, 1, 0, 0);
INSERT INTO `enlist` VALUES (666, 7, 602, 1, 1, 1);
INSERT INTO `enlist` VALUES (667, 15, 602, 2, 0, 0);
INSERT INTO `enlist` VALUES (668, 14, 602, 1, 0, 0);
INSERT INTO `enlist` VALUES (669, 13, 602, 1, 0, 0);
INSERT INTO `enlist` VALUES (670, 11, 602, 0, 0, 0);
INSERT INTO `enlist` VALUES (671, 12, 602, 0, 0, 0);
INSERT INTO `enlist` VALUES (672, 1, 604, 1, 1, 3);
INSERT INTO `enlist` VALUES (673, 1, 606, 0, 0, 0);
INSERT INTO `enlist` VALUES (674, 16, 608, 0, 0, 0);
INSERT INTO `enlist` VALUES (675, 1, 611, 3, 0, 0);
INSERT INTO `enlist` VALUES (677, 2, 612, 0, 0, 0);
INSERT INTO `enlist` VALUES (678, 3, 612, 1, 1, 1);
INSERT INTO `enlist` VALUES (688, 9, 612, 1, 2, 1);
INSERT INTO `enlist` VALUES (689, 1, 626, 3, 0, 0);
INSERT INTO `enlist` VALUES (690, 14, 627, 2, 0, 0);
INSERT INTO `enlist` VALUES (699, 1, 621, 0, 0, 0);
INSERT INTO `enlist` VALUES (700, 2, 621, 1, 0, 0);
INSERT INTO `enlist` VALUES (701, 1, 627, 1, 0, 0);
INSERT INTO `enlist` VALUES (702, 1, 622, 0, 0, 0);
INSERT INTO `enlist` VALUES (705, 1, 625, 3, 0, 0);

-- ----------------------------
-- Table structure for organize
-- ----------------------------
DROP TABLE IF EXISTS `organize`;
CREATE TABLE `organize`  (
  `OId` int(20) NOT NULL AUTO_INCREMENT COMMENT '组织编号',
  `OName` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL DEFAULT '' COMMENT '组织名称',
  `OPerson` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL DEFAULT '' COMMENT '法人',
  `OPassword` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL DEFAULT '' COMMENT '登录密码',
  `OEmail` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL DEFAULT '' COMMENT '组织邮箱',
  `ODate` date NOT NULL DEFAULT '' COMMENT '组织成立时间',
  `OAddress` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL DEFAULT '' COMMENT '组织地址',
  `OState` int(1) NOT NULL DEFAULT 0 COMMENT '组织状态0待审核1已通过2限制登录',
  `OIdCard` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL DEFAULT '' COMMENT '法人身份证',
  `OSynopsis` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '组织简介',
  PRIMARY KEY USING BTREE (`OId`)
) ENGINE = InnoDB AUTO_INCREMENT = 25 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Compact;

-- ----------------------------
-- Records of organize
-- ----------------------------
INSERT INTO `organize` VALUES (1, '星火慈善义工服务组织', '江智鑫哈', 'f379eaf3c831b04de153469d1bec345e', '1072766478@qq.com', '2020-03-04', '福建省厦门市', 1, '350681199611023013', '666');
INSERT INTO `organize` VALUES (2, '组织2', '江智鑫哈2', 'f379eaf3c831b04de153469d1bec345e', '1072766478@qq.com', '2020-03-10', '厦门市思明区', 2, '350681199611027014', '111');
INSERT INTO `organize` VALUES (3, '五八零志愿组织', '江智鑫哈', 'f379eaf3c831b04de153469d1bec345e', '1072766478@qq.com', '2020-03-14', '厦门市思明区', 1, '350681199611027011', '222');
INSERT INTO `organize` VALUES (4, '组织4', '江智鑫哈4', 'f379eaf3c831b04de153469d1bec345e', '1072766478@qq.com', '2020-03-10', '厦门市思明区', 1, '350681199611027015', '444');
INSERT INTO `organize` VALUES (5, '组织5', '江智鑫哈5', 'f379eaf3c831b04de153469d1bec345e', '1072766478@qq.com', '2020-03-10', '厦门市思明区', 1, '350681199611027015', '555');
INSERT INTO `organize` VALUES (6, '组织6', '江智鑫哈6', 'f379eaf3c831b04de153469d1bec345e', '1072766478@qq.com', '2020-03-10', '厦门市思明区', 1, '350681199611027015', '666');
INSERT INTO `organize` VALUES (7, '组织7', '江智鑫哈7', 'f379eaf3c831b04de153469d1bec345e', '1072766478@qq.com', '2020-03-10', '厦门市思明区', 1, '350681199611027015', '777');
INSERT INTO `organize` VALUES (8, '组织8', '江智鑫哈8', '5f53201982080f99c7f82567292d0b2d', '1072766478@qq.com', '2020-03-10', '厦门市思明区', 1, '350681199611027015', '888');
INSERT INTO `organize` VALUES (9, '组织9', '江智鑫哈9', 'f379eaf3c831b04de153469d1bec345e', '1072766478@qq.com', '2020-03-10', '厦门市思明区', 0, '350681199611027015', '999');
INSERT INTO `organize` VALUES (10, '组织10', '江智鑫哈10', 'f379eaf3c831b04de153469d1bec345e', '1072766478@qq.com', '2020-03-10', '厦门市思明区', 0, '350681199611027015', '1010');
INSERT INTO `organize` VALUES (11, '组织11', '江智鑫哈11', 'f379eaf3c831b04de153469d1bec345e', '1072766478@qq.com', '2020-03-10', '厦门市思明区', 0, '350681199611027015', '1111');
INSERT INTO `organize` VALUES (12, '组织12', '江智鑫哈12', 'f379eaf3c831b04de153469d1bec345e', '1072766478@qq.com', '2020-03-10', '厦门市思明区', 0, '350681199611027015', '1212');
INSERT INTO `organize` VALUES (13, '组织13', '江智鑫哈13', 'f379eaf3c831b04de153469d1bec345e', '1072766478@qq.com', '2020-03-10', '厦门市思明区', 0, '350681199611027015', '1313');
INSERT INTO `organize` VALUES (14, '组织14', '江智鑫哈14', 'f379eaf3c831b04de153469d1bec345e', '1072766478@qq.com', '2020-03-10', '厦门市思明区', 0, '350681199611027015', '1414');
INSERT INTO `organize` VALUES (15, '组织15', '江智鑫哈15', 'f379eaf3c831b04de153469d1bec345e', '1072766478@qq.com', '2020-03-10', '厦门市思明区', 0, '350681199611027015', '1515');
INSERT INTO `organize` VALUES (16, '组织16', '江智鑫哈16', 'f379eaf3c831b04de153469d1bec345e', '1072766478@qq.com', '2020-03-10', '厦门市思明区', 0, '350681199611027015', '1616');
INSERT INTO `organize` VALUES (17, '组织17', '江智鑫哈17', 'f379eaf3c831b04de153469d1bec345e', '1072766478@qq.com', '2020-03-10', '厦门市思明区', 0, '350681199611027015', '1717');
INSERT INTO `organize` VALUES (18, '组织18', '江智鑫哈18', 'f379eaf3c831b04de153469d1bec345e', '1072766478@qq.com', '2020-03-10', '厦门市思明区', 0, '350681199611027015', '1818');
INSERT INTO `organize` VALUES (19, '组织19', '江智鑫哈19', 'f379eaf3c831b04de153469d1bec345e', '1072766478@qq.com', '2020-03-10', '厦门市思明区', 0, '350681199611027015', '1919');
INSERT INTO `organize` VALUES (20, '组织20', '江智鑫哈20', 'f379eaf3c831b04de153469d1bec345e', '1072766478@qq.com', '2020-03-10', '厦门市思明区', 0, '350681199611027015', '2020');
INSERT INTO `organize` VALUES (21, '组织21', '江智鑫哈', 'f379eaf3c831b04de153469d1bec345e', '20255208@qq.com', '2020-04-17', '厦门市同安区', 0, '350681199111027010', '2121');
INSERT INTO `organize` VALUES (22, '组织22', '江智鑫哈', 'f379eaf3c831b04de153469d1bec345e', '20255208@qq.com', '2020-04-17', '厦门市海沧区', 0, '350681199611027066', '2222');
INSERT INTO `organize` VALUES (23, '社会组织23', '江智鑫哈', 'f379eaf3c831b04de153469d1bec345e', '20255208@qq.com', '2020-04-23', '厦门市湖里区', 0, '350651199611023010', '2323');
INSERT INTO `organize` VALUES (24, '社会组织24', '江智鑫哈', 'f379eaf3c831b04de153469d1bec345e', '20255208@qq.com', '2020-04-23', '厦门市思明区', 0, '350681194611027010', '2424');

-- ----------------------------
-- Table structure for test
-- ----------------------------
DROP TABLE IF EXISTS `test`;
CREATE TABLE `test`  (
  `TId` int(10) NOT NULL AUTO_INCREMENT COMMENT '测试表id',
  `THours` double(255, 2) NULL DEFAULT NULL,
  `sss` varchar(10) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  PRIMARY KEY USING BTREE (`TId`)
) ENGINE = InnoDB AUTO_INCREMENT = 1111111112 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Compact;

-- ----------------------------
-- Records of test
-- ----------------------------
INSERT INTO `test` VALUES (3, 3.50, NULL);
INSERT INTO `test` VALUES (4, 3.89, NULL);
INSERT INTO `test` VALUES (5, 311.08, NULL);
INSERT INTO `test` VALUES (6, 3.00, NULL);
INSERT INTO `test` VALUES (10, -311.08, NULL);
INSERT INTO `test` VALUES (1111111111, NULL, '你好你好你好你好你好');

-- ----------------------------
-- Table structure for user
-- ----------------------------
DROP TABLE IF EXISTS `user`;
CREATE TABLE `user`  (
  `UId` int(20) NOT NULL AUTO_INCREMENT COMMENT '志愿者编号',
  `UName` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL DEFAULT '' COMMENT '志愿者姓名',
  `UPassword` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL DEFAULT '' COMMENT '密码',
  `UEmail` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL DEFAULT '' COMMENT '邮箱',
  `UPhone` varchar(11) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL DEFAULT '' COMMENT '手机号',
  `UAddress` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT '' COMMENT '地址',
  `USex` varchar(20) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL DEFAULT '' COMMENT '性别',
  `UState` int(1) NOT NULL DEFAULT 1 COMMENT '状态1正常2冻结',
  `UIdCard` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL DEFAULT '' COMMENT '身份证',
  `UIntegral` int(20) NOT NULL DEFAULT 0 COMMENT '志愿者积分',
  `UHours` double(20, 2) NOT NULL DEFAULT 0.00 COMMENT '志愿者时长',
  `UCredit` int(1) NOT NULL DEFAULT 3 COMMENT '志愿者信誉度  初始值3星最高6星 最低1星 1星以下限制登录',
  `UDate` date NOT NULL DEFAULT '' COMMENT '志愿者注册时间',
  PRIMARY KEY USING BTREE (`UId`)
) ENGINE = InnoDB AUTO_INCREMENT = 20 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Compact;

-- ----------------------------
-- Records of user
-- ----------------------------
INSERT INTO `user` VALUES (1, '江智鑫', 'dc0fa7df3d07904a09288bd2d2bb5f40', 'JZX59948023@163.com', '18650170319', '厦门市湖里区', '男', 1, '350681199611027010', 100, 15.50, 3, '2020-04-10');
INSERT INTO `user` VALUES (2, '江智鑫2', 'f379eaf3c831b04de153469d1bec345e', '202552087@qq.com', '18652270333', '厦门市湖里区', '女', 1, '350681199615527011', 21, 0.00, 5, '2020-04-10');
INSERT INTO `user` VALUES (3, '江智鑫3', 'f379eaf3c831b04de153469d1bec345e', '202552087@qq.com', '18644170313', '厦门市湖里区', '男', 1, '350681199616627011', 73, 30.00, 2, '2020-04-10');
INSERT INTO `user` VALUES (5, '江智鑫5', 'f379eaf3c831b04de153469d1bec345e', '1072766478@qq.com', '18654170313', '厦门市湖里区', '男', 1, '350681199677027011', 118, 39.00, 1, '2020-04-10');
INSERT INTO `user` VALUES (6, '江智鑫6', 'f379eaf3c831b04de153469d1bec345e', '1072766478@qq.com', '18650170343', '厦门市湖里区', '男', 1, '350681199613427011', 33, 33.75, 1, '2020-04-10');
INSERT INTO `user` VALUES (7, '江智鑫7', 'f379eaf3c831b04de153469d1bec345e', '1072766478@qq.com', '18650170313', '厦门市湖里区', '男', 2, '350681199616527011', 43, 33.75, 0, '2020-04-10');
INSERT INTO `user` VALUES (8, '江智鑫8', 'f379eaf3c831b04de153469d1bec345e', '1072766478@qq.com', '18650170313', '厦门市湖里区', '女', 1, '350681199617627011', 39, 45.75, 3, '2020-04-10');
INSERT INTO `user` VALUES (9, '江智鑫9', 'f379eaf3c831b04de153469d1bec345e', '1072766478@qq.com', '18650570513', '厦门市湖里区', '女', 1, '350681199618727011', 33, 33.75, 5, '2020-04-10');
INSERT INTO `user` VALUES (10, '江智鑫10', 'f379eaf3c831b04de153469d1bec345e', '1072766478@qq.com', '18650170313', '厦门市湖里区', '女', 1, '35068119965627011', 0, 0.00, 6, '2020-04-10');
INSERT INTO `user` VALUES (11, '江智鑫11', 'f379eaf3c831b04de153469d1bec345e', '1072766478@qq.com', '18657870313', '厦门市湖里区', '女', 1, '350681199611757011', 0, 9.00, 3, '2020-04-10');
INSERT INTO `user` VALUES (12, '江智鑫12', 'f379eaf3c831b04de153469d1bec345e', '1072766478@qq.com', '18650670313', '厦门市湖里区', '女', 1, '350681199615627011', 0, 0.00, 3, '2020-04-10');
INSERT INTO `user` VALUES (13, '江智鑫13', 'f379eaf3c831b04de153469d1bec345e', '1072766478@qq.com', '18657770313', '厦门市湖里区', '男', 1, '350681199611057011', 0, 0.00, 3, '2020-04-10');
INSERT INTO `user` VALUES (14, '江智鑫14', 'f379eaf3c831b04de153469d1bec345e', '202552087@qq.com', '18657780313', '厦门市湖里区', '男', 1, '350681199611317011', 0, 0.00, 3, '2020-04-10');
INSERT INTO `user` VALUES (15, '江智鑫15', 'f379eaf3c831b04de153469d1bec345e', '202552087@qq.com', '18650190313', '厦门市湖里区', '男', 1, '350681199611227011', 0, 0.00, 3, '2020-04-10');
INSERT INTO `user` VALUES (16, '江智鑫16', 'f379eaf3c831b04de153469d1bec345e', '202552087@qq.com', '18650170313', '龙海市港尾镇上午村', '男', 1, '350681199611027045', 0, 0.00, 3, '2020-04-17');
INSERT INTO `user` VALUES (17, '江智鑫17', 'f379eaf3c831b04de153469d1bec345e', '202552087@qq.com', '18650170313', '福建厦门', '女', 1, '350681199011027016', 0, 0.00, 3, '2020-06-04');
INSERT INTO `user` VALUES (18, '江智鑫18', 'f379eaf3c831b04de153469d1bec345e', '202552087@qq.com', '18650170313', '福建厦门', '男', 1, '350681199911027016', 0, 0.00, 3, '2020-06-04');

SET FOREIGN_KEY_CHECKS = 1;
