-- 系统管理模块表结构
-- 基于实际数据库 digital_loom 的表结构生成
-- 生成时间: 2025-10-03

-- OAuth2 认证相关表
CREATE TABLE `oauth2_authorization` (
  `id` varchar(100) NOT NULL COMMENT '授权ID',
  `registered_client_id` varchar(100) NOT NULL COMMENT '注册客户端ID',
  `principal_name` varchar(200) NOT NULL COMMENT '主体名称',
  `authorization_grant_type` varchar(100) NOT NULL COMMENT '授权类型',
  `authorized_scopes` varchar(1000) DEFAULT NULL COMMENT '授权范围',
  `attributes` blob DEFAULT NULL COMMENT '属性',
  `state` varchar(500) DEFAULT NULL COMMENT '状态',
  `authorization_code_value` blob DEFAULT NULL COMMENT '授权码值',
  `authorization_code_issued_at` datetime DEFAULT NULL COMMENT '授权码签发时间',
  `authorization_code_expires_at` datetime DEFAULT NULL COMMENT '授权码过期时间',
  `authorization_code_metadata` blob DEFAULT NULL COMMENT '授权码元数据',
  `access_token_value` blob DEFAULT NULL COMMENT '访问令牌值',
  `access_token_issued_at` datetime DEFAULT NULL COMMENT '访问令牌签发时间',
  `access_token_expires_at` datetime DEFAULT NULL COMMENT '访问令牌过期时间',
  `access_token_metadata` blob DEFAULT NULL COMMENT '访问令牌元数据',
  `access_token_type` varchar(100) DEFAULT NULL COMMENT '访问令牌类型',
  `access_token_scopes` varchar(1000) DEFAULT NULL COMMENT '访问令牌范围',
  `oidc_id_token_value` blob DEFAULT NULL COMMENT 'OIDC ID令牌值',
  `oidc_id_token_issued_at` datetime DEFAULT NULL COMMENT 'OIDC ID令牌签发时间',
  `oidc_id_token_expires_at` datetime DEFAULT NULL COMMENT 'OIDC ID令牌过期时间',
  `oidc_id_token_metadata` blob DEFAULT NULL COMMENT 'OIDC ID令牌元数据',
  `refresh_token_value` blob DEFAULT NULL COMMENT '刷新令牌值',
  `refresh_token_issued_at` datetime DEFAULT NULL COMMENT '刷新令牌签发时间',
  `refresh_token_expires_at` datetime DEFAULT NULL COMMENT '刷新令牌过期时间',
  `refresh_token_metadata` blob DEFAULT NULL COMMENT '刷新令牌元数据',
  `user_code_value` blob DEFAULT NULL COMMENT '用户码值',
  `user_code_issued_at` datetime DEFAULT NULL COMMENT '用户码签发时间',
  `user_code_expires_at` datetime DEFAULT NULL COMMENT '用户码过期时间',
  `user_code_metadata` blob DEFAULT NULL COMMENT '用户码元数据',
  `device_code_value` blob DEFAULT NULL COMMENT '设备码值',
  `device_code_issued_at` datetime DEFAULT NULL COMMENT '设备码签发时间',
  `device_code_expires_at` datetime DEFAULT NULL COMMENT '设备码过期时间',
  `device_code_metadata` blob DEFAULT NULL COMMENT '设备码元数据',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='OAuth2授权表';

CREATE TABLE `oauth2_registered_client` (
  `id` varchar(100) NOT NULL COMMENT '客户端ID',
  `client_id` varchar(100) NOT NULL COMMENT '客户端标识',
  `client_id_issued_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '客户端ID签发时间',
  `client_secret` varchar(200) DEFAULT NULL COMMENT '客户端密钥',
  `client_secret_expires_at` timestamp DEFAULT NULL COMMENT '客户端密钥过期时间',
  `client_name` varchar(200) NOT NULL COMMENT '客户端名称',
  `client_authentication_methods` varchar(1000) NOT NULL COMMENT '客户端认证方法',
  `authorization_grant_types` varchar(1000) NOT NULL COMMENT '授权类型',
  `redirect_uris` varchar(1000) DEFAULT NULL COMMENT '重定向URI',
  `post_logout_redirect_uris` varchar(1000) DEFAULT NULL COMMENT '登出后重定向URI',
  `scopes` varchar(1000) NOT NULL COMMENT '作用域',
  `client_settings` varchar(2000) NOT NULL COMMENT '客户端设置',
  `token_settings` varchar(2000) NOT NULL COMMENT '令牌设置',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='OAuth2注册客户端表';

-- 系统用户表（基于实际数据库结构）
CREATE TABLE `s_users` (
  `id` bigint NOT NULL AUTO_INCREMENT COMMENT '系统用户唯一ID',
  `account` varchar(50) DEFAULT NULL COMMENT '用户系统账号',
  `pwd` varchar(200) DEFAULT NULL COMMENT '系统密码',
  `surname` varchar(24) DEFAULT NULL COMMENT '姓氏',
  `chinese_name` varchar(50) DEFAULT NULL COMMENT '中文名称',
  `nickname` varchar(50) DEFAULT NULL COMMENT '用户昵称',
  `email` varchar(50) DEFAULT NULL COMMENT '用户邮箱',
  `mobile` varchar(20) DEFAULT NULL COMMENT '手机号码',
  `last_date` datetime DEFAULT NULL COMMENT '最后登录时间',
  `sex` varchar(2) DEFAULT NULL COMMENT '性别1：男2：女',
  `birthday` datetime DEFAULT NULL COMMENT '出生年月',
  `nationality` varchar(50) DEFAULT NULL COMMENT '国籍',
  `province` varchar(100) DEFAULT NULL COMMENT '省份(籍贯)',
  `cities` varchar(50) DEFAULT NULL COMMENT '城市(籍贯)',
  `address` varchar(255) DEFAULT NULL COMMENT '户籍地址',
  `address_province` varchar(36) DEFAULT NULL COMMENT '现在住址(省)',
  `address_city` varchar(45) DEFAULT NULL COMMENT '现住址(市)',
  `address_area` varchar(45) DEFAULT NULL COMMENT '现住址(区)',
  `address_street` varchar(45) DEFAULT NULL COMMENT '现住址(街道)',
  `id_type` int DEFAULT NULL COMMENT '证件类型',
  `id_number` varchar(36) DEFAULT NULL COMMENT '证件号',
  `car_no` varchar(30) DEFAULT NULL COMMENT '车牌号',
  `education` varchar(36) DEFAULT NULL COMMENT '学历',
  `age` int DEFAULT NULL COMMENT '年龄',
  `household_province` varchar(24) DEFAULT NULL COMMENT '户籍所在地省',
  `household_city` varchar(24) DEFAULT NULL COMMENT '户籍所在地城市',
  `ethnic` varchar(24) DEFAULT NULL COMMENT '民族',
  `blood` varchar(24) DEFAULT NULL COMMENT '血型',
  `career` varchar(24) DEFAULT NULL COMMENT '职业',
  `register_time` datetime DEFAULT CURRENT_TIMESTAMP COMMENT '注册时间',
  `status` int NOT NULL DEFAULT '1' COMMENT '激活状态 激活为1，注销为2',
  `login_type` varchar(255) DEFAULT NULL COMMENT '登陆类型',
  `grade_name` smallint DEFAULT '1' COMMENT '会员等级 取字典',
  `skin` varchar(20) DEFAULT NULL COMMENT '用户皮肤',
  `layout` int DEFAULT '1' COMMENT '布局设置1：左侧菜单2：顶部菜单',
  `auto_menu` bit(1) DEFAULT NULL COMMENT '是否自动分割菜单',
  `one_level_menu` bit(1) DEFAULT NULL COMMENT '一级菜单是否隐藏',
  `modify_time` datetime DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '修改时间',
  `modify_id` bigint DEFAULT NULL COMMENT '修改人',
  `hospital_role_id` bigint DEFAULT NULL COMMENT '医院角色ID【子系统】',
  `image_url` varchar(300) DEFAULT NULL COMMENT '头像路径',
  `identity_cards_image` varchar(300) DEFAULT NULL COMMENT '身份证照片',
  `user_type` int DEFAULT NULL COMMENT '用户类型:1：医生类用户3：代理商/运营商4：普通用户',
  `register_code` varchar(36) DEFAULT NULL COMMENT '注册码',
  `qq_number` varchar(30) DEFAULT NULL COMMENT 'qq账号',
  `wechat` varchar(30) DEFAULT NULL COMMENT '微信号',
  `weibo` varchar(200) DEFAULT NULL COMMENT '微博地址',
  `open_id_qq` varchar(36) DEFAULT NULL COMMENT 'qq注册生成id',
  `miniapp_openid` varchar(50) DEFAULT NULL COMMENT '小程序院openId',
  `open_id_weibo` varchar(36) DEFAULT NULL COMMENT '微博注册生成ID',
  `open_id_wechat` varchar(36) DEFAULT NULL COMMENT '微信的openID',
  `open_push` bit(1) DEFAULT b'1' COMMENT '是否开启极光推送',
  `register_type` int DEFAULT NULL COMMENT '注册渠道，字典定义',
  `enterprise_user_id` varchar(100) DEFAULT NULL COMMENT '企微成员用户ID',
  `union_id` varchar(500) DEFAULT NULL COMMENT 'unionid',
  `enterprise_id` bigint DEFAULT NULL COMMENT '所属企业ID',
  PRIMARY KEY (`id`),
  KEY `idx_mobile` (`mobile`),
  KEY `idx_chinese_name` (`chinese_name`),
  KEY `idx_email` (`email`),
  KEY `idx_user_type` (`user_type`),
  KEY `idx_enterprise_user_id` (`enterprise_user_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='账户信息表';

-- 系统角色表（基于实际数据库结构）
CREATE TABLE `s_roles` (
  `id` bigint NOT NULL AUTO_INCREMENT COMMENT '角色id',
  `name` varchar(64) DEFAULT NULL COMMENT '角色名称',
  `type` int DEFAULT NULL COMMENT '角色类别:字典配置',
  `login_client` varchar(255) DEFAULT NULL COMMENT '登录的客户端',
  `enterprise_id` bigint DEFAULT NULL COMMENT '企业ID',
  `enterprise_admin` tinyint(1) DEFAULT '2' COMMENT '1 -企业管理员',
  `description` varchar(128) DEFAULT NULL COMMENT '角色描述',
  `create_time` datetime DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `create_id` bigint DEFAULT NULL COMMENT '创建人ID',
  `modify_time` datetime DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '修改时间',
  `modify_id` bigint DEFAULT NULL COMMENT '修改人ID',
  PRIMARY KEY (`id`),
  KEY `idx_enterprise_id` (`enterprise_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='角色表';

-- 系统菜单表（基于实际数据库结构）
CREATE TABLE `s_menu` (
  `id` bigint NOT NULL AUTO_INCREMENT COMMENT '菜单的主键ID',
  `sort_id` int DEFAULT NULL COMMENT '排序ID',
  `parent_id` bigint DEFAULT NULL COMMENT '父级ID',
  `name` varchar(64) NOT NULL COMMENT '菜单名称',
  `url` varchar(255) DEFAULT NULL COMMENT '菜单URL',
  `icon_class` varchar(100) DEFAULT NULL COMMENT '菜单Class属性对应菜单的图标样式',
  `description` varchar(64) DEFAULT NULL COMMENT '备注',
  `create_id` bigint DEFAULT NULL COMMENT '创建人',
  `create_time` datetime DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `modify_id` bigint DEFAULT NULL COMMENT '修改人',
  `modify_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '修改时间',
  `system_code` int DEFAULT NULL COMMENT '系统代码',
  PRIMARY KEY (`id`),
  KEY `idx_parent_id` (`parent_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='菜单表';

-- 系统资源表（基于实际数据库结构）
CREATE TABLE `s_resource` (
  `id` bigint NOT NULL AUTO_INCREMENT COMMENT '主键ID',
  `name` varchar(32) DEFAULT NULL COMMENT '名称',
  `code` varchar(100) DEFAULT NULL COMMENT '资源编码',
  `platform_flag` tinyint(1) DEFAULT '2' COMMENT '1 平台资源 2非平台资源',
  `description` varchar(255) DEFAULT NULL COMMENT '资源的描述',
  `resource_url` varchar(255) DEFAULT NULL COMMENT '资源URL路由',
  `create_id` bigint DEFAULT NULL COMMENT '创建人',
  `create_time` datetime DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `modify_id` bigint DEFAULT NULL COMMENT '修改人',
  `modify_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '修改时间',
  PRIMARY KEY (`id`),
  KEY `idx_code` (`code`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='资源表';

-- 系统数据字典表（基于实际数据库结构）
CREATE TABLE `s_dictionary` (
  `id` bigint NOT NULL AUTO_INCREMENT COMMENT '自增id',
  `sort_id` int NOT NULL DEFAULT '1' COMMENT '排序id',
  `parent_id` bigint NOT NULL COMMENT '父级id',
  `name` varchar(120) DEFAULT NULL COMMENT '名称',
  `value` varchar(500) NOT NULL COMMENT '属性值',
  `description` varchar(2000) DEFAULT NULL COMMENT '备注',
  `status` int NOT NULL DEFAULT '1' COMMENT '状态 1:启用2：禁用',
  `create_id` bigint DEFAULT NULL COMMENT '创建人',
  `create_time` datetime DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `modify_id` bigint DEFAULT NULL COMMENT '修改人',
  `modify_time` datetime DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '修改时间',
  `english` json DEFAULT NULL COMMENT '海外多语言字典配置',
  `type` int NOT NULL DEFAULT '1' COMMENT '字典类型',
  PRIMARY KEY (`id`),
  KEY `idx_parent_id` (`parent_id`),
  KEY `idx_type` (`type`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='系统数据字典表';

-- 用户角色关系表（基于实际数据库结构）
CREATE TABLE `s_user_role` (
  `id` bigint NOT NULL AUTO_INCREMENT COMMENT '主键ID',
  `user_id` bigint NOT NULL COMMENT '用户ID',
  `role_id` bigint NOT NULL COMMENT '角色ID',
  `create_id` bigint DEFAULT NULL COMMENT '创建人',
  `create_time` datetime DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `modify_id` bigint DEFAULT NULL COMMENT '修改人',
  `modify_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '修改时间',
  PRIMARY KEY (`id`),
  KEY `idx_user_id` (`user_id`),
  KEY `idx_role_id` (`role_id`),
  CONSTRAINT `fk_user_role_user` FOREIGN KEY (`user_id`) REFERENCES `s_users` (`id`) ON DELETE CASCADE,
  CONSTRAINT `fk_user_role_role` FOREIGN KEY (`role_id`) REFERENCES `s_roles` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='用户角色关系表';

-- 角色菜单关系表（基于实际数据库结构）
CREATE TABLE `s_role_menu` (
  `id` bigint NOT NULL AUTO_INCREMENT COMMENT '主键ID',
  `role_id` bigint DEFAULT NULL COMMENT '角色ID',
  `menu_id` bigint NOT NULL COMMENT '菜单ID',
  `create_id` bigint DEFAULT NULL COMMENT '创建人',
  `create_time` datetime DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  PRIMARY KEY (`id`),
  KEY `idx_role_id` (`role_id`),
  KEY `idx_menu_id` (`menu_id`),
  CONSTRAINT `fk_role_menu_role` FOREIGN KEY (`role_id`) REFERENCES `s_roles` (`id`) ON DELETE CASCADE,
  CONSTRAINT `fk_role_menu_menu` FOREIGN KEY (`menu_id`) REFERENCES `s_menu` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='角色菜单表';

-- 角色资源关系表（基于实际数据库结构）
CREATE TABLE `s_page_role` (
  `id` bigint NOT NULL AUTO_INCREMENT COMMENT '主键id',
  `menu_id` bigint DEFAULT NULL COMMENT '菜单id',
  `role_id` bigint DEFAULT NULL COMMENT '角色id',
  `resource_id` bigint DEFAULT NULL COMMENT '资源主键id',
  `create_time` datetime DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `create_id` bigint DEFAULT NULL COMMENT '创建人ID',
  `modify_time` datetime DEFAULT CURRENT_TIMESTAMP COMMENT '修改时间',
  `modify_id` bigint DEFAULT NULL COMMENT '修改人ID',
  PRIMARY KEY (`id`),
  KEY `idx_menu_id` (`menu_id`),
  KEY `idx_role_id` (`role_id`),
  KEY `idx_resource_id` (`resource_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='角色资源表';

-- 用户登录日志表（基于实际数据库结构）
CREATE TABLE `s_user_login_log` (
  `id` bigint NOT NULL AUTO_INCREMENT COMMENT '主键ID',
  `login_time` datetime DEFAULT NULL COMMENT '登录时间',
  `account` varchar(255) DEFAULT NULL COMMENT '账号',
  `user_id` bigint DEFAULT NULL COMMENT '用户ID',
  `user_name` varchar(255) DEFAULT NULL COMMENT '用户名',
  `mobile` varchar(20) DEFAULT NULL COMMENT '手机号',
  `grant_type` varchar(255) DEFAULT NULL COMMENT '授权类型',
  `operation` varchar(400) DEFAULT NULL COMMENT '操作',
  `failed_message` varchar(300) DEFAULT NULL COMMENT '失败信息',
  `success_flag` tinyint(1) DEFAULT NULL COMMENT '成功标识',
  `cluster_success` tinyint(1) DEFAULT NULL COMMENT '集群成功标识',
  `platform` varchar(255) DEFAULT NULL COMMENT '平台',
  `ip_address` varchar(50) DEFAULT NULL COMMENT 'IP地址',
  `destination` varchar(255) DEFAULT NULL COMMENT '归属地',
  `device_name` varchar(255) DEFAULT NULL COMMENT '设备名称',
  `resolution` varchar(50) DEFAULT NULL COMMENT '分辨率',
  `app_version` varchar(50) DEFAULT NULL COMMENT 'app 版本号',
  `sys_name` varchar(255) DEFAULT NULL COMMENT '操作系统名称',
  `sys_version` varchar(50) DEFAULT NULL COMMENT '操作系统版本',
  `device_id` varchar(255) DEFAULT NULL COMMENT '设备ID',
  `manufacturer_name` varchar(255) DEFAULT NULL COMMENT '制造商名称',
  `mac` varchar(50) DEFAULT NULL COMMENT 'mac地址',
  PRIMARY KEY (`id`),
  KEY `idx_user_id` (`user_id`),
  KEY `idx_login_time` (`login_time`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='登录信息表';

-- 系统全局日志表（基于实际数据库结构）
CREATE TABLE `s_global_log` (
  `id` bigint NOT NULL AUTO_INCREMENT COMMENT '主键ID',
  `user_id` bigint DEFAULT NULL COMMENT '用户ID',
  `user_name` varchar(255) DEFAULT NULL COMMENT '用户名',
  `operation` varchar(400) DEFAULT NULL COMMENT '操作',
  `method` varchar(10) DEFAULT NULL COMMENT '请求方法',
  `params` text DEFAULT NULL COMMENT '请求参数',
  `time` bigint DEFAULT NULL COMMENT '执行时长(毫秒)',
  `ip` varchar(64) DEFAULT NULL COMMENT 'IP地址',
  `create_time` datetime DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  PRIMARY KEY (`id`),
  KEY `idx_user_id` (`user_id`),
  KEY `idx_create_time` (`create_time`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='系统全局日志表';

-- 手机验证码日志表（基于实际数据库结构）
CREATE TABLE `s_mobile_verification_log` (
  `id` bigint NOT NULL AUTO_INCREMENT COMMENT '主键ID',
  `mobile` varchar(20) DEFAULT NULL COMMENT '手机号码',
  `email` varchar(100) DEFAULT NULL COMMENT '邮箱',
  `ip_address` varchar(100) DEFAULT NULL COMMENT 'ip地址',
  `destination` varchar(100) DEFAULT NULL COMMENT '归属地',
  `verification` int DEFAULT NULL COMMENT '验证码',
  `send_time` datetime DEFAULT NULL COMMENT '发送时间',
  `client_id` varchar(100) DEFAULT NULL COMMENT '发送的客户端',
  `type` tinyint DEFAULT NULL COMMENT '类型，1 注册 2 忘记密码 3修改邮箱 4修改手机号码 5 登录',
  `status` tinyint(1) DEFAULT NULL COMMENT '是否有效',
  `create_time` datetime DEFAULT now() COMMENT '创建时间',
  `modify_time` datetime DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
  PRIMARY KEY (`id`),
  KEY `idx_mobile` (`mobile`),
  KEY `idx_send_time` (`send_time`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='验证码日志表';

-- ========================
-- 索引优化
-- ========================

-- 用户表优化索引
ALTER TABLE `s_users` ADD INDEX `idx_enterprise_id` (`enterprise_id`);
ALTER TABLE `s_users` ADD INDEX `idx_status` (`status`);
ALTER TABLE `s_users` ADD INDEX `idx_register_time` (`register_time`);

-- 角色表优化索引
ALTER TABLE `s_roles` ADD INDEX `idx_type` (`type`);
ALTER TABLE `s_roles` ADD INDEX `idx_enterprise_admin` (`enterprise_admin`);

-- 菜单表优化索引
ALTER TABLE `s_menu` ADD INDEX `idx_sort_id` (`sort_id`);
ALTER TABLE `s_menu` ADD INDEX `idx_system_code` (`system_code`);

-- 字典表优化索引
ALTER TABLE `s_dictionary` ADD INDEX `idx_status` (`status`);
ALTER TABLE `s_dictionary` ADD INDEX `idx_sort_id` (`sort_id`);

-- ========================
-- 初始化数据
-- ========================

-- 插入默认系统管理员
INSERT INTO `s_users` (`id`, `account`, `pwd`, `chinese_name`, `email`, `mobile`, `status`, `user_type`)
VALUES (1, 'admin', '$2a$10$N.zmdr9k7uOCQb376NoUnuTJ8iYqiSfFDYZt/I5/BFnhKSLsVBDSC', '系统管理员', 'admin@example.com', '13800138000', 1, 4);

-- 插入默认角色
INSERT INTO `s_roles` (`id`, `name`, `type`, `description`)
VALUES (1, '超级管理员', 1, '系统超级管理员，拥有所有权限');

-- 建立管理员角色关系
INSERT INTO `s_user_role` (`user_id`, `role_id`)
VALUES (1, 1);

-- ========================
-- 表结构说明
-- ========================

/*
1. 用户管理模块:
   - s_users: 用户基本信息表，支持多渠道登录
   - s_roles: 角色管理表，支持企业级权限控制
   - s_user_role: 用户角色关系表

2. 权限管理模块:
   - s_menu: 菜单管理表，支持树形结构
   - s_resource: 资源管理表，API和页面权限控制
   - s_role_menu: 角色菜单关系表
   - s_page_role: 角色资源关系表

3. 系统功能模块:
   - s_dictionary: 数据字典表，支持多语言
   - s_global_log: 系统操作日志表
   - s_user_login_log: 用户登录日志表
   - s_mobile_verification_log: 验证码发送日志表

4. OAuth2认证模块:
   - oauth2_authorization: OAuth2授权管理
   - oauth2_registered_client: OAuth2客户端注册

5. 关键特性:
   - 支持企业级多租户架构
   - 完整的RBAC权限控制
   - 详细的操作日志记录
   - OAuth2现代化认证
   - 多渠道用户登录支持
*/