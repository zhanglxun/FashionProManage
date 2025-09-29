表名：o_enterprise_supplier




用途：平台供应商的扩展信息表




原始表：f_supplier



字段
类型
原始字段
索引/键
备注
id
Long

PK
主键ID
enterprise_id
bigint

o_enterprise的主键ID
主表企业的主键的ID
supplier_type
int


字典定义
供应商类型：
1-面料供应商 
2-辅料供应商 
3-消耗品供应商 
4-服务供应商 
5-综合供应商
production_capacity
Varchar 64


产能描述
min_order_quantity
int


最小订单数量
lead_time_days
int


标准交期(天)
quality_rating
decimal(3,2)


质量评分(0-5)
delivery_rating
decimal(3,2)


交期评分(0-5)
service_rating
decimal(3,2)


服务评分(0-5)
level
tinyint


按金额等级：
1-A -采购金额 >30
2-B-11<采购金额<29
3-C-5<采购金额 <10
4-D-采购金额 <4
cooperation_level
tinyint 



合作等级：
1-战略合作 
2-重要合作 
3-一般合作 
4-临时合作
payment_method
tinyint


付款方式
1-现金支付
2-月结支付
payment_terms
varchar(200)


付款条件
cooperation_start_date
datetime


合作开始日期
create_time
datetime


创建时间、操作时间
create_id
Bigint 20


创建人id
modify_time
datetime


修改时间
modify_id
Bigint 20


修改人id