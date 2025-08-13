
CREATE TABLE `s_users` (
  `id` bigint(20) NOT NULL COMMENT '系统用户唯一ID',
  `account` varchar(50) DEFAULT NULL COMMENT '用户系统账号',
  `pwd` varchar(50) DEFAULT NULL COMMENT '系统密码',
  `chinese_name` varchar(50) DEFAULT NULL COMMENT '中文名称',
  `nickname` varchar(50) DEFAULT NULL COMMENT '用户昵称',
  `email` varchar(50) DEFAULT NULL COMMENT '用户邮箱',
  `mobile` varchar(30) DEFAULT NULL COMMENT '手机号码',
  `last_date` datetime DEFAULT NULL COMMENT '最后登录时间',
  `sex` varchar(8) DEFAULT NULL COMMENT '性别',
  `birthday` datetime DEFAULT NULL COMMENT '出生年月',
  `nationality` varchar(100) DEFAULT NULL COMMENT '国籍',
  `province` varchar(100) DEFAULT NULL COMMENT '省份',
  `cities` varchar(100) DEFAULT NULL COMMENT '城市',
  `address` varchar(255) DEFAULT NULL COMMENT '居住地址',
  `id_type` int(11) DEFAULT NULL COMMENT '证件类型',
  `id_number` varchar(36) DEFAULT NULL COMMENT '证件号',
  `education` varchar(36) DEFAULT NULL COMMENT '学历',
  `age` int(11) DEFAULT NULL COMMENT '年龄',
  `household` varchar(24) DEFAULT NULL COMMENT '户籍地址',
  `ethnic` varchar(24) DEFAULT NULL COMMENT '民族',
  `blood` varchar(24) DEFAULT NULL COMMENT '血型',
  `career` varchar(24) DEFAULT NULL COMMENT '职业',
  `register_time` datetime DEFAULT CURRENT_TIMESTAMP COMMENT '注册时间',
  `status` int(11) NOT NULL COMMENT '激活状态',
  `login_type` int(11) DEFAULT NULL COMMENT '登陆类型',
  `skin` varchar(20) DEFAULT NULL COMMENT '用户皮肤',
  `modify_time` datetime DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '修改时间',
  `modify_id` varchar(36) DEFAULT NULL COMMENT '修改人',
  `role_id` bigint(20) DEFAULT NULL COMMENT '角色ID',
  `image_url` varchar(300) DEFAULT NULL COMMENT '头像路径',
  `user_type` int(11) DEFAULT NULL COMMENT '用户类型',
  `register_type` int(11) DEFAULT NULL COMMENT '注册类型',
  `register_code` varchar(36) DEFAULT NULL COMMENT '注册码',
  `qq_number` varchar(30) DEFAULT NULL COMMENT 'qq账号',
  `wechat` varchar(30) DEFAULT NULL COMMENT '微信号',
  `weibo` varchar(200) DEFAULT NULL COMMENT '微博地址',
  `open_id_wechat` varchar(36) DEFAULT NULL COMMENT '微信的openID',
  `open_id_qq` varchar(36) DEFAULT NULL COMMENT 'qq注册生成id',
  `open_id_weibo` varchar(36) DEFAULT NULL COMMENT '微博注册生成ID',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 ROW_FORMAT=COMPACT;


CREATE TABLE `s_menu` (
  `id` bigint(20) NOT NULL COMMENT '菜单的主键ID',
  `sort_id` int(11) DEFAULT NULL COMMENT '排序ID',
  `parent_id` bigint(20) DEFAULT NULL COMMENT '父级ID',
  `name` varchar(64) NOT NULL COMMENT '菜单名称',
  `url` varchar(255) DEFAULT NULL COMMENT '菜单URL',
  `icon_class` varchar(100) DEFAULT NULL COMMENT '菜单Class属性对应菜单的图标样式',
  `description` varchar(100) DEFAULT NULL COMMENT '备注',
  `create_id` bigint(20) DEFAULT NULL COMMENT '创建人',
  `create_time` datetime DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `modify_id` bigint(20) DEFAULT NULL COMMENT '修改人',
  `modify_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '修改时间',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 ROW_FORMAT=COMPACT;

CREATE TABLE `s_roles` (
  `id` bigint(20) NOT NULL COMMENT '角色id',
  `sort_id` int(11) DEFAULT NULL COMMENT '排序的id',
  `name` varchar(64) DEFAULT NULL COMMENT '角色名称',
  `description` varchar(500) DEFAULT NULL COMMENT '角色描述',
  `create_time` datetime DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `create_id` bigint(20) DEFAULT NULL COMMENT '创建人ID',
  `modify_time` datetime DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '修改时间',
  `modify_id` bigint(20) DEFAULT NULL COMMENT '修改人ID',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 ROW_FORMAT=COMPACT;

CREATE TABLE `s_role_menu` (
  `id` bigint(20) NOT NULL,
  `role_id` bigint(20) DEFAULT NULL COMMENT '角色ID',
  `menu_id` bigint(20) NOT NULL COMMENT '菜单ID',
  `create_id` bigint(20) DEFAULT NULL COMMENT '创建人',
  `create_time` datetime DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '创建时间',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 ROW_FORMAT=COMPACT;