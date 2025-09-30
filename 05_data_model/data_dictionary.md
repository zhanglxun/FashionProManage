
# 数据结构的目录文档

# 0. 数据模型设计

# 1.系统授权（System）

## 1.1 账号管理

### 1.1.1.用户账号管理（s_users）

| 字段名 | 类型 | 备注说明 |
| ------ | ---- | -------- |
| id | bigint | 系统用户唯一ID |
| account | varchar(50) | 用户系统账号 |
| pwd | varchar(200) | 系统密码 |
| surname | varchar(24) | 姓氏 |
| chinese_name | varchar(50) | 中文名称 |
| nickname | varchar(50) | 用户昵称 |
| email | varchar(50) | 用户邮箱 |
| mobile | varchar(20) | 手机号码 |
| last_date | datetime | 最后登录时间 |
| sex | varchar(2) | 性别1：男2：女 |
| birthday | datetime | 出生年月 |
| nationality | varchar(50) | 国籍 |
| province | varchar(100) | 省份(籍贯) |
| cities | varchar(50) | 城市(籍贯) |
| address | varchar(255) | 户籍地址 |
| address_province | varchar(36) | 现在住址(省) |
| address_city | varchar(45) | 现住址(市) |
| address_area | varchar(45) | 现住址(区) |
| address_street | varchar(45) | 现住址(街道) |
| id_type | int | 证件类型 |
| id_number | varchar(36) | 证件号 |
| car_no | varchar(30) | 车牌号 |
| education | varchar(36) | 学历 |
| age | int | 年龄 |
| household_province | varchar(24) | 户籍所在地省 |
| household_city | varchar(24) | 户籍所在地城市 |
| ethnic | varchar(24) | 民族 |
| blood | varchar(24) | 血型 |
| career | varchar(24) | 职业 |
| register_time | datetime | 注册时间 |
| status | int | 激活状态 激活为1，注销为2 |
| login_type | varchar(255) | 登陆类型 |
| grade_name | smallint | 会员等级 取字典 |
| skin | varchar(20) | 用户皮肤 |
| layout | int | 布局设置1：左侧菜单2：顶部菜单 |
| auto_menu | bit(1) | 是否自动分割菜单 |
| one_level_menu | bit(1) | 一级菜单是否隐藏 |
| modify_time | datetime | 修改时间 |
| modify_id | bigint | 修改人 |
| role_id | bigint | 角色ID |
| hospital_role_id | bigint | 医院角色ID【子系统】 |
| image_url | varchar(300) | 头像路径 |
| identity_cards_image | varchar(300) | 身份证照片 |
| user_type | int | 用户类型:1：医生类用户3：代理商/运营商4：普通用户 |
| register_code | varchar(36) | 注册码 |
| qq_number | varchar(30) | qq账号 |
| wechat | varchar(30) | 微信号 |
| weibo | varchar(200) | 微博地址 |
| open_id_qq | varchar(36) | qq注册生成id |
| miniapp_openid | varchar(50) | 小程序院openId |
| open_id_weibo | varchar(36) | 微博注册生成ID |
| open_id_wechat | varchar(36) | 微信的openID |
| open_push | bit(1) | 是否开启极光推送 |
| register_type | int | 注册渠道，字典定义 |
| enterprise_user_id | varchar(100) | 企微成员用户ID |
| union_id | varchar(500) | unionid |


## 1.2 权限管理

### 1.2.1.角色管理（s_roles）

| 字段名 | 类型 | 备注说明 |
| ------ | ---- | -------- |
| id | bigint | 角色id |
| name | varchar(64) | 角色名称 |
| type | int | 角色类别:字典配置 |
| login_client | varchar(255) | 登录的客户端 |
| enterprise_id | bigint | 企业ID（注意：字段名有拼写错误） |
| enterprise_admin | tinyint(1) | 1 -企业管理员 |
| description | varchar(128) | 角色描述 |
| create_time | datetime | 创建时间 |
| create_id | bigint | 创建人ID |
| modify_time | datetime | 修改时间 |
| modify_id | bigint | 修改人ID |

### 1.2.2.资源管理（s_resource）

