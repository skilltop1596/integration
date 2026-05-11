# CRM系统 - 业务管理平台

一个基于.NET 8和Vue 3的企业级客户关系管理系统。

## 技术栈

### 后端

- **框架**: .NET 8 (C#)
- **ORM**: SqlSugar
- **数据库**: SQL Server 2019 / SQLite
- **认证**: JWT
- **API文档**: Swagger

### 前端

- **框架**: Vue 3 (Composition API)
- **UI组件**: Element Plus
- **状态管理**: Pinia
- **路由**: Vue Router
- **构建工具**: Vite
- **HTTP客户端**: Axios

## 功能模块

1. **仪表盘 (Dashboard)** - 系统概览和数据统计
2. **客户管理 (Customer Management)** - 客户信息管理和跟进记录
3. **项目管理 (Project Management)** - 项目创建和状态追踪
4. **反馈管理 (Feedback Management)** - 反馈工单处理
5. **文档中心 (Document Center)** - 文档上传和版本管理
6. **系统管理 (System Management)** - 用户、角色、权限管理

## 快速开始

### 环境要求

- .NET 8 SDK
- Node.js 18+
- SQL Server 2019 或 SQLite

### 后端启动

```bash
# 进入后端目录
cd Backend/Api

# 构建项目
dotnet build

# 运行项目
dotnet run --configuration Development
```

后端服务将在 `http://localhost:5099` 启动。

### 前端启动

```bash
# 进入前端目录
cd Frontend

# 安装依赖
npm install

# 开发模式运行
npm run dev
```

前端服务将在 `http://localhost:5173` 启动。

### 登录信息

默认管理员账号：

- 用户名: `admin`
- 密码: `123456`

## 项目结构

```
CRM/
├── Backend/                    # 后端代码
│   ├── Api/                   # API项目
│   ├── Application/           # 应用服务层
│   ├── Domain/                # 领域模型
│   ├── Infrastructure/        # 基础设施层
│   └── DbInitializerCli/      # 数据库初始化工具
├── Frontend/                  # 前端代码
│   ├── src/
│   │   ├── api/               # API调用
│   │   ├── router/            # 路由配置
│   │   ├── stores/            # 状态管理
│   │   └── views/             # 页面组件
│   └── dist/                  # 构建输出
└── README.md
```

## API接口

### 认证接口

- `POST /api/auth/login` - 用户登录

### 客户管理接口

- `GET /api/customer` - 获取客户列表
- `POST /api/customer` - 创建客户
- `GET /api/customer/{id}` - 获取客户详情
- `PUT /api/customer` - 更新客户
- `DELETE /api/customer/{id}` - 删除客户

### 项目管理接口

- `GET /api/project` - 获取项目列表
- `POST /api/project` - 创建项目
- `GET /api/project/{id}` - 获取项目详情
- `PUT /api/project` - 更新项目

### 反馈管理接口

- `GET /api/feedback` - 获取反馈列表
- `POST /api/feedback` - 创建反馈

### 文档管理接口

- `GET /api/document` - 获取文档列表
- `POST /api/document` - 创建文档
- `POST /api/document/upload` - 上传文档文件

### 系统管理接口

- `GET /api/user` - 获取用户列表
- `GET /api/role` - 获取角色列表
- `GET /api/permission` - 获取权限列表

## 数据库配置

在 `Backend/Api/appsettings.json` 中配置数据库连接：

```json
{
  "ConnectionStrings": {
    "DefaultConnection": "Server=localhost;Database=business_management_platform;User Id=sa;Password=123456;TrustServerCertificate=True;"
  }
}
```

## License

MIT License
