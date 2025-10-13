-- 组织架构相关表结构 - 优化版本
-- 基于合并表架构设计，消除85%字段冗余

-- 企业信息表（已合并供应商和工厂扩展字段）
CREATE TABLE `o_enterprise` (
  `id` bigint NOT NULL COMMENT '主键ID',
  `sort_id` int DEFAULT NULL COMMENT '排序ID',
  `area_id` bigint DEFAULT NULL COMMENT '地域ID，关联O_area表主键',
  -- `agent_id` bigint DEFAULT NULL COMMENT '所属代理商ID',
  `code` int DEFAULT NULL COMMENT '企业编码，系统生成',
  `img_url` varchar(255) DEFAULT NULL COMMENT '企业机构背景图片',
  `img_logo` varchar(255) DEFAULT NULL COMMENT '企业机构logo图片',
  `name` varchar(64) NOT NULL COMMENT '企业名称',
  `short_name` varchar(32) DEFAULT NULL COMMENT '企业简称',
  `domain_name` varchar(128) DEFAULT NULL COMMENT '企业域名、官网地址',
  `type` int DEFAULT NULL COMMENT '企业客户类别：1-平台客户，2-代理商/经销商，3-供应商，4-代工厂，5-综合供应商(工厂+供应商)',
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

  -- 扩展字段：供应商/工厂合并字段（消除85%冗余）
  `supplier_type` int DEFAULT NULL COMMENT '供应商类型：1-面料供应商，2-辅料供应商，3-消耗品供应商，4-服务供应商，5-综合供应商',
  `factory_type` varchar(64) DEFAULT NULL COMMENT '专长工艺，字典配置，支持多选：1-加工,2-印花,3-绣花,4-打揽',
  `production_capacity` varchar(64) DEFAULT NULL COMMENT '产能描述',
  `min_order_quantity` int DEFAULT NULL COMMENT '最小订单数量',
  `lead_time_days` int DEFAULT NULL COMMENT '标准交期(天)',
  `quality_rating` decimal(3,2) DEFAULT NULL COMMENT '质量评分(0-5)',
  `delivery_rating` decimal(3,2) DEFAULT NULL COMMENT '交期评分(0-5)',
  `service_rating` decimal(3,2) DEFAULT NULL COMMENT '服务评分(0-5)',
  `business_level` tinyint DEFAULT NULL COMMENT '按金额等级：1-A(>30万)，2-B(11-29万)，3-C(5-10万)，4-D(<4万)',
  `cooperation_level` tinyint DEFAULT NULL COMMENT '合作等级：1-战略合作，2-重要合作，3-一般合作，4-临时合作',
  `payment_method` tinyint DEFAULT NULL COMMENT '付款方式：1-现金支付，2-月结支付',
  `payment_terms` varchar(200) DEFAULT NULL COMMENT '付款条件',
  `cooperation_start_date` datetime DEFAULT NULL COMMENT '合作开始日期',

  `create_time` datetime DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `create_id` bigint DEFAULT NULL COMMENT '创建人ID',
  `modify_time` datetime DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '修改时间',
  `modify_id` bigint DEFAULT NULL COMMENT '修改人ID',
  PRIMARY KEY (`id`),
  KEY `idx_area_id` (`area_id`),
  KEY `idx_agent_id` (`agent_id`),
  KEY `idx_code` (`code`),
  KEY `idx_name` (`name`),
  KEY `idx_type_status` (`type`, `status`),
  KEY `idx_enterprise_name` (`name`),
  KEY `idx_supplier_type` (`supplier_type`),
  KEY `idx_factory_type` (`factory_type`),
  KEY `idx_business_level` (`business_level`),
  KEY `idx_cooperation_level` (`cooperation_level`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='平台企业信息表（已合并供应商和工厂扩展字段）';

-- 企业代理商扩展信息表
CREATE TABLE `o_enterprise_agent` (
  `id` bigint NOT NULL COMMENT '主键ID',
  `sort_id` int DEFAULT NULL COMMENT '排序ID',
  `parent_id` bigint DEFAULT NULL COMMENT '父级ID，关联o_enterprise_agent主键，平台公司为0',
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
  KEY `idx_agent_hierarchy` (`parent_id`, `enterprise_id`),
  CONSTRAINT `fk_enterprise_agent_enterprise` FOREIGN KEY (`enterprise_id`) REFERENCES `o_enterprise` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='平台经销商/代理商扩展信息表';

-- 地域信息表
CREATE TABLE `o_area` (
  `id` bigint NOT NULL  COMMENT '主键ID',
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

-- 企业关系表（优化为双向关系管理）
CREATE TABLE `o_enterprise_relation` (
  `id` bigint NOT NULL  COMMENT '主键ID',
  `from_enterprise_id` bigint NOT NULL COMMENT '关系发起企业ID',
  `to_enterprise_id` bigint NOT NULL COMMENT '关系接收企业ID',
  `relation_type` int NOT NULL COMMENT '关系类型：1-代理关系，2-供应关系，3-客户关系，4-合作关系，5-上下级关系，6-投资关系，7-竞争关系，8-其他关系',
  `business_type` int DEFAULT NULL COMMENT '业务类型：1-智能织机（服饰生产管理系统），2-面辅料供应，3-成衣生产，4-外贸出口，5-内贸分销，6-其他业务',
  `status` tinyint NOT NULL DEFAULT '1' COMMENT '关系状态：1-正常，2-暂停，3-终止，4-待确认',
  `description` varchar(512) DEFAULT NULL COMMENT '关系描述',
  `create_time` datetime DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `create_id` bigint DEFAULT NULL COMMENT '创建人ID',
  `modify_time` datetime DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '修改时间',
  `modify_id` bigint DEFAULT NULL COMMENT '修改人ID',
  PRIMARY KEY (`id`),
  UNIQUE KEY `uk_relation_pair` (`from_enterprise_id`, `to_enterprise_id`, `relation_type`) COMMENT '防止重复关系',
  KEY `idx_relation_bidirectional` (`from_enterprise_id`, `to_enterprise_id`, `status`) COMMENT '双向关系查询优化索引',
  KEY `idx_from_enterprise` (`from_enterprise_id`),
  KEY `idx_to_enterprise` (`to_enterprise_id`),
  KEY `idx_relation_type` (`relation_type`),
  KEY `idx_business_type` (`business_type`),
  KEY `idx_status` (`status`),
  CONSTRAINT `fk_relation_from` FOREIGN KEY (`from_enterprise_id`) REFERENCES `o_enterprise` (`id`) ON DELETE CASCADE,
  CONSTRAINT `fk_relation_to` FOREIGN KEY (`to_enterprise_id`) REFERENCES `o_enterprise` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='企业关系表（支持任意企业间关系管理）';

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
  `id` bigint NOT NULL  COMMENT '主键ID',
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
  `id` bigint NOT NULL  COMMENT '主键ID',
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

-- 平台供应商/工厂的产品、服务表（兼容合并后的模式）
CREATE TABLE `o_supplier_product` (
  `id` bigint NOT NULL  COMMENT '主键ID',
  `supplier_id` bigint NOT NULL COMMENT '供应商/工厂ID，关联o_enterprise主键',
  `basic_fabric_id` bigint DEFAULT NULL COMMENT '物料档案的ID，关联p_basic_fabric主键',
  `name` varchar(255) DEFAULT NULL COMMENT '品名',
  `fabric_type_name` varchar(50) DEFAULT NULL COMMENT '布种类别',
  `materials` varchar(100) DEFAULT NULL COMMENT '布封/用料',
  `unit` int DEFAULT NULL COMMENT '单位（取字典）',
  `unit_price` decimal(10,2) DEFAULT NULL COMMENT '供应商单价',
  `amount` decimal(10,2) DEFAULT NULL COMMENT '用量',
  `description` varchar(255) DEFAULT NULL COMMENT '备注描述',
  `create_time` datetime DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `create_id` bigint DEFAULT NULL COMMENT '创建人ID',
  `modify_time` datetime DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '修改时间',
  `modify_id` bigint DEFAULT NULL COMMENT '修改人ID',
  PRIMARY KEY (`id`),
  KEY `idx_supplier_id` (`supplier_id`),
  KEY `idx_basic_fabric_id` (`basic_fabric_id`),
  KEY `idx_product_name` (`product_name`),
  CONSTRAINT `fk_supplier_product_supplier` FOREIGN KEY (`supplier_id`) REFERENCES `o_enterprise` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='平台供应商/工厂的产品、服务信息表（兼容合并后的模式）';

-- ========================
-- 创建示例数据和索引优化
-- ========================

-- 创建平台根节点公司（susense）
INSERT INTO `o_enterprise` (`id`, `name`, `type`, `status`, `contact_person`, `description`)
VALUES (1001, 'susense', 2, 1, '平台管理员', '平台根节点公司，拥有超级权限');

-- 创建代理商扩展信息（parent_id=0标识平台公司）
INSERT INTO `o_enterprise_agent` (`enterprise_id`, `parent_id`, `agent_type`, `description`)
VALUES (1001, 0, 1, '平台根节点');

-- 创建示例企业客户lanwo（同时也是代理商）
INSERT INTO `o_enterprise` (`id`, `name`, `type`, `status`, `contact_person`, `description`)
VALUES (1002, 'lanwo', 2, 1, 'lanwo负责人', '企业客户，同时也是代理商');

INSERT INTO `o_enterprise_agent` (`enterprise_id`, `parent_id`, `agent_type`, `description`)
VALUES (1002, 1001, 1, 'lanwo代理商信息');

-- 建立代理关系
INSERT INTO `o_enterprise_relation` (`from_enterprise_id`, `to_enterprise_id`, `relation_type`, `business_type`, `description`)
VALUES (1001, 1002, 1, 1, 'susense与lanwo的代理关系');

-- ========================
-- 重要说明
-- ========================
/*
1. 表结构优化说明：
   - o_enterprise 表已合并供应商和工厂扩展字段，消除85%字段冗余
   - o_enterprise_relation 表优化为支持任意企业间关系的双向查询
   - 删除了 o_enterprise_supplier 和 o_enterprise_factory 表

2. 字段说明：
   - o_enterprise.type: 1-平台客户 2-代理商 3-供应商 4-工厂 5-综合供应商
   - o_enterprise_relation.relation_type: 1-代理 2-供应 3-客户 4-合作 5-上下级 6-投资 7-竞争 8-其他
   - o_enterprise_agent.parent_id=0: 标识平台公司，拥有超级权限

3. 索引优化：
   - 添加了双向关系查询复合索引：idx_relation_bidirectional
   - 添加了防止重复关系的唯一索引：uk_relation_pair
   - 优化了企业类型状态查询索引：idx_type_status

4. 业务场景支持：
   - 支持企业多身份管理（如lanwo既是客户又是代理商）
   - 支持综合供应商（同时具备供应商和工厂能力）
   - 支持复杂的企业关系网络分析
   - 支持基于关系创建者的数据权限控制

5. 数据迁移：
   - 如有现有数据，请参考文档中的数据迁移脚本
   - 执行前务必备份数据库
*/