| 字段名 | 类型 | 备注说明 |
| ------ | ---- | -------- |
| id | bigint | 主键ID |
| menu_id | bigint | 菜单s_menu主键ID |
| name | varchar(32) | 名称 |
| code | varchar(100) | 资源编码 |
| platform_flag | tinyint(1) | 1 平台资源 2非平台资源 |
| description | varchar(255) | 资源的描述 |
| resource_url | varchar(255) | 资源URL路由 |
| create_id | bigint | 创建人 |
| create_time | datetime | 创建时间 |
| modify_id | bigint | 修改人 |
| modify_time | datetime | 修改时间 |

### 1.2.3.菜单管理（s_menu）

| 字段名 | 类型 | 备注说明 |
| ------ | ---- | -------- |
| id | bigint | 菜单的主键ID |
| sort_id | int | 排序ID |
| parent_id | bigint | 父级ID |
| name | varchar(64) | 菜单名称 |
| hospital_alias_name | varchar(64) | 医院菜单别名【子系统】 |
| url | varchar(255) | 菜单URL |
| icon_class | varchar(100) | 菜单Class属性对应菜单的图标样式 |
| description | varchar(64) | 备注 |
| create_id | bigint | 创建人 |
| create_time | datetime | 创建时间 |
| modify_id | bigint | 修改人 |
| modify_time | datetime | 修改时间 |

### 1.2.4.权限管理

#### 用户角色关系表（s_user_role）

| 字段名 | 类型 | 备注说明 |
| ------ | ---- | -------- |
| id | bigint | 主键ID |
| user_id | bigint | 用户ID |
| role_id | bigint | 角色ID |
| is_enterprise | tinyint(1) | 1:企业角色，2:平台角色 |
| create_id | bigint | 创建人 |
| create_time | datetime | 创建时间 |
| modify_id | bigint | 修改人 |
| modify_time | datetime | 修改时间 |

#### 角色资源表（s_page_role）

| 字段名 | 类型 | 备注说明 |
| ------ | ---- | -------- |
| id | bigint | 主键id |
| menu_Id | bigint | 菜单id |
| role_Id | bigint | 角色id |
| resource_id | bigint | 资源主键id |
| create_time | datetime | 创建时间 |
| create_id | bigint | 创建人ID |
| modify_time | datetime | 修改时间 |
| modify_id | bigint | 修改人ID |

#### 角色菜单表（s_role_menu）

| 字段名 | 类型 | 备注说明 |
| ------ | ---- | -------- |
| id | bigint | 主键ID |
| role_id | bigint | 角色ID |
| menu_id | bigint | 菜单ID |
| create_id | bigint | 创建人 |
| create_time | datetime | 创建时间 |

## 1.3.字典设置

### 1.3.1.字典设置（s_dictionary）

| 字段名 | 类型 | 备注说明 |
| ------ | ---- | -------- |
| id | bigint | 自增id |
| sort_id | int | 排序id |
| parent_id | bigint | 父级id |
| name | varchar(120) | 名称 |
| value | varchar(500) | 属性值 |
| description | varchar(2000) | 备注 |
| status | int | 状态 1:启用2：禁用 |
| create_id | bigint | 创建人 |
| create_time | datetime | 创建时间 |
| modify_id | bigint | 修改人 |
| modify_time | datetime | 修改时间 |
| english | json | 海外多语言字典配置 |
| type | int | 字典类型 |



## 1.4.日志管理


### 1.4.1.用户登录日志（s_user_login_log）

| 字段名 | 类型 | 备注说明 |
| ------ | ---- | -------- |
| id | bigint | 主键ID |
| login_time | datetime | 登录时间 |
| account | varchar(255) | 账号 |
| user_id | bigint | 用户ID |
| user_name | varchar(255) | 用户名 |
| mobile | varchar(20) | 手机号 |
| grant_type | varchar(255) | 授权类型 |
| operation | varchar(400) | 操作 |
| failed_message | varchar(300) | 失败信息 |
| success_flag | tinyint(1) | 成功标识 |
| cluster_success | tinyint(1) | 集群成功标识 |
| platform | varchar(255) | 平台 |
| ip_address | varchar(50) | IP地址 |
| destination | varchar(255) | 归属地 |
| device_name | varchar(255) | 设备名称 |
| resolution | varchar(50) | 分辨率 |
| app_version | varchar(50) | app 版本号 |
| sys_name | varchar(255) | 操作系统名称 |
| sys_version | varchar(50) | 操作系统版本 |
| device_id | varchar(255) | 设备ID |
| manufacturer_name | varchar(255) | 制造商名称 |
| mac | varchar(50) | mac地址 |



