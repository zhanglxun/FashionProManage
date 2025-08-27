-- 组织架构相关表结构
-- 企业基础信息表
CREATE TABLE `c_enterprise` (
  `id` bigint NOT NULL AUTO_INCREMENT COMMENT '企业ID',
  `org_id` bigint NOT NULL COMMENT '所属平台组织ID',
  `enterprise_code` varchar(50) NOT NULL COMMENT '企业编码',
  `enterprise_name` varchar(200) NOT NULL COMMENT '企业名称',
  `enterprise_type` tinyint NOT NULL DEFAULT '1' COMMENT '企业类型：1-客户 2-供应商 3-工厂 4-代理商 5-经销商',
  `business_license` varchar(100) DEFAULT NULL COMMENT '营业执照号',
  `legal_person` varchar(50) DEFAULT NULL COMMENT '法人代表',
  `contact_person` varchar(50) DEFAULT NULL COMMENT '联系人',
  `contact_mobile` varchar(20) DEFAULT NULL COMMENT '联系电话',
  `contact_email` varchar(100) DEFAULT NULL COMMENT '联系邮箱',
  `address_province` varchar(50) DEFAULT NULL COMMENT '地址-省',
  `address_city` varchar(50) DEFAULT NULL COMMENT '地址-市',
  `address_area` varchar(50) DEFAULT NULL COMMENT '地址-区',
  `address_detail` varchar(255) DEFAULT NULL COMMENT '详细地址',
  `website` varchar(200) DEFAULT NULL COMMENT '官网地址',
  `status` tinyint NOT NULL DEFAULT '1' COMMENT '状态：1-正常 2-暂停 3-终止',
  `verification_status` tinyint DEFAULT '0' COMMENT '认证状态：0-未认证 1-已认证 2-认证失败',
  `remark` text COMMENT '备注',
  `create_id` bigint DEFAULT NULL COMMENT '创建人ID',
  `create_time` datetime DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `modify_id` bigint DEFAULT NULL COMMENT '修改人ID',
  `modify_time` datetime DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '修改时间',
  PRIMARY KEY (`id`),
  UNIQUE KEY `uk_enterprise_code` (`org_id`, `enterprise_code`),
  KEY `idx_enterprise_name` (`enterprise_name`),
  KEY `idx_enterprise_type` (`enterprise_type`),
  KEY `idx_status` (`status`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='企业基础信息表';

-- 客户扩展信息表
CREATE TABLE `c_enterprise_customer` (
  `id` bigint NOT NULL AUTO_INCREMENT COMMENT '主键ID',
  `enterprise_id` bigint NOT NULL COMMENT '企业ID',
  `customer_level` tinyint DEFAULT '1' COMMENT '客户等级：1-VIP客户 2-重要客户 3-一般客户 4-潜在客户',
  `annual_purchase_amount` decimal(15,2) DEFAULT NULL COMMENT '年采购金额',
  `main_products` varchar(500) DEFAULT NULL COMMENT '主要采购产品',
  `sales_representative` varchar(50) DEFAULT NULL COMMENT '销售代表',
  `payment_terms` varchar(200) DEFAULT NULL COMMENT '付款条件',
  `credit_limit` decimal(15,2) DEFAULT NULL COMMENT '信用额度',
  `cooperation_start_date` date DEFAULT NULL COMMENT '合作开始日期',
  `create_id` bigint DEFAULT NULL COMMENT '创建人ID',
  `create_time` datetime DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `modify_id` bigint DEFAULT NULL COMMENT '修改人ID',
  `modify_time` datetime DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '修改时间',
  PRIMARY KEY (`id`),
  UNIQUE KEY `uk_enterprise_customer` (`enterprise_id`),
  KEY `idx_customer_level` (`customer_level`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='客户扩展信息表';

-- 供应商扩展信息表
CREATE TABLE `c_enterprise_supplier` (
  `id` bigint NOT NULL AUTO_INCREMENT COMMENT '主键ID',
  `enterprise_id` bigint NOT NULL COMMENT '企业ID',
  `supplier_type` tinyint NOT NULL DEFAULT '1' COMMENT '供应商类型：1-面料供应商 2-辅料供应商 3-设备供应商 4-服务供应商 5-综合供应商',
  `main_products` varchar(500) DEFAULT NULL COMMENT '主要产品',
  `supply_capacity` varchar(200) DEFAULT NULL COMMENT '供应能力',
  `min_order_amount` decimal(12,2) DEFAULT NULL COMMENT '最小订单金额',
  `lead_time_days` int DEFAULT NULL COMMENT '标准交期(天)',
  `quality_rating` decimal(3,2) DEFAULT NULL COMMENT '质量评分(0-5)',
  `delivery_rating` decimal(3,2) DEFAULT NULL COMMENT '交期评分(0-5)',
  `service_rating` decimal(3,2) DEFAULT NULL COMMENT '服务评分(0-5)',
  `payment_terms` varchar(200) DEFAULT NULL COMMENT '付款条件',
  `cooperation_level` tinyint DEFAULT '1' COMMENT '合作等级：1-战略合作 2-重要合作 3-一般合作 4-临时合作',
  `cooperation_start_date` date DEFAULT NULL COMMENT '合作开始日期',
  `create_id` bigint DEFAULT NULL COMMENT '创建人ID',
  `create_time` datetime DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `modify_id` bigint DEFAULT NULL COMMENT '修改人ID',
  `modify_time` datetime DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '修改时间',
  PRIMARY KEY (`id`),
  UNIQUE KEY `uk_enterprise_supplier` (`enterprise_id`),
  KEY `idx_supplier_type` (`supplier_type`),
  KEY `idx_cooperation_level` (`cooperation_level`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='供应商扩展信息表';

-- 工厂扩展信息表
CREATE TABLE `c_enterprise_factory` (
  `id` bigint NOT NULL AUTO_INCREMENT COMMENT '主键ID',
  `enterprise_id` bigint NOT NULL COMMENT '企业ID',
  `factory_area` decimal(10,2) DEFAULT NULL COMMENT '工厂面积(平方米)',
  `employee_count` int DEFAULT NULL COMMENT '员工数量',
  `production_capacity` varchar(200) DEFAULT NULL COMMENT '产能描述',
  `specialized_process` varchar(500) DEFAULT NULL COMMENT '专长工艺',
  `equipment_info` text COMMENT '设备信息',
  `quality_system` varchar(200) DEFAULT NULL COMMENT '质量体系认证',
  `min_order_quantity` int DEFAULT NULL COMMENT '最小订单数量',
  `lead_time_days` int DEFAULT NULL COMMENT '标准交期(天)',
  `quality_rating` decimal(3,2) DEFAULT NULL COMMENT '质量评分(0-5)',
  `delivery_rating` decimal(3,2) DEFAULT NULL COMMENT '交期评分(0-5)',
  `service_rating` decimal(3,2) DEFAULT NULL COMMENT '服务评分(0-5)',
  `cooperation_level` tinyint DEFAULT '1' COMMENT '合作等级：1-战略合作 2-重要合作 3-一般合作 4-临时合作',
  `payment_terms` varchar(200) DEFAULT NULL COMMENT '付款条件',
  `cooperation_start_date` date DEFAULT NULL COMMENT '合作开始日期',
  `create_id` bigint DEFAULT NULL COMMENT '创建人ID',
  `create_time` datetime DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `modify_id` bigint DEFAULT NULL COMMENT '修改人ID',
  `modify_time` datetime DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '修改时间',
  PRIMARY KEY (`id`),
  UNIQUE KEY `uk_enterprise_factory` (`enterprise_id`),
  KEY `idx_employee_count` (`employee_count`),
  KEY `idx_cooperation_level` (`cooperation_level`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='工厂扩展信息表';

-- 代理商扩展信息表
CREATE TABLE `c_enterprise_agent` (
  `id` bigint NOT NULL AUTO_INCREMENT COMMENT '主键ID',
  `enterprise_id` bigint NOT NULL COMMENT '企业ID',
  `agent_type` tinyint NOT NULL DEFAULT '1' COMMENT '代理商类型：1-区域代理 2-产品代理 3-渠道代理',
  `agent_area` varchar(200) DEFAULT NULL COMMENT '代理区域',
  `agent_products` varchar(500) DEFAULT NULL COMMENT '代理产品',
  `commission_rate` decimal(5,2) DEFAULT NULL COMMENT '佣金比例(%)',
  `sales_target` decimal(15,2) DEFAULT NULL COMMENT '销售目标',
  `cooperation_start_date` date DEFAULT NULL COMMENT '合作开始日期',
  `cooperation_end_date` date DEFAULT NULL COMMENT '合作结束日期',
  `contract_number` varchar(100) DEFAULT NULL COMMENT '合同编号',
  `create_id` bigint DEFAULT NULL COMMENT '创建人ID',
  `create_time` datetime DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `modify_id` bigint DEFAULT NULL COMMENT '修改人ID',
  `modify_time` datetime DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '修改时间',
  PRIMARY KEY (`id`),
  UNIQUE KEY `uk_enterprise_agent` (`enterprise_id`),
  KEY `idx_agent_type` (`agent_type`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='代理商扩展信息表';

-- 经销商扩展信息表
CREATE TABLE `c_enterprise_dealer` (
  `id` bigint NOT NULL AUTO_INCREMENT COMMENT '主键ID',
  `enterprise_id` bigint NOT NULL COMMENT '企业ID',
  `dealer_level` tinyint DEFAULT '1' COMMENT '经销商等级：1-一级经销商 2-二级经销商 3-三级经销商',
  `dealer_area` varchar(200) DEFAULT NULL COMMENT '经销区域',
  `dealer_products` varchar(500) DEFAULT NULL COMMENT '经销产品',
  `discount_rate` decimal(5,2) DEFAULT NULL COMMENT '折扣率(%)',
  `sales_target` decimal(15,2) DEFAULT NULL COMMENT '销售目标',
  `cooperation_start_date` date DEFAULT NULL COMMENT '合作开始日期',
  `cooperation_end_date` date DEFAULT NULL COMMENT '合作结束日期',
  `contract_number` varchar(100) DEFAULT NULL COMMENT '合同编号',
  `create_id` bigint DEFAULT NULL COMMENT '创建人ID',
  `create_time` datetime DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `modify_id` bigint DEFAULT NULL COMMENT '修改人ID',
  `modify_time` datetime DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '修改时间',
  PRIMARY KEY (`id`),
  UNIQUE KEY `uk_enterprise_dealer` (`enterprise_id`),
  KEY `idx_dealer_level` (`dealer_level`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='经销商扩展信息表';

-- 企业评价记录表
CREATE TABLE `c_enterprise_evaluation` (
  `id` bigint NOT NULL AUTO_INCREMENT COMMENT '评价ID',
  `enterprise_id` bigint NOT NULL COMMENT '企业ID',
  `evaluation_type` tinyint NOT NULL COMMENT '评价类型：1-客户评价 2-供应商评价 3-工厂评价',
  `order_id` bigint DEFAULT NULL COMMENT '关联订单ID',
  `evaluation_date` date NOT NULL COMMENT '评价日期',
  `quality_score` decimal(3,2) DEFAULT NULL COMMENT '质量评分(0-5)',
  `delivery_score` decimal(3,2) DEFAULT NULL COMMENT '交期评分(0-5)',
  `service_score` decimal(3,2) DEFAULT NULL COMMENT '服务评分(0-5)',
  `price_score` decimal(3,2) DEFAULT NULL COMMENT '价格评分(0-5)',
  `overall_score` decimal(3,2) DEFAULT NULL COMMENT '综合评分(0-5)',
  `evaluation_content` text COMMENT '评价内容',
  `evaluator_id` bigint NOT NULL COMMENT '评价人ID',
  `create_time` datetime DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  PRIMARY KEY (`id`),
  KEY `idx_enterprise_id` (`enterprise_id`),
  KEY `idx_evaluation_type` (`evaluation_type`),
  KEY `idx_evaluation_date` (`evaluation_date`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='企业评价记录表';
