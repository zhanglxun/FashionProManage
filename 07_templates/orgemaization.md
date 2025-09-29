表名：o_supplier_product




用途：平台供应商\工厂的的产品、服务信息表，能管理到各客户自己的价格，这样选择的时候，价格可自己带过去，基础信息维护




原始表：f_supplier_product




字段
类型
原始字段
索引/键
备注
id
bigint 20

PK
主键ID
supplier_id
bigint 20

o_enterprise的主键ID
供应商的主键的ID
basic_fabric_id
bigint 20

p_basic_fabric的主键
物料档案的ID
product_name
varchar 255


品名
fabric_type_name
varchar 50


布种类别
maaterials
varchar 100


布封/用料
unit
varchar 10


单位（取字典）
unit_price
decimal 10 2


供应商单价
amount
decimal 10 2


用量
description
Varchar 255


备注描述
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