### 1.4.2.短信验证码日志（s_mobile_verification_log）

| 字段名 | 类型 | 备注说明 |
| ------ | ---- | -------- |
| id | bigint | 主键ID |
| mobile | varchar(20) | 手机号码 |
| email | varchar(100) | 邮箱 |
| ip_address | varchar(100) | ip地址 |
| destination | varchar(100) | 归属地 |
| verification | int | 验证码 |
| send_time | datetime | 发送时间 |
| client_id | varchar(100) | 发送的客户端 |
| type | tinyint | 类型，1 注册 2 忘记密码 3修改邮箱 4修改手机号码 5 登录 |
| status | tinyint(1) | 是否有效 |
| create_time | datetime | 创建时间 |
| modify_time | datetime | 更新时间 |



### 1.4.3.OAuth2授权表（oauth2_authorization）

| 字段名 | 类型 | 备注说明 |
| ------ | ---- | -------- |
| id | varchar(100) | 授权ID |
| registered_client_id | varchar(100) | 注册客户端ID |
| principal_name | varchar(200) | 主体名称 |
| authorization_grant_type | varchar(100) | 授权类型 |
| authorized_scopes | varchar(1000) | 授权范围 |
| attributes | blob | 属性 |
| state | varchar(500) | 状态 |
| authorization_code_value | blob | 授权码值 |
| authorization_code_issued_at | datetime | 授权码签发时间 |
| authorization_code_expires_at | datetime | 授权码过期时间 |
| authorization_code_metadata | blob | 授权码元数据 |
| access_token_value | blob | 访问令牌值 |
| access_token_issued_at | datetime | 访问令牌签发时间 |
| access_token_expires_at | datetime | 访问令牌过期时间 |
| access_token_metadata | blob | 访问令牌元数据 |
| access_token_type | varchar(100) | 访问令牌类型 |
| access_token_scopes | varchar(1000) | 访问令牌范围 |
| oidc_id_token_value | blob | OIDC ID令牌值 |
| oidc_id_token_issued_at | datetime | OIDC ID令牌签发时间 |
| oidc_id_token_expires_at | datetime | OIDC ID令牌过期时间 |
| oidc_id_token_metadata | blob | OIDC ID令牌元数据 |
| refresh_token_value | blob | 刷新令牌值 |
| refresh_token_issued_at | datetime | 刷新令牌签发时间 |
| refresh_token_expires_at | datetime | 刷新令牌过期时间 |
| refresh_token_metadata | blob | 刷新令牌元数据 |
| user_code_value | blob | 用户码值 |
| user_code_issued_at | datetime | 用户码签发时间 |
| user_code_expires_at | datetime | 用户码过期时间 |
| user_code_metadata | blob | 用户码元数据 |
| device_code_value | blob | 设备码值 |
| device_code_issued_at | datetime | 设备码签发时间 |
| device_code_expires_at | datetime | 设备码过期时间 |
| device_code_metadata | blob | 设备码元数据 |

#### OAuth2注册客户端表（oauth2_registered_client）

| 字段名 | 类型 | 备注说明 |
| ------ | ---- | -------- |
| id | varchar(100) | 客户端ID |
| client_id | varchar(100) | 客户端标识 |
| client_id_issued_at | timestamp | 客户端ID签发时间 |
| client_secret | varchar(200) | 客户端密钥 |
| client_secret_expires_at | timestamp | 客户端密钥过期时间 |
| client_name | varchar(200) | 客户端名称 |
| client_authentication_methods | varchar(1000) | 客户端认证方法 |
| authorization_grant_types | varchar(1000) | 授权类型 |
| redirect_uris | varchar(1000) | 重定向URI |
| post_logout_redirect_uris | varchar(1000) | 登出后重定向URI |
| scopes | varchar(1000) | 作用域 |
| client_settings | varchar(2000) | 客户端设置 |
| token_settings | varchar(2000) | 令牌设置 |



### 1.4.4.全局操作日志

> 全局操作日志暂未定义，可在实际业务中补充



## 1.5.客户端管理

### 1.5.1.客户端管理

> 客户端管理功能已集成到OAuth2注册客户端表中


# 2.组织关系管理（orgenaization）

## 2.1 企业信息管理

### 2.1.1.企业信息表（o_enterprise）

