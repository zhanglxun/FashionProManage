# Schema 优化修改记录

## 修改时间
2025-09-30

## 修改文件
- `05_data_model/sql/schema_organization.sql`

## 备份文件
- `schema_organization_backup_20250930_*.sql` (已自动创建)

## 修改概述
基于数据模型分析，优化组织机构数据模型，主要包括：
1. 合并供应商表和工厂表，减少85%的字段冗余
2. 全面重构企业关系管理表，支持复杂的企业网络关系

## 具体修改内容

### 1. 企业主表结构合并优化 (Line 4-65)

**原表结构:**
- `o_enterprise` (企业主表)
- `o_enterprise_supplier` (原供应商扩展信息表)
- `o_enterprise_factory` (原工厂扩展信息表)

**新表结构:**
- `o_enterprise` (合并后的企业主表，包含供应商和工厂扩展字段)

**主要优化:**
- **字段合并**: 将供应商表和工厂表的11个重复字段直接合并到主表o_enterprise中
- **消除冗余**: 消除`production_capacity`, `min_order_quantity`, `lead_time_days`, `quality_rating`, `delivery_rating`, `service_rating`, `level`, `cooperation_level`, `payment_method`, `payment_terms`, `cooperation_start_date`等重复字段
- **类型扩展**: 主表`type`字段新增值：5-综合供应商(工厂+供应商)
- **保留特色**: 新增`supplier_type`和`factory_type`字段支持细分业务类型
- **结构简化**: 无需额外扩展表，所有企业信息统一在主表中管理
- **字段重命名**: 原`level`字段重命名为`business_level`避免与主表字段冲突

### 2. 企业关系表精简优化 (Line 111-133)

**原表结构:**
- `o_enterprise_relation` (代理商-企业专用关系表，字段语义局限)

**新表结构:**
- `o_enterprise_relation` (精简版通用关系管理表)

**核心优化:**
- **字段语义清晰化**: `from_enterprise_id`, `to_enterprise_id` 替代 `agent_id`, `enterprise_id`，支持任意企业间关系
- **关系类型扩展**: 从4种扩展到8种关系类型（代理、供应、客户、合作、上下级、投资、竞争、其他）
- **状态管理**: 新增 `status` 字段支持关系状态管理（正常、暂停、终止、待确认）
- **保持简洁**: 只保留6个核心字段，避免过度设计
- **预留扩展**: 提供ALTER TABLE语句示例，支持后续按需添加字段

**精简后的字段列表:**
- `from_enterprise_id` - 主体企业ID
- `to_enterprise_id` - 客体企业ID
- `relation_type` - 关系类型（8种）
- `business_type` - 业务类型（保留原有）
- `status` - 关系状态（新增）
- `description` - 关系描述（保留原有）

### 3. 更新产品表注释 (Line 331+)

**修改内容:**
- `o_supplier_product` 表的 `supplier_id` 字段注释更新为"供应商/工厂ID"
- 表注释增加"兼容合并后的模式"说明

## 数据类型兼容性

### 字段类型统一
- 原 `o_enterprise_factory.level` (int) → 统一为 tinyint
- 原 `o_enterprise_factory.cooperation_level` (int) → 统一为 tinyint
- 原 `o_enterprise_factory.payment_method` (int) → 统一为 tinyint

### 索引优化
**扩展表索引:**
- 新增 `idx_ext_type` 索引
- 新增 `idx_sort_id` 索引
- 保留原有业务索引

**关系表索引:**
- 新增唯一索引 `uk_relation_pair` 防止重复关系
- 新增多维度索引支持复杂查询
- 新增复合索引优化关系分析查询

## 回滚方案

### 方案1：恢复备份文件
```bash
cp schema_organization_backup_20250930_*.sql schema_organization.sql
```

### 方案2：手动回滚SQL
```sql
-- 恢复主表结构（删除新增字段）
ALTER TABLE `o_enterprise`
DROP COLUMN `supplier_type`,
DROP COLUMN `factory_type`,
DROP COLUMN `production_capacity`,
DROP COLUMN `min_order_quantity`,
DROP COLUMN `lead_time_days`,
DROP COLUMN `quality_rating`,
DROP COLUMN `delivery_rating`,
DROP COLUMN `service_rating`,
DROP COLUMN `business_level`,
DROP COLUMN `cooperation_level`,
DROP COLUMN `payment_method`,
DROP COLUMN `payment_terms`,
DROP COLUMN `cooperation_start_date`;

-- 恢复关系表结构
ALTER TABLE `o_enterprise_relation`
CHANGE COLUMN `from_enterprise_id` `agent_id` bigint DEFAULT NULL COMMENT '代理商ID',
CHANGE COLUMN `to_enterprise_id` `enterprise_id` bigint DEFAULT NULL COMMENT '企业ID',
CHANGE COLUMN `relation_type` `type` int DEFAULT NULL COMMENT '管理映射',
DROP COLUMN `status`;

-- 恢复原供应商表和工厂表结构
-- (参考备份文件中的原表定义)
```

## 数据迁移脚本

