-- 基础数据库构建

/*
gadgets -- user-用户名，密码，邮箱，昵称，时间...
        |
        -- article-标题，内容，类别，日期，阅读次数，作者（与user关联），积分，隐藏，审核，推荐，发布时间...
        |
        -- points（积分）-用户id，文章id，消耗积分，时间...
        |
        -- collect（收藏）-用户id，文章id，取消，时间...
        |
        -- comment（评论）-用户id，文章id，内容，时间...
*/

-- 建库
CREATE DATABASE `gadgets` CHARACTER SET 'utf8mb4' COLLATE 'utf8mb4_general_ci';
USE `gadgets`;

-- 建表
-- 用户表（主表）
CREATE TABLE IF NOT EXISTS `user`
(
`userid` INT(11) PRIMARY KEY NOT NULL AUTO_INCREMENT, -- 用户id，主键，自增
`username` VARCHAR(50) NOT NULL COMMENT '用户名，邮箱',
`password` VARCHAR(32) NOT NULL COMMENT '密码，md5加密',
`nickname` VARCHAR(30) NOT NULL COMMENT '昵称',
`avatar` VARCHAR(20) NOT NULL COMMENT '头像文件路径',
`qq` VARCHAR(15) COMMENT 'qq号',
`role` VARCHAR(10) NOT NULL COMMENT '用户角色',
`credit` INT(11) NOT NULL COMMENT '积分余额',
`createtime` DATETIME DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间，自动更改',
`updatetime` DATETIME DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间，自动更改'
-- 创建索引
-- INDEX [indexName] (username(length))  
-- 外键
-- CONSTRAINT `fk` FOREIGN KEY (`bookTypeId`) REFERENCES `t_bookType`(`id`)
)ENGINE='InnoDB' DEFAULT CHARSET='utf8mb4' COMMENT='用户表';

-- 文章表
CREATE TABLE IF NOT EXISTS `article`
(
`articleid` INT(11) PRIMARY KEY NOT NULL AUTO_INCREMENT, -- 文章id
`userid` INT(11) NOT NULL COMMENT '作者，关联userid',
`type` TINYINT NOT NULL COMMENT '文章类型',
`headline` VARCHAR(100) NOT NULL COMMENT '标题',
`content` MEDIUMTEXT NOT NULL COMMENT '内容',
`thumbnail` VARCHAR(20) NOT NULL COMMENT '略缩图',
`credit` INT(11) NOT NULL COMMENT '阅读所需积分',
`replycount` INT(11) NOT NULL COMMENT '评论数',
`recommended` TINYINT NOT NULL COMMENT '是否被手动推荐，默认-0，是-1',
`hidden` TINYINT NOT NULL COMMENT '是否隐藏（软删除），默认-0，是-1',
`drafted` TINYINT NOT NULL COMMENT '是否为草稿，默认-0，是-1',
`checked` TINYINT NOT NULL COMMENT '是否被审核，默认-1，是-1',
`createtime` DATETIME DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间，自动更改',
`updatetime` DATETIME DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间，自动更改'
-- 创建索引
-- INDEX [indexName] (username(length)) 
-- 外键
-- CONSTRAINT `fk` FOREIGN KEY (`bookTypeId`) REFERENCES `t_bookType`(`id`)
)ENGINE='InnoDB' DEFAULT CHARSET='utf8mb4' COMMENT='文章表';

-- 用户评论表
CREATE TABLE IF NOT EXISTS `comment`
(
`commentid` INT(11) PRIMARY KEY NOT NULL AUTO_INCREMENT, -- 评论id
`userid` INT(11) NOT NULL COMMENT '评论人，关联userid',
`articleid` INT(11) NOT NULL COMMENT '评论所属文章，关联articleid',
`content` TEXT NOT NULL COMMENT '评论内容',
`ipaddr` varchar(64) NOT NULL COMMENT '评论用户id',
`replyid` INT(11) NOT NULL COMMENT '评论为回复则保存被评论的commentid，0表示原始评论',
`agreecount` INT(11) NOT NULL COMMENT '赞数量',
`opposecount` INT(11) NOT NULL COMMENT '踩数量',
`hidden` TINYINT NOT NULL COMMENT '是否隐藏（软删除），默认-0，是-1',
`createtime` DATETIME DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间，自动更改',
`updatetime` DATETIME DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间，自动更改'
-- 创建索引
-- INDEX [indexName] (username(length))  
-- 外键
-- CONSTRAINT `fk` FOREIGN KEY (`bookTypeId`) REFERENCES `t_bookType`(`id`)
)ENGINE='InnoDB' DEFAULT CHARSET='utf8mb4' COMMENT='用户评论表';

-- 文章收藏表
CREATE TABLE IF NOT EXISTS `favorite`
(
`favoriteid` INT(11) PRIMARY KEY NOT NULL AUTO_INCREMENT COMMENT '收藏id',
`userid` INT(11) NOT NULL COMMENT '评论人，关联userid',
`articleid` INT(11) NOT NULL COMMENT '被收藏文章，关联articleid',
`canceled` TINYINT NOT NULL COMMENT '是否取消收藏（软删除），默认-0，是-1',
`createtime` DATETIME DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间，自动更改',
`updatetime` DATETIME DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间，自动更改'
-- 创建索引
-- INDEX [indexName] (username(length))  
-- 外键
-- CONSTRAINT `fk` FOREIGN KEY (`bookTypeId`) REFERENCES `t_bookType`(`id`)
)ENGINE='InnoDB' DEFAULT CHARSET='utf8mb4' COMMENT='文章收藏表';

-- 积分变化记录表
CREATE TABLE IF NOT EXISTS `credit`
(
`creditid` INT(11) PRIMARY KEY NOT NULL AUTO_INCREMENT COMMENT '积分变换记录id',
`userid` INT(11) NOT NULL COMMENT '积分变换用户，关联userid',
`category` varchar(10) NOT NULL COMMENT '积分变化具体原因，例如：首次注册、登陆、充值等',
`target` INT(11) NOT NULL COMMENT '造成积分变化的对象',
`credit` INT(11) NOT NULL COMMENT '积分的具体数值',
`createtime` DATETIME DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间，自动更改',
`updatetime` DATETIME DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间，自动更改'
-- 创建索引
-- INDEX [indexName] (username(length)) 
-- 外键
-- CONSTRAINT `fk` FOREIGN KEY (`bookTypeId`) REFERENCES `t_bookType`(`id`)
)ENGINE='InnoDB' DEFAULT CHARSET='utf8mb4' COMMENT='积分记录表';