| 字段名 | 类型 | 备注说明 |
| ------ | ---- | -------- |
| id | bigint | 主键ID |
| sort_id | int | 排序ID |
| area_id | bigint | 地域ID，关联O_area表主键 |
| agent_id | bigint | 所属代理商ID |
| code | int | 企业编码，系统生成 |
| img_url | varchar(255) | 企业机构背景图片 |
| img_logo | varchar(255) | 企业机构logo图片 |
| name | varchar(64) | 企业名称 |
| short_name | varchar(32) | 企业简称 |
| domain_name | varchar(128) | 企业域名、官网地址 |
| type | int | 企业客户类别：1-平台客户，2-代理商/经销商，3-供应商，4-代工厂 |
| source | int | 客户渠道来源：1-自然注册，2-客户转介绍，3-客户录入 |
| scale | varchar(24) | 人员规模，字典配置 |
| legal_person | varchar(50) | 企业法人 |
| contact_person | varchar(24) | 联系人姓名 |
| contact_email | varchar(32) | 联系人邮箱 |
| contact_mobile | varchar(16) | 联系人电话 |
| landline_phone | varchar(16) | 座机电话 |
| address_province | varchar(16) | 省份 |
| address_city | varchar(16) | 市 |
| address_area | varchar(16) | 区 |
| address_detail | varchar(128) | 详细地址 |
| status | int | 状态：1-启用，0-禁用 |
| verification_status | int | 认证状态：0-未认证，1-已认证，2-认证失败 |
| description | varchar(128) | 描述和备注 |
| create_time | datetime | 创建时间 |
| create_id | bigint | 创建人ID |
| modify_time | datetime | 修改时间 |
| modify_id | bigint | 修改人ID |

### 2.1.2.企业代理商扩展信息表（o_enterprise_agent）

| 字段名 | 类型 | 备注说明 |
| ------ | ---- | -------- |
| id | bigint | 主键ID |
| sort_id | int | 排序ID |
| parent_id | bigint | 父级ID，关联o_enterprise_agent主键 |
| enterprise_id | bigint | 企业ID，关联o_enterprise主键 |
| agent_type | int | 代理商类型：1-区域代理，2-产品代理，3-渠道代理 |
| agent_area | varchar(200) | 代理区域，支持多选 |
| commission_rate | decimal(5,2) | 佣金比例(%) |
| sales_target | varchar(100) | 年度销售目标 |
| cooperation_start_date | datetime | 合作开始日期 |
| cooperation_end_date | datetime | 合作结束日期 |
| description | varchar(256) | 描述备注 |
| create_time | datetime | 创建时间 |
| create_id | bigint | 创建人ID |
| modify_time | datetime | 修改时间 |
| modify_id | bigint | 修改人ID |

### 2.1.3.企业供应商扩展信息表（o_enterprise_supplier）

| 字段名 | 类型 | 备注说明 |
| ------ | ---- | -------- |
| id | bigint | 主键ID |
| enterprise_id | bigint | 企业ID，关联o_enterprise主键 |
| supplier_type | int | 供应商类型：1-面料供应商，2-辅料供应商，3-消耗品供应商，4-服务供应商，5-综合供应商 |
| production_capacity | varchar(64) | 产能描述 |
| min_order_quantity | int | 最小订单数量 |
| lead_time_days | int | 标准交期(天) |
| quality_rating | decimal(3,2) | 质量评分(0-5) |
| delivery_rating | decimal(3,2) | 交期评分(0-5) |
| service_rating | decimal(3,2) | 服务评分(0-5) |
| level | tinyint | 按金额等级：1-A(>30万)，2-B(11-29万)，3-C(5-10万)，4-D(<4万) |
| cooperation_level | tinyint | 合作等级：1-战略合作，2-重要合作，3-一般合作，4-临时合作 |
| payment_method | tinyint | 付款方式：1-现金支付，2-月结支付 |
| payment_terms | varchar(200) | 付款条件 |
| cooperation_start_date | datetime | 合作开始日期 |
| create_time | datetime | 创建时间 |
| create_id | bigint | 创建人ID |
| modify_time | datetime | 修改时间 |
| modify_id | bigint | 修改人ID |

### 2.1.4.平台工厂扩展信息表（o_enterprise_factory）

