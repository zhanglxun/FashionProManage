-- 生产管理模块表结构

-- 基于服装生产管理业务需求设计

-- 样板打样 ====

-- 平台图片定义表
CREATE TABLE `p_images` (
  `id` bigint(20) NOT NULL COMMENT '主键ID',
  `sort` int DEFAULT NULL COMMENT '排序的ID',
  `type` int NOT NULL COMMENT '类型：1-款式资料图，2-样板资料图，3-订单资料图',
  `item_id` bigint(20) DEFAULT NULL COMMENT '关联ID：根据type不同，分别对应p_basic_style主键、p_template主键ID、p_order主键ID',
  `image_url` varchar(256) DEFAULT NULL COMMENT '图片的URL信息',
  `description` varchar(128) DEFAULT NULL COMMENT '图片的备注信息',
  `capacity` decimal(10,2) DEFAULT NULL COMMENT '图片容量大小（M为单位），用来后续做各客户的用量统计，上传时候计算带上',
  `create_time` datetime DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间、操作时间',
  `create_id` bigint(20) DEFAULT NULL COMMENT '创建人ID',
  PRIMARY KEY (`id`),
  KEY `idx_sort` (`sort`),
  KEY `idx_type` (`type`),
  KEY `idx_item_id` (`item_id`),
  KEY `idx_type_item` (`type`, `item_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='平台图片定义表：存储系统中的各种图片资源信息';



-- 大货生产



-- 基础资料配置

-- 仓库档案管理表
CREATE TABLE `p_basic_warehouse` (
  `id` bigint NOT NULL COMMENT '主键ID',
  `enterprise_id` bigint NOT NULL COMMENT '所属企业ID，关联o_enterprise主键',
  `name` varchar(64) NOT NULL COMMENT '仓库名称',
  `type` int DEFAULT NULL COMMENT '仓库类型，字典配置',
  `description` varchar(128) DEFAULT NULL COMMENT '描述信息',
  `status` int NOT NULL DEFAULT '1' COMMENT '状态：0-禁用，1-启用',
  `create_time` datetime DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `create_id` bigint DEFAULT NULL COMMENT '创建人ID',
  `modify_time` datetime DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '修改时间',
  `modify_id` bigint DEFAULT NULL COMMENT '修改人ID',
  PRIMARY KEY (`id`),
  KEY `idx_enterprise_id` (`enterprise_id`),
  KEY `idx_name` (`name`),
  KEY `idx_type` (`type`),
  KEY `idx_status` (`status`),
  CONSTRAINT `fk_warehouse_enterprise` FOREIGN KEY (`enterprise_id`) REFERENCES `o_enterprise` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='仓库档案管理表';

-- 工序模版管理主表
CREATE TABLE `p_basic_process` (
  `id` bigint NOT NULL COMMENT '主键ID',
  `enterprise_id` bigint NOT NULL COMMENT '所属企业ID，关联o_enterprise主键',
  `parent_id` bigint DEFAULT '0' COMMENT '父级ID，关联p_basic_process主键，顶级节点设置为0',
  `sort_id` int DEFAULT NULL COMMENT '排序ID',
  `name` varchar(36) NOT NULL COMMENT '工序名称',
  `basic_type_id` bigint DEFAULT NULL COMMENT '加工类型ID，关联p_basic_type主键',
  `working_hours` int DEFAULT NULL COMMENT '工时',
  `price` decimal(10,2) DEFAULT NULL COMMENT '单价',
  `temp_price` decimal(10,2) DEFAULT NULL COMMENT '临时工价',
  `is_open_price` tinyint(1) DEFAULT '0' COMMENT '是否开放单价：0-否，1-是',
  `is_count` tinyint(1) DEFAULT '0' COMMENT '是否计数：0-否，1-是',
  `is_key_process` tinyint(1) DEFAULT '0' COMMENT '是否关键工序：0-否，1-是',
  `is_assign_process` tinyint(1) DEFAULT '0' COMMENT '是否指派工序：0-否，1-是',
  `description` varchar(512) DEFAULT NULL COMMENT '工序要求说明',
  `status` int NOT NULL DEFAULT '1' COMMENT '状态：0-禁用，1-启用',
  `create_time` datetime DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `create_id` bigint DEFAULT NULL COMMENT '创建人ID',
  `modify_time` datetime DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '修改时间',
  `modify_id` bigint DEFAULT NULL COMMENT '修改人ID',
  PRIMARY KEY (`id`),
  KEY `idx_enterprise_id` (`enterprise_id`),
  KEY `idx_parent_id` (`parent_id`),
  KEY `idx_sort_id` (`sort_id`),
  KEY `idx_name` (`name`),
  KEY `idx_basic_type_id` (`basic_type_id`),
  KEY `idx_status` (`status`),
  KEY `idx_hierarchy` (`parent_id`, `sort_id`),
  CONSTRAINT `fk_process_enterprise` FOREIGN KEY (`enterprise_id`) REFERENCES `o_enterprise` (`id`) ON DELETE CASCADE,
  CONSTRAINT `fk_process_parent` FOREIGN KEY (`parent_id`) REFERENCES `p_basic_process` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='工序管理主表';

-- 加工类型基础数据管理表
CREATE TABLE `p_basic_type` (
  `id` bigint NOT NULL COMMENT '主键ID',
  `enterprise_id` bigint DEFAULT NULL COMMENT '所属企业ID，关联o_enterprise主键，平台默认类型为空',
  `type` int NOT NULL DEFAULT '1' COMMENT '加工类型区分：1-平台默认，2-企业自定义',
  `name` varchar(36) NOT NULL COMMENT '加工类型名称（如：裁剪、车缝、包装、印花、绣花、洗水、钉珠等）',
  `sort_id` int DEFAULT NULL COMMENT '排序ID',
  `status` int NOT NULL DEFAULT '1' COMMENT '启用状态：0-禁用，1-启用',
  `is_default` int NOT NULL DEFAULT '0' COMMENT '开单默认开启：0-否，1-是',
  `description` varchar(128) DEFAULT NULL COMMENT '描述和备注',
  `create_time` datetime DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `create_id` bigint DEFAULT NULL COMMENT '创建人ID',
  `modify_time` datetime DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '修改时间',
  `modify_id` bigint DEFAULT NULL COMMENT '修改人ID',
  PRIMARY KEY (`id`),
  KEY `idx_enterprise_id` (`enterprise_id`),
  KEY `idx_type` (`type`),
  KEY `idx_name` (`name`),
  KEY `idx_sort_id` (`sort_id`),
  KEY `idx_status` (`status`),
  KEY `idx_is_default` (`is_default`),
  CONSTRAINT `fk_type_enterprise` FOREIGN KEY (`enterprise_id`) REFERENCES `o_enterprise` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='加工类型基础数据管理表';

-- 物料档案管理表（企业内部标准物料档案，不包含供应商信息）
CREATE TABLE `p_basic_fabric` (
  `id` bigint NOT NULL COMMENT '主键ID',
  `enterprise_id` bigint NOT NULL COMMENT '所属企业ID，关联o_enterprise主键',
  `type` int NOT NULL COMMENT '物料类型：1-面料，2-辅料/包材，3-二次工艺，4-加工费类',
  `image_url` varchar(128) DEFAULT NULL COMMENT '物料图片信息',
  `name` varchar(64) NOT NULL COMMENT '物料名称',
  `unit` int DEFAULT NULL COMMENT '用量单位，字典定义：1-个，2-克，3-米，4-码，5-千克，6-条等',
  `width` varchar(12) DEFAULT NULL COMMENT '幅宽（布封/用料）',
  `weight` varchar(12) DEFAULT NULL COMMENT '克重',
  `gap` varchar(12) DEFAULT NULL COMMENT '空差：上档差、下档差',
  `element` varchar(24) DEFAULT NULL COMMENT '成分',
  `color` json DEFAULT NULL COMMENT '颜色，多个值，字典定义',
  `size` json DEFAULT NULL COMMENT '规格，多个值，字典定义',
  `price` decimal(10,2) DEFAULT NULL COMMENT '参考单价（实际价格以供应商为准）',
  `create_time` datetime DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `create_id` bigint DEFAULT NULL COMMENT '创建人ID',
  `modify_time` datetime DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '修改时间',
  `modify_id` bigint DEFAULT NULL COMMENT '修改人ID',
  PRIMARY KEY (`id`),
  KEY `idx_enterprise_id` (`enterprise_id`),
  KEY `idx_type` (`type`),
  KEY `idx_name` (`name`),
  KEY `idx_unit` (`unit`),
  CONSTRAINT `fk_fabric_enterprise` FOREIGN KEY (`enterprise_id`) REFERENCES `o_enterprise` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='物料档案管理表（企业内部标准物料档案，不包含供应商信息）';

-- 款式资料管理表
CREATE TABLE `p_basic_style` (
  `id` bigint NOT NULL COMMENT '主键ID',
  `enterprise_id` bigint NOT NULL COMMENT '所属企业的主键ID，关联o_enterprise主键',
  `img_url` varchar(256) DEFAULT NULL COMMENT '款式缩略图',
  `section_number` varchar(36) NOT NULL COMMENT '款号',
  `section_name` varchar(36) DEFAULT NULL COMMENT '款名',
  `unit` int DEFAULT NULL COMMENT '单位，字典取值',
  `designer_id` bigint DEFAULT NULL COMMENT '设计师ID',
  `design_no` varchar(36) DEFAULT NULL COMMENT '设计号',
  `description` varchar(256) DEFAULT NULL COMMENT '备注信息',
  `color` json DEFAULT NULL COMMENT '款式颜色',
  `size` json DEFAULT NULL COMMENT '款式尺码',
  `color_img` json DEFAULT NULL COMMENT '颜色图片',
  `create_time` datetime DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间、操作时间',
  `create_id` bigint(20) DEFAULT NULL COMMENT '创建人ID',
  `modify_time` datetime DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '修改时间',
  `modify_id` bigint(20) DEFAULT NULL COMMENT '修改人ID',
  PRIMARY KEY (`id`),
  KEY `idx_enterprise_id` (`enterprise_id`),
  KEY `idx_section_number` (`section_number`),
  KEY `idx_designer_id` (`designer_id`),
  KEY `idx_design_no` (`design_no`),
  CONSTRAINT `fk_style_enterprise` FOREIGN KEY (`enterprise_id`) REFERENCES `o_enterprise` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='款式资料管理表：维护平台客户的款式信息，可以重复使用';

-- 款式工序详细信息表
CREATE TABLE `p_basic_process_detail` (
  `id` bigint NOT NULL COMMENT '主键ID',
  `type` int NOT NULL COMMENT '类型：1-款式工序，2-工序模板',
  `basic_id` bigint NOT NULL COMMENT '关联ID：款式的主键ID（p_basic_style）或者工序管理的主键（p_basic_process）',
  `sort_id` int DEFAULT NULL COMMENT '序号',
  `process_name` varchar(36) NOT NULL COMMENT '工序名称',
  `step` bigint(20) DEFAULT NULL COMMENT '环节：加工类型，1-裁剪，2-车缝，3-包装，4-印花，5-绣花，6-洗水，7-钉珠，8-刺绣',
  `work_time` int DEFAULT NULL COMMENT '工时(秒)',
  `price` decimal(10,2) DEFAULT NULL COMMENT '单价',
  `price_temp` decimal(10,2) DEFAULT NULL COMMENT '临时工价',
  `is_price_open` tinyint(1) DEFAULT '0' COMMENT '开放单价：0-否，1-是',
  `is_count` tinyint(1) DEFAULT '0' COMMENT '是否计数：0-否，1-是',
  `is_key_process` tinyint(1) DEFAULT '0' COMMENT '关键工序：0-否，1-是',
  `is_specification` tinyint(1) DEFAULT '0' COMMENT '指定规格（明显）：0-否，1-是',
  `is_designate` tinyint(1) DEFAULT '0' COMMENT '工序指派（明显）：0-否，1-是',
  `description` varchar(256) DEFAULT NULL COMMENT '工序要求',
  `create_time` datetime DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间、操作时间',
  `create_id` bigint(20) DEFAULT NULL COMMENT '创建人ID',
  `modify_time` datetime DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '修改时间',
  `modify_id` bigint(20) DEFAULT NULL COMMENT '修改人ID',
  PRIMARY KEY (`id`),
  KEY `idx_type` (`type`),
  KEY `idx_basic_id` (`basic_id`),
  KEY `idx_sort_id` (`sort_id`),
  KEY `idx_step` (`step`),
  KEY `idx_process_name` (`process_name`),
  KEY `idx_type_basic` (`type`, `basic_id`),
  CONSTRAINT `fk_process_detail_style` FOREIGN KEY (`basic_id`) REFERENCES `p_basic_style` (`id`) ON DELETE CASCADE,
  CONSTRAINT `fk_process_detail_process` FOREIGN KEY (`basic_id`) REFERENCES `p_basic_process` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='款式工序详细信息表：维护款式工序的详细信息';

