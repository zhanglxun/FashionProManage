
# 项目名称
- 英文项目名：FashionProManage
- 中文项目名：服饰生产管理系统

# 产品规划与需求设计工程

## 1. 项目目的
本工程用于托管产品规划与需求设计的所有产物 —— 包括竞品资料、用户画像、流程图、业务规则、以及 AI 生成的数据库结构 SQL 脚本等。  
**AI 是协作者**：在 Cursor 中运行 prompt，AI 会把产出写回本工程对应目录，形成可持续迭代的知识库与规范集。  
本项目 **不直接输出生产代码**（代码将在独立工程中实现）；本工程的输出将为编码提供详尽的需求、数据设计与业务规则。


## 2. 项目的目录结构
把下面结构作为初始模板放入工程根目录：

```
/FashionProManage/
├─ README.md
├─ /00_meta/
│ ├─ project_info.md    #项目背景、目标、范围
│ ├─ changelog.md       #迭代日志（Append-only）
│ ├─ cursor_config.md   #Cursor AI persona / system-prompt 配置
├─ /01_research/
│ ├─ competitors.md
│ ├─ market_research.md
│ ├─ user_interviews/   #原始访谈记录（文本或音频链接）
│ │ ├─ interview_YYYYMMDD.md
├─ /02_personas/
│ ├─ personas.md
│ ├─ persona_<id>.json
├─ /03_journeys_and_flows/
│ ├─ user_journeys.md
│ ├─ flow_<name>.svg
├─ /04_requirements/
│ ├─ req_index.md       # 列表 + 状态
│ ├─ req_<short-title>_vX__YYYYMMDD.md      #每个需求单独文档
├─ /05_data_model/
│ ├─ data_dictionary.md
│ ├─ erd/               # 图与导出
│ ├─ sql/               # SQL 数据库脚本
│ │ ├─ schema_v1__YYYYMMDD.sql
│ │ ├─ migrations/
├─ /06_business_rules/
│ ├─ rules.md           # 业务规则文档
│ ├─ rule<id>.md        # 每个规则单独文档
├─ /07_templates/       # 模板
│ ├─ prompt_templates.md    
│ ├─ requirement_template.md #需求模板
│ ├─ persona_template.md
├─ /08_outputs/
│ ├─ meeting_notes/
│ ├─ decisions/
│ ├─ prototypes_links.md
├─ /09_tests_acceptance/
│ ├─ acceptance_criteria.md
│ ├─ test_cases/
├─ /10_archive/
│ ├─ old_versions/
```


## 3. 高层规则与原则
1. **所有“可落地”输出必须写入对应目录**，并包含 metadata（版本、作者、创建/更新时间）。  
2. 默认文档格式：**Markdown + YAML front-matter**（便于索引与机器解析）。  
3. 每次 AI 生成关键产出时，文件命名需带版本号并更新 `/00_meta/changelog.md`（追加式记录）。  
4. 输出序列化优先：优先提供可解析的 JSON / YAML / Markdown；SQL 放在 `/05_data_model/sql/`。  
5. 变更、讨论、决策保存在 `/08_outputs/decisions/`，并在 changelog 中摘要记录。  
6. 敏感数据（PII）不得上传到公开工程；使用示例或匿名化数据。

---

## 4. 命名与版本规则
- 文档：`<type>_<short-title>__v<major>__YYYYMMDD.md`  
  例：`req_payment_checkout__v1__20250812.md`
- SQL：`schema_v<major>__YYYYMMDD.sql`
- Persona：`persona_<name>__v1__YYYYMMDD.json`
- Changelog：追加记录 ISO 日期、作者、文件、摘要、版本（示例见 `/00_meta/changelog.md`）

语义化版本策略：重大不兼容改动增加 major；小修补增加 patch（例如 v1.0.1）。

---

## 5. 文件 front-matter 约定（YAML 模板）
所有关键文档顶部建议包含 YAML front-matter，便于索引与自动化处理。
```yaml
---
title: "短标题"
id: "req-001"            # 唯一 id
version: "v1"
status: "draft|review|final|deprecated"
author: "你的名字 or AI"
created_at: "2025-08-12T10:00:00+08:00"
updated_at: "2025-08-12T10:00:00+08:00"
references: ["../01_research/competitors.md"]
tags: ["需求","支付","核心流程"]
---


```