| 字段名 | 类型 | 备注说明 |
| ------ | ---- | -------- |
| id | bigint | 主键ID |
| enterprise_id | bigint | 企业ID，关联o_enterprise主键 |
| fatory_type | varchar(64) | 专长工艺，字典配置，支持多选：1-加工,2-印花,3-绣花,4-打揽 |
| production_capacity | varchar(64) | 产能描述 |
| min_order_quantity | int | 最小订单数量 |
| lead_time_days | int | 标准交期(天) |
| quality_rating | decimal(3,2) | 质量评分(0-5) |
| delivery_rating | decimal(3,2) | 交期评分(0-5) |
| service_rating | decimal(3,2) | 服务评分(0-5) |
| level | int | 按金额等级，字典配置：1-A(>30万),2-B(11-29万),3-C(5-10万),4-D(<4万) |
| cooperation_level | int | 合作等级：1-战略合作,2-重要合作,3-一般合作,4-临时合作 |
| payment_method | int | 付款方式: 1-现金支付,2-月结支付 |
| payment_terms | varchar(200) | 付款条件 |
| cooperation_start_date | datetime | 合作开始日期 |
| create_time | datetime | 创建时间 |
| create_id | bigint | 创建人ID |
| modify_time | datetime | 修改时间 |
| modify_id | bigint | 修改人ID |

## 2.2 地域管理

### 2.2.1.地域信息表（o_area）

| 字段名 | 类型 | 备注说明 |
| ------ | ---- | -------- |
| id | bigint | 主键ID |
| sort_id | int | 排序ID |
| parent_id | bigint | 父级ID |
| name | varchar(11) | 区域名称 |
| code | int | 区域识别码 |
| status | tinyint | 状态：1-启用，0-禁用 |
| create_time | datetime | 创建时间 |
| create_id | bigint | 创建人ID |
| modify_time | datetime | 修改时间 |
| modify_id | bigint | 修改人ID |

## 2.3 机构关系管理

### 2.3.1.机构关系表（o_enterprise_relation）

| 字段名 | 类型 | 备注说明 |
| ------ | ---- | -------- |
| id | bigint | 主键ID |
| agent_id | bigint | 代理商ID，关联o_enterprise主键，类型为代理商 |
| enterprise_id | bigint | 企业ID，关联o_enterprise主键，类型为企业 |
| type | int | 管理映射：1-企业客户，2-代理商，3-供应商，4-工厂 |
| business_type | int | 业务类型：1-智能织机（服饰生产管理系统），2-其他业务 |
| description | varchar(256) | 描述和备注信息 |
| create_time | datetime | 创建时间 |
| create_id | bigint | 创建人ID |
| modify_time | datetime | 修改时间 |
| modify_id | bigint | 修改人ID |

## 2.4 企业内部管理

### 2.4.1.企业部门信息表（o_department）

| 字段名 | 类型 | 备注说明 |
| ------ | ---- | -------- |
| id | bigint | 主键ID |
| parent_id | bigint | 父级主键ID，父级根节点设置为0 |
| enterprise_id | bigint | 企业ID，关联o_enterprise主键 |
| name | varchar(36) | 部门名称 |
| description | varchar(36) | 描述备注信息 |
| status | int | 状态：1-启用，0-禁用 |
| create_time | datetime | 创建时间 |
| create_id | bigint | 创建人ID |
| modify_time | datetime | 修改时间 |
| modify_id | bigint | 修改人ID |

### 2.4.2.企业员工信息表（o_staff）

| 字段名 | 类型 | 备注说明 |
| ------ | ---- | -------- |
| id | bigint | 主键ID |
| enterprise_id | bigint | 企业ID，关联o_enterprise主键 |
| department_id | bigint | 部门ID，关联o_department主键 |
| user_id | bigint | 用户ID，关联s_users主键 |
| job_name | varchar(36) | 岗位名称 |
| description | varchar(128) | 备注信息 |
| create_time | datetime | 创建时间 |
| create_id | bigint | 创建人ID |
| modify_time | datetime | 修改时间 |
| modify_id | bigint | 修改人ID |

## 2.5 企业配置管理

### 2.5.1.企业参数定义表（o_setting）

