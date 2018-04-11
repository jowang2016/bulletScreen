/*
 Navicat Premium Data Transfer

 Source Server         : localhost
 Source Server Type    : MySQL
 Source Server Version : 50717
 Source Host           : localhost
 Source Database       : bullet

 Target Server Type    : MySQL
 Target Server Version : 50717
 File Encoding         : utf-8

 Date: 04/11/2018 18:30:07 PM
*/

SET NAMES utf8;
SET FOREIGN_KEY_CHECKS = 0;

-- ----------------------------
--  Table structure for `comments`
-- ----------------------------
DROP TABLE IF EXISTS `comments`;
CREATE TABLE `comments` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `content` text NOT NULL,
  `color` varchar(20) NOT NULL DEFAULT 'white',
  `fontSize` smallint(6) NOT NULL DEFAULT '14',
  `idx` int(11) NOT NULL,
  `cTime` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=17 DEFAULT CHARSET=utf8;

-- ----------------------------
--  Records of `comments`
-- ----------------------------
BEGIN;
INSERT INTO `comments` VALUES ('1', 'abcdefghi', '#fff', '30', '0', '2018-04-09 13:49:23'), ('2', '我的一个评论', 'red', '14', '0', '2018-04-09 13:49:23'), ('3', 'one comment', 'green', '20', '1', '2018-04-09 13:49:23'), ('4', '一条弹幕', 'yellow', '14', '1', '2018-04-09 13:49:23'), ('5', '视频很精彩', 'white', '25', '2', '2018-04-09 13:49:23'), ('6', '演技很棒', 'white', '28', '2', '2018-04-09 13:49:23'), ('7', '非常赞', 'white', '14', '2', '2018-04-09 13:49:23'), ('8', '太好看了', 'white', '14', '3', '2018-04-09 13:49:23'), ('9', '没看过这么好的电影', 'white', '14', '4', '2018-04-09 13:49:23'), ('10', '演技在线', 'white', '14', '4', '2018-04-09 13:49:23'), ('11', '非常赞', 'white', '14', '4', '2018-04-09 13:49:23'), ('12', '评论留言', 'white', '14', '4', '2018-04-09 13:49:23'), ('13', '太好了', 'white', '14', '5', '2018-04-09 13:49:23'), ('14', '非常好', 'white', '14', '6', '2018-04-09 13:49:23'), ('15', 'very good', 'white', '14', '7', '2018-04-09 13:49:23'), ('16', 'super good', 'white', '14', '8', '2018-04-09 13:49:23');
COMMIT;

SET FOREIGN_KEY_CHECKS = 1;