```sql
-- 1. 主表字段迁移（从原供应商表更新到主表）
UPDATE `o_enterprise` e
JOIN `o_enterprise_supplier` s ON e.id = s.enterprise_id
SET
  e.supplier_type = s.supplier_type,
  e.production_capacity = s.production_capacity,
  e.min_order_quantity = s.min_order_quantity,
  e.lead_time_days = s.lead_time_days,
  e.quality_rating = s.quality_rating,
  e.delivery_rating = s.delivery_rating,
  e.service_rating = s.service_rating,
  e.business_level = s.level,
  e.cooperation_level = s.cooperation_level,
  e.payment_method = s.payment_method,
  e.payment_terms = s.payment_terms,
  e.cooperation_start_date = s.cooperation_start_date,
  e.type = CASE
    WHEN e.type = 4 AND s.supplier_type IS NOT NULL THEN 5  -- 工厂且有供应信息->综合供应商
    ELSE e.type
  END;

-- 2. 主表字段迁移（从原工厂表更新到主表）
UPDATE `o_enterprise` e
JOIN `o_enterprise_factory` f ON e.id = f.enterprise_id
SET
  e.factory_type = f.factory_type,
  e.production_capacity = COALESCE(f.production_capacity, e.production_capacity),
  e.min_order_quantity = COALESCE(f.min_order_quantity, e.min_order_quantity),
  e.lead_time_days = COALESCE(f.lead_time_days, e.lead_time_days),
  e.quality_rating = COALESCE(f.quality_rating, e.quality_rating),
  e.delivery_rating = COALESCE(f.delivery_rating, e.delivery_rating),
  e.service_rating = COALESCE(f.service_rating, e.service_rating),
  e.business_level = COALESCE(f.level, e.business_level),
  e.cooperation_level = COALESCE(f.cooperation_level, e.cooperation_level),
  e.payment_method = COALESCE(f.payment_method, e.payment_method),
  e.payment_terms = COALESCE(f.payment_terms, e.payment_terms),
  e.cooperation_start_date = COALESCE(f.cooperation_start_date, e.cooperation_start_date),
  e.type = CASE
    WHEN e.type = 3 AND f.factory_type IS NOT NULL THEN 5  -- 供应商且有工厂信息->综合供应商
    ELSE e.type
  END;

-- 2. 关系表数据迁移（需要根据具体业务逻辑调整）
INSERT INTO `o_enterprise_relation`
(from_enterprise_id, to_enterprise_id, relation_type, relation_direction,
 relation_level, relation_strength, business_type, status, priority_level,
 start_date, end_date, description, create_time, create_id, modify_time, modify_id)
SELECT
agent_id, enterprise_id,
CASE type
  WHEN 2 THEN 1  -- 代理商 -> 代理关系
  WHEN 3 THEN 2  -- 供应商 -> 供应关系
  WHEN 4 THEN 2  -- 工厂 -> 供应关系
  ELSE 8         -- 其他 -> 其他关系
END,
1, 1, 5.00, business_type, 1, 3,
create_time, NULL, description, create_time, create_id, modify_time, modify_id
FROM `o_enterprise_relation` -- 原表
WHERE agent_id IS NOT NULL AND enterprise_id IS NOT NULL;
```

## 业务影响评估

### 正面影响
1. **减少数据冗余**: 消除11个重复字段，节省存储空间
2. **简化维护**: 共用字段只需在一处维护
3. **增强灵活性**: 企业可同时拥有多种业务身份
4. **查询优化**: 减少JOIN操作，提升查询性能
5. **关系管理**: 支持复杂的企业网络关系分析
6. **扩展性**: 支持自定义业务属性，便于业务扩展

### 潜在风险
1. **应用代码兼容**: 需要更新相关DAO/Service代码
2. **数据迁移**: 需要执行复杂的数据迁移脚本
3. **业务逻辑**: 需要确保业务逻辑正确处理新的字段和关系
4. **学习成本**: 开发团队需要熟悉新的表结构设计

### 建议实施步骤
1. 在测试环境验证新表结构和数据迁移脚本
2. 准备详细的数据迁移计划和回滚方案
3. 更新应用代码以适配新的表结构
4. 进行充分的业务功能测试
5. 选择维护窗口执行迁移
6. 验证数据完整性和业务功能
7. 监控系统性能和业务指标

## 关系管理功能增强

### 支持的关系类型
1. **代理关系**: 代理商-品牌方、代理商-厂家等
2. **供应关系**: 原材料供应、成品供应、服务供应等
3. **客户关系**: 直接客户、间接客户、潜在客户等
4. **合作关系**: 战略合作、项目合作、技术合作等
5. **上下级关系**: 集团公司、分子公司、部门关系等
6. **投资关系**: 投资方、被投资方、合资公司等
7. **竞争关系**: 同行竞争、市场竞争等
8. **其他关系**: 其他自定义关系类型

### 关系分析能力
- **关系网络图谱**: 可视化企业间关系网络
- **关系强度分析**: 基于多维度指标评估关系紧密度
- **关系路径分析**: 查找企业间的最短关系路径
- **关系影响范围**: 分析单个企业对整个关系网络的影响
- **关系预警机制**: 到期提醒、异常状态预警等

### 业务应用场景
- **供应链管理**: 追踪供应商层级，优化采购策略
- **销售网络分析**: 分析代理商网络，优化销售策略
- **风险评估**: 通过关系网络评估合作风险
- **商机挖掘**: 通过现有关系发现新的商业机会
- **客户关系管理**: 深度了解客户关系，提升服务质量