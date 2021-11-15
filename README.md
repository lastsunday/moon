# Moon - A development platform to quickly develop
Project moon(追月计划)致力于提供快速开发的解决方案。

项目包含：

1. 快速开发的脚手架
2. 基于脚手架的参考示例

------
[TOC]

## 项目

1. **[moon](https://github.com/lastsunday/moon)** - 根项目，提供管理其他子项目的关联说明以及编译描述
2. **[moon-service](https://github.com/lastsunday/moon-service)** - 提供restful api服务
3. **[moon-client-admin](https://github.com/lastsunday/moon-client-admin)** - 后台管理前端
4. **[moon-client-app](https://github.com/lastsunday/moon-client-app)** - 前端应用（例如POS前端）
5. **[moon-client-mini-app](https://github.com/lastsunday/moon-client-mini-app)** - 小程序前端（例如微信小程序商城）

## 起步

### 检出其他子项目

1. Window

   ```shell
   ./clone.cmd
   ```

### 开发环境

待续

## TODO

### Service功能

- [x] **核心功能**
  - [x] 用户
    - [x] 登录
    - [x] 登出
  - [x] 用户管理
    - [x] 用户管理
  - [x] 角色管理
    - [x] 角色管理
  - [x] 令牌
    - [x] 密码式获取（JWT）
  - [x] 日志
    - [x] 日志存储
      - [x] 文件
    - [x] 日志种类
      - [x] 接口请求日志

- [ ] **基础功能**
  - [x] 用户
    - [x] 图形验证码
  - [x] 用户管理
    - [x] 在线用户
    - [x] 用户强退
    - [ ] POS在线用户
  - [x] 角色管理
    - [x] 角色权限管理
  - [ ] 令牌
    - [ ] APIKey
    - [ ] 令牌管理
  - [ ] APIKey令牌管理
  - [ ] 接口权限
    - [x] 接口权限控制
    - [ ] 接口权限管理
  - [x] 接口文档
  - [ ] 开放接口
  - [ ] 日志
    - [ ] 日志存储
      - [ ] 数据库
      - [ ] elk
    - [ ] 日志种类
      - [ ] 登录日志
      - [ ] 业务操作日志
    - [ ] 日志浏览

- [ ] **进阶功能**
  - [ ] 数据权限
    - [ ] 数据权限控制
    - [ ] 数据权限管理
  - [ ] 定时任务
  - [ ] 通知公告
  - [ ] 监控
    - [ ] 系统信息(CPU,内存，磁盘...)
    - [ ] 连接池
  - [ ] 杂项
    - [ ] 版本号显示

### Service架构

- [x] 跨域
- [x] 数据库
  - [x] 多数据库兼容
  - [x] 自动升级schema
  - [x] 分页
    - [x] PageHelper
  - [x] 连接池
- [x] ORM
  - [x] MyBatis
  - [x] Mybatis Plus
- [x] 分布式锁
  - [x] redis
- [x] 分布式缓存
  - [x] redis
- [x] JWT
- [x] 验证框架
  - [x] Hibernator-Validator
- [ ] 负载均衡
- [ ] 消息队列
- [ ] 对象存储
  - [ ] OSS
  - [ ] MinIO
- [ ] 搜索引擎
  - [ ] Elasticsearch

### Client架构与功能

#### Client-app

- [ ] 主框架
- [ ] 基础组件
- [ ] 路由
- [ ] 网络访问
- [ ] 多语言
- [ ] 皮肤
- [ ] 日志
- [ ] native插件
- [ ] 画面大小调整

#### Client-mini-program-app

- [ ] 主框架
- [ ] 基础组件
- [ ] 路由
- [ ] 网络访问
- [ ] 多语言
- [ ] 皮肤
- [ ] 日志

#### Cient-admin

- [x] 主框架
- [x] 基础组件
- [x] 路由
- [x] 网络访问
- [x] 多语言
- [ ] 皮肤
- [ ] 日志
- [ ] 跨平台(PC,Pad,Mobile)
- [ ] 功能模块
  - [x] 登录
    - [x] 登录
    - [x] 图形验证码
  - [ ] 系统管理
    - [ ] 管理员
    - [ ] 角色
  - [ ] 日志管理
    - [ ] 系统日志
    - [ ] 登录日志
    - [ ] 用户操作日志
  - [x] 用户管理
    - [x] 在线用户
    - [x] 用户强退
  - [ ] 监控
    - [ ] 服务器监控

### 其他

- [x] 代码存储
  - [x] git
- [x] Docker
- [x] CI/CD
  - [x] Jenkins