| 字段名 | 类型 | 备注说明 |
| ------ | ---- | -------- |
| id | bigint | 主键ID |
| sort_id | int | 排序ID |
| parent_id | bigint | 父级主键ID |
| code | varchar(36) | 参数项识别码 |
| name | varchar(64) | 配置项名称 |
| type | int | 值的类型：1-范围类型，2-开关类型，3-下拉类型，4-下拉多选 |
| value_unit | varchar(100) | 单位 |
| value_list | varchar(128) | 数据的数组 |
| status | int | 状态：1-启用，0-禁用 |
| description | varchar(128) | 描述备注信息 |
| create_time | datetime | 创建时间 |
| create_id | bigint | 创建人ID |
| modify_time | datetime | 修改时间 |
| modify_id | bigint | 修改人ID |

### 2.5.2.企业偏好设置表（o_config）

| 字段名 | 类型 | 备注说明 |
| ------ | ---- | -------- |
| id | bigint | 主键ID |
| enterprise_id | bigint | 企业ID，关联o_enterprise主键 |
| setting_id | bigint | 配置项ID，关联o_setting主键 |
| status | int | 是否有效：1-开启，0-关闭 |
| min_value | decimal(10,3) | 最小值 |
| max_value | decimal(10,3) | 最大值 |
| option_value | varchar(128) | 下拉数值 |
| value_unit | varchar(100) | 单位 |
| value_list | varchar(128) | 数据的数组 |
| create_time | datetime | 创建时间 |
| create_id | bigint | 创建人ID |
| modify_time | datetime | 修改时间 |
| modify_id | bigint | 修改人ID |

## 2.6 客户管理

### 2.6.1.平台企业的客户信息表（o_customer）

| 字段名 | 类型 | 备注说明 |
| ------ | ---- | -------- |
| id | bigint | 主键ID |
| enterprise_id | bigint | 企业ID，关联o_enterprise主键 |
| number | bigint | 客户编号，自动编号 |
| name | varchar(36) | 客户名称 |
| short_name | varchar(36) | 客户简称 |
| country | varchar(36) | 所在国家 |
| type | int | 客户类别：1-外贸客户，2-国内客户 |
| collection_type | int | 客户收款方式，字典配置 |
| level | int | 按金额等级：1-A(>30万)，2-B(11-29万)，3-C(5-10万)，4-D(<4万) |
| value_scale | int | 产值规模，数据字典定义 |
| sales_id | bigint | 销售人员ID |
| follower_id | bigint | 跟单人员ID |
| address | varchar(255) | 客户地址 |
| status | int | 状态：0-禁用，1-启用 |
| description | varchar(128) | 描述和备注 |
| create_time | datetime | 创建时间 |
| create_id | bigint | 创建人ID |
| modify_time | datetime | 修改时间 |
| modify_id | bigint | 修改人ID |

### 2.6.2.客户联系人信息表（o_contact）

| 字段名 | 类型 | 备注说明 |
| ------ | ---- | -------- |
| id | bigint | 主键ID |
| customer_id | bigint | 客户ID，关联o_customer主键 |
| name | varchar(32) | 联系人姓名 |
| contact_type | tinyint | 联系方式：1-电话，2-邮件，3-社媒账号(whatsapp)，4-telegram |
| contact_information | varchar(36) | 联系方式信息 |
| create_time | datetime | 创建时间 |
| create_id | bigint | 创建人ID |
| modify_time | datetime | 修改时间 |
| modify_id | bigint | 修改人ID |

## 2.7 供应商产品管理

### 2.7.1.平台供应商/工厂的产品、服务表（o_supplier_product）

| 字段名 | 类型 | 备注说明 |
| ------ | ---- | -------- |
| id | bigint | 主键ID |
| supplier_id | bigint | 供应商ID，关联o_enterprise主键 |
| basic_fabric_id | bigint | 物料档案的ID，关联p_basic_fabric主键 |
| product_name | varchar(255) | 品名 |
| fabric_type_name | varchar(50) | 布种类别 |
| maaterials | varchar(100) | 布封/用料 |
| unit | varchar(10) | 单位（取字典） |
| unit_price | decimal(10,2) | 供应商单价 |
| amount | decimal(10,2) | 用量 |
| description | varchar(255) | 备注描述 |
| create_time | datetime | 创建时间 |
| create_id | bigint | 创建人ID |
| modify_time | datetime | 修改时间 |
| modify_id | bigint | 修改人ID |





# 3.生产管理（production）



## 3.1 样板管理



## 3.2 大货管理



# 4.进销存管理（inventory）



# 5.结算核算（financial）

> 财务管理模块



# 6.对外协作（external collaboration）

>  对外协作管理模块



# 7.智能分析（analysis）

