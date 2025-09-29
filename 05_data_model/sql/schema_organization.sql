-- 组织架构相关表结构
-- 基于实际业务需求设计

-- 企业信息表
CREATE TABLE `o_enterprise` (
  `id` bigint NOT NULL COMMENT '主键ID',
  `sort_id` int DEFAULT NULL COMMENT '排序ID',
  `area_id` bigint DEFAULT NULL COMMENT '地域ID，关联O_area表主键',
  `agent_id` bigint DEFAULT NULL COMMENT '所属代理商ID',
  `code` int DEFAULT NULL COMMENT '企业编码，系统生成',
  `img_url` varchar(255) DEFAULT NULL COMMENT '企业机构背景图片',
  `img_logo` varchar(255) DEFAULT NULL COMMENT '企业机构logo图片',
  `name` varchar(64) NOT NULL COMMENT '企业名称',
  `short_name` varchar(32) DEFAULT NULL COMMENT '企业简称',
  `domain_name` varchar(128) DEFAULT NULL COMMENT '企业域名、官网地址',
  `type` int DEFAULT NULL COMMENT '企业客户类别：1-平台客户，2-代理商/经销商，3-供应商，4-代工厂',
  `source` int DEFAULT NULL COMMENT '客户渠道来源：1-自然注册，2-客户转介绍，3-客户录入',
  `scale` varchar(24) DEFAULT NULL COMMENT '人员规模，字典配置',
  `legal_person` varchar(50) DEFAULT NULL COMMENT '企业法人',
  `contact_person` varchar(24) DEFAULT NULL COMMENT '联系人姓名',
  `contact_email` varchar(32) DEFAULT NULL COMMENT '联系人邮箱',
  `contact_mobile` varchar(16) DEFAULT NULL COMMENT '联系人电话',
  `landline_phone` varchar(16) DEFAULT NULL COMMENT '座机电话',
  `address_province` varchar(16) DEFAULT NULL COMMENT '省份',
  `address_city` varchar(16) DEFAULT NULL COMMENT '市',
  `address_area` varchar(16) DEFAULT NULL COMMENT '区',
  `address_detail` varchar(128) DEFAULT NULL COMMENT '详细地址',
  `status` int NOT NULL DEFAULT '1' COMMENT '状态：1-启用，0-禁用',
  `verification_status` int DEFAULT '0' COMMENT '认证状态：0-未认证，1-已认证，2-认证失败',
  `description` varchar(128) DEFAULT NULL COMMENT '描述和备注',
  `create_time` datetime DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `create_id` bigint DEFAULT NULL COMMENT '创建人ID',
  `modify_time` datetime DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '修改时间',
  `modify_id` bigint DEFAULT NULL COMMENT '修改人ID',
  PRIMARY KEY (`id`),
  KEY `idx_area_id` (`area_id`),
  KEY `idx_agent_id` (`agent_id`),
  KEY `idx_code` (`code`),
  KEY `idx_name` (`name`),
  KEY `idx_type` (`type`),
  KEY `idx_status` (`status`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='平台企业客户信息表';

-- 企业代理商扩展信息表
CREATE TABLE `o_enterprise_agent` (
  `id` bigint NOT NULL COMMENT '主键ID',
  `sort_id` int DEFAULT NULL COMMENT '排序ID',
  `parent_id` bigint DEFAULT NULL COMMENT '父级ID，关联o_enterprise_agent主键',
  `enterprise_id` bigint NOT NULL COMMENT '企业ID，关联o_enterprise主键',
  `agent_type` int DEFAULT NULL COMMENT '代理商类型：1-区域代理，2-产品代理，3-渠道代理',
  `agent_area` varchar(200) DEFAULT NULL COMMENT '代理区域，支持多选',
  `commission_rate` decimal(5,2) DEFAULT NULL COMMENT '佣金比例(%)',
  `sales_target` varchar(100) DEFAULT NULL COMMENT '年度销售目标',
  `cooperation_start_date` datetime DEFAULT NULL COMMENT '合作开始日期',
  `cooperation_end_date` datetime DEFAULT NULL COMMENT '合作结束日期',
  `description` varchar(256) DEFAULT NULL COMMENT '描述备注',
  `create_time` datetime DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `create_id` bigint DEFAULT NULL COMMENT '创建人ID',
  `modify_time` datetime DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '修改时间',
  `modify_id` bigint DEFAULT NULL COMMENT '修改人ID',
  PRIMARY KEY (`id`),
  KEY `idx_parent_id` (`parent_id`),
  KEY `idx_enterprise_id` (`enterprise_id`),
  KEY `idx_agent_type` (`agent_type`),
  CONSTRAINT `fk_enterprise_agent_enterprise` FOREIGN KEY (`enterprise_id`) REFERENCES `o_enterprise` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='平台经销商/代理商扩展信息表';

-- 地域信息表
CREATE TABLE `o_area` (
  `id` bigint NOT NULL COMMENT '主键ID',
  `sort_id` int DEFAULT NULL COMMENT '排序ID',
  `parent_id` bigint DEFAULT NULL COMMENT '父级ID',
  `name` varchar(11) NOT NULL COMMENT '区域名称',
  `code` int DEFAULT NULL COMMENT '区域识别码',
  `status` tinyint NOT NULL DEFAULT '1' COMMENT '状态：1-启用，0-禁用',
  `create_time` datetime DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `create_id` bigint DEFAULT NULL COMMENT '创建人ID',
  `modify_time` datetime DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '修改时间',
  `modify_id` bigint DEFAULT NULL COMMENT '修改人ID',
  PRIMARY KEY (`id`),
  KEY `idx_parent_id` (`parent_id`),
  KEY `idx_code` (`code`),
  KEY `idx_name` (`name`),
  KEY `idx_status` (`status`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='地域信息表';

-- 机构关系表（代理商和企业的关系表）
CREATE TABLE `o_enterprise_relation` (
  `id` bigint NOT NULL COMMENT '主键ID',
  `agent_id` bigint DEFAULT NULL COMMENT '代理商ID，关联o_enterprise主键，类型为代理商',
  `enterprise_id` bigint DEFAULT NULL COMMENT '企业ID，关联o_enterprise主键，类型为企业',
  `type` int DEFAULT NULL COMMENT '管理映射：1-企业客户，2-代理商，3-供应商，4-工厂',
  `business_type` int DEFAULT NULL COMMENT '业务类型：1-智能织机（服饰生产管理系统），2-其他业务',
  `description` varchar(256) DEFAULT NULL COMMENT '描述和备注信息',
  `create_time` datetime DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `create_id` bigint DEFAULT NULL COMMENT '创建人ID',
  `modify_time` datetime DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '修改时间',
  `modify_id` bigint DEFAULT NULL COMMENT '修改人ID',
  PRIMARY KEY (`id`),
  KEY `idx_agent_id` (`agent_id`),
  KEY `idx_enterprise_id` (`enterprise_id`),
  KEY `idx_type` (`type`),
  KEY `idx_business_type` (`business_type`),
  CONSTRAINT `fk_enterprise_relation_agent` FOREIGN KEY (`agent_id`) REFERENCES `o_enterprise` (`id`) ON DELETE CASCADE,
  CONSTRAINT `fk_enterprise_relation_enterprise` FOREIGN KEY (`enterprise_id`) REFERENCES `o_enterprise` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='机构关系表，代理商和企业的关系表';

-- 企业参数定义表
CREATE TABLE `o_setting` (
  `id` bigint NOT NULL COMMENT '主键ID',
  `sort_id` int DEFAULT NULL COMMENT '排序ID',
  `parent_id` bigint DEFAULT NULL COMMENT '父级主键ID',
  `code` varchar(36) NOT NULL COMMENT '参数项识别码',
  `name` varchar(64) NOT NULL COMMENT '配置项名称',
  `type` int DEFAULT NULL COMMENT '值的类型：1-范围类型，2-开关类型，3-下拉类型，4-下拉多选',
  `value_unit` varchar(100) DEFAULT NULL COMMENT '单位',
  `value_list` varchar(128) DEFAULT NULL COMMENT '数据的数组',
  `status` int NOT NULL DEFAULT '1' COMMENT '状态：1-启用，0-禁用',
  `description` varchar(128) DEFAULT NULL COMMENT '描述备注信息',
  `create_time` datetime DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `create_id` bigint DEFAULT NULL COMMENT '创建人ID',
  `modify_time` datetime DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '修改时间',
  `modify_id` bigint DEFAULT NULL COMMENT '修改人ID',
  PRIMARY KEY (`id`),
  KEY `idx_sort_id` (`sort_id`),
  KEY `idx_parent_id` (`parent_id`),
  KEY `idx_code` (`code`),
  KEY `idx_name` (`name`),
  KEY `idx_type` (`type`),
  KEY `idx_status` (`status`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='企业参数定义表';

-- 企业部门信息表
CREATE TABLE `o_department` (
  `id` bigint NOT NULL COMMENT '主键ID',
  `parent_id` bigint DEFAULT '0' COMMENT '父级主键ID，父级根节点设置为0',
  `enterprise_id` bigint NOT NULL COMMENT '企业ID，关联o_enterprise主键',
  `name` varchar(36) NOT NULL COMMENT '部门名称',
  `description` varchar(36) DEFAULT NULL COMMENT '描述备注信息',
  `status` int NOT NULL DEFAULT '1' COMMENT '状态：1-启用，0-禁用',
  `create_time` datetime DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `create_id` bigint DEFAULT NULL COMMENT '创建人ID',
  `modify_time` datetime DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '修改时间',
  `modify_id` bigint DEFAULT NULL COMMENT '修改人ID',
  PRIMARY KEY (`id`),
  KEY `idx_parent_id` (`parent_id`),
  KEY `idx_enterprise_id` (`enterprise_id`),
  KEY `idx_name` (`name`),
  KEY `idx_status` (`status`),
  CONSTRAINT `fk_department_enterprise` FOREIGN KEY (`enterprise_id`) REFERENCES `o_enterprise` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='企业部门信息表';

-- 企业员工信息表
CREATE TABLE `o_staff` (
  `id` bigint NOT NULL COMMENT '主键ID',
  `enterprise_id` bigint NOT NULL COMMENT '企业ID，关联o_enterprise主键',
  `department_id` bigint DEFAULT NULL COMMENT '部门ID，关联o_department主键',
  `user_id` bigint DEFAULT NULL COMMENT '用户ID，关联s_users主键',
  `job_name` varchar(36) DEFAULT NULL COMMENT '岗位名称',
  `description` varchar(128) DEFAULT NULL COMMENT '备注信息',
  `create_time` datetime DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `create_id` bigint DEFAULT NULL COMMENT '创建人ID',
  `modify_time` datetime DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '修改时间',
  `modify_id` bigint DEFAULT NULL COMMENT '修改人ID',
  PRIMARY KEY (`id`),
  KEY `idx_enterprise_id` (`enterprise_id`),
  KEY `idx_department_id` (`department_id`),
  KEY `idx_user_id` (`user_id`),
  KEY `idx_job_name` (`job_name`),
  CONSTRAINT `fk_staff_enterprise` FOREIGN KEY (`enterprise_id`) REFERENCES `o_enterprise` (`id`) ON DELETE CASCADE,
  CONSTRAINT `fk_staff_department` FOREIGN KEY (`department_id`) REFERENCES `o_department` (`id`) ON DELETE SET NULL,
  CONSTRAINT `fk_staff_user` FOREIGN KEY (`user_id`) REFERENCES `s_users` (`id`) ON DELETE SET NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='企业员工信息表';

-- 企业偏好设置表
CREATE TABLE `o_config` (
  `id` bigint NOT NULL COMMENT '主键ID',
  `enterprise_id` bigint NOT NULL COMMENT '企业ID，关联o_enterprise主键',
  `setting_id` bigint NOT NULL COMMENT '配置项ID，关联o_setting主键',
  `status` int NOT NULL DEFAULT '1' COMMENT '是否有效：1-开启，0-关闭',
  `min_value` decimal(10,3) DEFAULT NULL COMMENT '最小值',
  `max_value` decimal(10,3) DEFAULT NULL COMMENT '最大值',
  `option_value` varchar(128) DEFAULT NULL COMMENT '下拉数值',
  `value_unit` varchar(100) DEFAULT NULL COMMENT '单位',
  `value_list` varchar(128) DEFAULT NULL COMMENT '数据的数组',
  `create_time` datetime DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `create_id` bigint DEFAULT NULL COMMENT '创建人ID',
  `modify_time` datetime DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '修改时间',
  `modify_id` bigint DEFAULT NULL COMMENT '修改人ID',
  PRIMARY KEY (`id`),
  KEY `idx_enterprise_id` (`enterprise_id`),
  KEY `idx_setting_id` (`setting_id`),
  KEY `idx_status` (`status`),
  CONSTRAINT `fk_config_enterprise` FOREIGN KEY (`enterprise_id`) REFERENCES `o_enterprise` (`id`) ON DELETE CASCADE,
  CONSTRAINT `fk_config_setting` FOREIGN KEY (`setting_id`) REFERENCES `o_setting` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='企业偏好设置表';

-- 平台企业的客户信息表
CREATE TABLE `o_customer` (
  `id` bigint NOT NULL COMMENT '主键ID',
  `enterprise_id` bigint NOT NULL COMMENT '企业ID，关联o_enterprise主键',
  `number` bigint DEFAULT NULL COMMENT '客户编号，自动编号',
  `name` varchar(36) NOT NULL COMMENT '客户名称',
  `short_name` varchar(36) DEFAULT NULL COMMENT '客户简称',
  `country` varchar(36) DEFAULT NULL COMMENT '所在国家',
  `type` int DEFAULT NULL COMMENT '客户类别：1-外贸客户，2-国内客户',
  `collection_type` int DEFAULT NULL COMMENT '客户收款方式，字典配置',
  `level` int DEFAULT NULL COMMENT '按金额等级：1-A(>30万)，2-B(11-29万)，3-C(5-10万)，4-D(<4万)',
  `value_scale` int DEFAULT NULL COMMENT '产值规模，数据字典定义',
  `sales_id` bigint DEFAULT NULL COMMENT '销售人员ID',
  `follower_id` bigint DEFAULT NULL COMMENT '跟单人员ID',
  `address` varchar(255) DEFAULT NULL COMMENT '客户地址',
  `status` int NOT NULL DEFAULT '1' COMMENT '状态：0-禁用，1-启用',
  `description` varchar(128) DEFAULT NULL COMMENT '描述和备注',
  `create_time` datetime DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `create_id` bigint DEFAULT NULL COMMENT '创建人ID',
  `modify_time` datetime DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '修改时间',
  `modify_id` bigint DEFAULT NULL COMMENT '修改人ID',
  PRIMARY KEY (`id`),
  KEY `idx_enterprise_id` (`enterprise_id`),
  KEY `idx_number` (`number`),
  KEY `idx_name` (`name`),
  KEY `idx_type` (`type`),
  KEY `idx_level` (`level`),
  KEY `idx_sales_id` (`sales_id`),
  KEY `idx_follower_id` (`follower_id`),
  KEY `idx_status` (`status`),
  CONSTRAINT `fk_customer_enterprise` FOREIGN KEY (`enterprise_id`) REFERENCES `o_enterprise` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='平台企业的客户信息表';

-- 客户联系人信息表
CREATE TABLE `o_contact` (
  `id` bigint NOT NULL COMMENT '主键ID',
  `customer_id` bigint NOT NULL COMMENT '客户ID，关联o_customer主键',
  `name` varchar(32) NOT NULL COMMENT '联系人姓名',
  `contact_type` tinyint DEFAULT NULL COMMENT '联系方式：1-电话，2-邮件，3-社媒账号(whatsapp)，4-telegram',
  `contact_information` varchar(36) NOT NULL COMMENT '联系方式信息',
  `create_time` datetime DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `create_id` bigint DEFAULT NULL COMMENT '创建人ID',
  `modify_time` datetime DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '修改时间',
  `modify_id` bigint DEFAULT NULL COMMENT '修改人ID',
  PRIMARY KEY (`id`),
  KEY `idx_customer_id` (`customer_id`),
  KEY `idx_name` (`name`),
  KEY `idx_contact_type` (`contact_type`),
  CONSTRAINT `fk_contact_customer` FOREIGN KEY (`customer_id`) REFERENCES `o_customer` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='客户联系人信息表';

-- 平台供应商扩展信息表
CREATE TABLE `o_enterprise_supplier` (
  `id` bigint NOT NULL COMMENT '主键ID',
  `enterprise_id` bigint NOT NULL COMMENT '企业ID，关联o_enterprise主键',
  `supplier_type` int DEFAULT NULL COMMENT '供应商类型：1-面料供应商，2-辅料供应商，3-消耗品供应商，4-服务供应商，5-综合供应商',
  `production_capacity` varchar(64) DEFAULT NULL COMMENT '产能描述',
  `min_order_quantity` int DEFAULT NULL COMMENT '最小订单数量',
  `lead_time_days` int DEFAULT NULL COMMENT '标准交期(天)',
  `quality_rating` decimal(3,2) DEFAULT NULL COMMENT '质量评分(0-5)',
  `delivery_rating` decimal(3,2) DEFAULT NULL COMMENT '交期评分(0-5)',
  `service_rating` decimal(3,2) DEFAULT NULL COMMENT '服务评分(0-5)',
  `level` tinyint DEFAULT NULL COMMENT '按金额等级：1-A(>30万)，2-B(11-29万)，3-C(5-10万)，4-D(<4万)',
  `cooperation_level` tinyint DEFAULT NULL COMMENT '合作等级：1-战略合作，2-重要合作，3-一般合作，4-临时合作',
  `payment_method` tinyint DEFAULT NULL COMMENT '付款方式：1-现金支付，2-月结支付',
  `payment_terms` varchar(200) DEFAULT NULL COMMENT '付款条件',
  `cooperation_start_date` datetime DEFAULT NULL COMMENT '合作开始日期',
  `create_time` datetime DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `create_id` bigint DEFAULT NULL COMMENT '创建人ID',
  `modify_time` datetime DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '修改时间',
  `modify_id` bigint DEFAULT NULL COMMENT '修改人ID',
  PRIMARY KEY (`id`),
  KEY `idx_enterprise_id` (`enterprise_id`),
  KEY `idx_supplier_type` (`supplier_type`),
  KEY `idx_level` (`level`),
  KEY `idx_cooperation_level` (`cooperation_level`),
  KEY `idx_payment_method` (`payment_method`),
  CONSTRAINT `fk_enterprise_supplier_enterprise` FOREIGN KEY (`enterprise_id`) REFERENCES `o_enterprise` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='平台供应商扩展信息表';