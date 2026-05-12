USE business_management_platform;

CREATE TABLE TB_SYS_Role (
    ID BIGINT PRIMARY KEY IDENTITY(1,1),
    RoleName VARCHAR(50) NOT NULL,
    RoleCode VARCHAR(50) NOT NULL UNIQUE,
    RoleDesc TEXT,
    Status VARCHAR(20) NOT NULL,
    IsDelete BIT NOT NULL DEFAULT 0,
    CreateTime DATETIME NOT NULL DEFAULT GETDATE(),
    UpdateTime DATETIME NOT NULL DEFAULT GETDATE()
);

CREATE TABLE TB_SYS_Module (
    ID BIGINT PRIMARY KEY IDENTITY(1,1),
    ModuleName VARCHAR(50) NOT NULL,
    ModuleCode VARCHAR(50) NOT NULL,
    ParentId BIGINT,
    ModuleType VARCHAR(20),
    ResponsiblePerson VARCHAR(50),
    ModuleDesc TEXT,
    Status VARCHAR(20) NOT NULL,
    IsDelete BIT NOT NULL DEFAULT 0,
    CreateTime DATETIME NOT NULL DEFAULT GETDATE(),
    UpdateTime DATETIME NOT NULL DEFAULT GETDATE()
);

CREATE TABLE TB_SYS_Permission (
    ID BIGINT PRIMARY KEY IDENTITY(1,1),
    RoleId BIGINT,
    ModuleId BIGINT,
    PermissionName VARCHAR(50) NOT NULL,
    PermissionCode VARCHAR(50) NOT NULL,
    MenuPath VARCHAR(100),
    ParentId BIGINT,
    Sort INT NOT NULL DEFAULT 0,
    IsMenu BIT NOT NULL DEFAULT 0,
    IsDelete BIT NOT NULL DEFAULT 0,
    FOREIGN KEY (RoleId) REFERENCES TB_SYS_Role(ID),
    FOREIGN KEY (ModuleId) REFERENCES TB_SYS_Module(ID)
);

ALTER TABLE TB_SYS_Module ADD CONSTRAINT FK_Module_Parent FOREIGN KEY (ParentId) REFERENCES TB_SYS_Module(ID);
ALTER TABLE TB_SYS_Permission ADD CONSTRAINT FK_Permission_Parent FOREIGN KEY (ParentId) REFERENCES TB_SYS_Permission(ID);

CREATE TABLE TB_SYS_User (
    ID BIGINT PRIMARY KEY IDENTITY(1,1),
    UserName VARCHAR(50) NOT NULL UNIQUE,
    Password VARCHAR(100) NOT NULL,
    RealName VARCHAR(50) NOT NULL,
    Email VARCHAR(100),
    Phone VARCHAR(20),
    RoleId BIGINT,
    Status VARCHAR(20) NOT NULL,
    IsDelete BIT NOT NULL DEFAULT 0,
    CreateTime DATETIME NOT NULL DEFAULT GETDATE(),
    UpdateTime DATETIME NOT NULL DEFAULT GETDATE(),
    FOREIGN KEY (RoleId) REFERENCES TB_SYS_Role(ID)
);

CREATE TABLE TB_CRM_Customer (
    ID BIGINT PRIMARY KEY IDENTITY(1,1),
    CustomerNo VARCHAR(50) NOT NULL,
    CustomerName VARCHAR(100) NOT NULL,
    Industry VARCHAR(50),
    CustomerLevel VARCHAR(20),
    Source VARCHAR(50),
    ContactPhone VARCHAR(20),
    Address VARCHAR(200),
    ProductionScale VARCHAR(50),
    MainProduct VARCHAR(100),
    BudgetRange VARCHAR(50),
    DecisionCycle VARCHAR(50),
    ResponsiblePerson VARCHAR(50),
    CustomerDesc TEXT,
    IsDelete BIT NOT NULL DEFAULT 0,
    CreateTime DATETIME NOT NULL DEFAULT GETDATE(),
    UpdateTime DATETIME NOT NULL DEFAULT GETDATE()
);

CREATE TABLE TB_CRM_Contact (
    ID BIGINT PRIMARY KEY IDENTITY(1,1),
    CustomerId BIGINT NOT NULL,
    ContactName VARCHAR(50) NOT NULL,
    Position VARCHAR(50),
    Phone VARCHAR(20),
    Email VARCHAR(100),
    WeChat VARCHAR(50),
    QQ VARCHAR(20),
    ContactDesc TEXT,
    IsDelete BIT NOT NULL DEFAULT 0,
    CreateTime DATETIME NOT NULL DEFAULT GETDATE(),
    UpdateTime DATETIME NOT NULL DEFAULT GETDATE(),
    FOREIGN KEY (CustomerId) REFERENCES TB_CRM_Customer(ID)
);

CREATE TABLE TB_CRM_FollowRecord (
    ID BIGINT PRIMARY KEY IDENTITY(1,1),
    CustomerId BIGINT NOT NULL,
    ContactId BIGINT,
    FollowWay VARCHAR(50) NOT NULL,
    FollowContent TEXT NOT NULL,
    NextFollowPlan DATETIME,
    FollowResult VARCHAR(50),
    FollowPerson VARCHAR(50),
    IsDelete BIT NOT NULL DEFAULT 0,
    CreateTime DATETIME NOT NULL DEFAULT GETDATE(),
    UpdateTime DATETIME NOT NULL DEFAULT GETDATE(),
    FOREIGN KEY (CustomerId) REFERENCES TB_CRM_Customer(ID),
    FOREIGN KEY (ContactId) REFERENCES TB_CRM_Contact(ID)
);

CREATE TABLE TB_CRM_CustomerLabel (
    ID BIGINT PRIMARY KEY IDENTITY(1,1),
    CustomerId BIGINT NOT NULL,
    LabelName VARCHAR(50) NOT NULL,
    IsDelete BIT NOT NULL DEFAULT 0,
    CreateTime DATETIME NOT NULL DEFAULT GETDATE(),
    FOREIGN KEY (CustomerId) REFERENCES TB_CRM_Customer(ID)
);

CREATE TABLE TB_PRJ_Project (
    ID BIGINT PRIMARY KEY IDENTITY(1,1),
    ProjectNo VARCHAR(50) NOT NULL,
    ProjectName VARCHAR(100) NOT NULL,
    ProjectType VARCHAR(50),
    CustomerId BIGINT,
    ResponsiblePerson VARCHAR(50),
    ProjectDesc TEXT,
    Status VARCHAR(20) NOT NULL,
    StartDate DATETIME,
    EndDate DATETIME,
    Budget DECIMAL(18,2),
    ActualCost DECIMAL(18,2),
    Progress DECIMAL(5,2),
    IsDelete BIT NOT NULL DEFAULT 0,
    CreateTime DATETIME NOT NULL DEFAULT GETDATE(),
    UpdateTime DATETIME NOT NULL DEFAULT GETDATE(),
    FOREIGN KEY (CustomerId) REFERENCES TB_CRM_Customer(ID)
);

CREATE TABLE TB_PRJ_Milestone (
    ID BIGINT PRIMARY KEY IDENTITY(1,1),
    ProjectId BIGINT NOT NULL,
    MilestoneName VARCHAR(100) NOT NULL,
    TargetDate DATETIME NOT NULL,
    Status VARCHAR(20) NOT NULL,
    ResponsiblePerson VARCHAR(50),
    Remark TEXT,
    IsDelete BIT NOT NULL DEFAULT 0,
    CreateTime DATETIME NOT NULL DEFAULT GETDATE(),
    UpdateTime DATETIME NOT NULL DEFAULT GETDATE(),
    FOREIGN KEY (ProjectId) REFERENCES TB_PRJ_Project(ID)
);

CREATE TABLE TB_PRJ_Feedback (
    ID BIGINT PRIMARY KEY IDENTITY(1,1),
    FeedbackNo VARCHAR(50) NOT NULL,
    ProjectId BIGINT,
    CustomerId BIGINT,
    FeedbackType VARCHAR(50) NOT NULL,
    FeedbackContent TEXT NOT NULL,
    Priority VARCHAR(20) NOT NULL,
    Status VARCHAR(20) NOT NULL,
    Handler VARCHAR(50),
    HandleResult TEXT,
    HandleTime DATETIME,
    Remark TEXT,
    IsDelete BIT NOT NULL DEFAULT 0,
    CreateTime DATETIME NOT NULL DEFAULT GETDATE(),
    UpdateTime DATETIME NOT NULL DEFAULT GETDATE(),
    FOREIGN KEY (ProjectId) REFERENCES TB_PRJ_Project(ID),
    FOREIGN KEY (CustomerId) REFERENCES TB_CRM_Customer(ID)
);

CREATE TABLE TB_DOC_Document (
    ID BIGINT PRIMARY KEY IDENTITY(1,1),
    DocumentNo VARCHAR(50) NOT NULL,
    DocumentName VARCHAR(100) NOT NULL,
    ProjectId BIGINT,
    ModuleId BIGINT,
    DocumentType VARCHAR(50),
    FilePath VARCHAR(200) NOT NULL,
    FileName VARCHAR(100) NOT NULL,
    FileType VARCHAR(20),
    FileSize BIGINT,
    Version VARCHAR(20) NOT NULL DEFAULT '1.0',
    VersionDesc VARCHAR(200),
    Uploader VARCHAR(50),
    IsDelete BIT NOT NULL DEFAULT 0,
    CreateTime DATETIME NOT NULL DEFAULT GETDATE(),
    UpdateTime DATETIME NOT NULL DEFAULT GETDATE(),
    FOREIGN KEY (ProjectId) REFERENCES TB_PRJ_Project(ID),
    FOREIGN KEY (ModuleId) REFERENCES TB_SYS_Module(ID)
);

CREATE TABLE TB_DOC_DocumentVersion (
    ID BIGINT PRIMARY KEY IDENTITY(1,1),
    DocumentId BIGINT NOT NULL,
    Version VARCHAR(20) NOT NULL,
    FilePath VARCHAR(200) NOT NULL,
    FileName VARCHAR(100) NOT NULL,
    VersionDesc VARCHAR(200),
    Uploader VARCHAR(50),
    IsDelete BIT NOT NULL DEFAULT 0,
    CreateTime DATETIME NOT NULL DEFAULT GETDATE(),
    FOREIGN KEY (DocumentId) REFERENCES TB_DOC_Document(ID)
);

INSERT INTO TB_SYS_Role (RoleName, RoleCode, RoleDesc, Status) VALUES ('管理员', 'ADMIN', '系统管理员', 'Active');
INSERT INTO TB_SYS_Role (RoleName, RoleCode, RoleDesc, Status) VALUES ('普通用户', 'USER', '普通用户', 'Active');

INSERT INTO TB_SYS_User (UserName, Password, RealName, Email, Phone, RoleId, Status) 
VALUES ('admin', '$2a$10$N9qo8uLOickgx2ZMRZoMye.IjzqAKL9xL5jvMFVdNJHvGCgTq/VEq', '系统管理员', 'admin@example.com', '13800138000', 1, 'Active');

INSERT INTO TB_SYS_Permission (PermissionName, PermissionCode, MenuPath, ParentId, Sort, IsMenu) VALUES ('仪表盘', 'dashboard', '/dashboard', NULL, 1, 1);
INSERT INTO TB_SYS_Permission (PermissionName, PermissionCode, MenuPath, ParentId, Sort, IsMenu) VALUES ('客户管理', 'customer', '/customer', NULL, 2, 1);
INSERT INTO TB_SYS_Permission (PermissionName, PermissionCode, MenuPath, ParentId, Sort, IsMenu) VALUES ('跟进记录', 'followRecord', '/follow-record', NULL, 3, 1);
INSERT INTO TB_SYS_Permission (PermissionName, PermissionCode, MenuPath, ParentId, Sort, IsMenu) VALUES ('工单反馈', 'feedback', '/feedback', NULL, 4, 1);
INSERT INTO TB_SYS_Permission (PermissionName, PermissionCode, MenuPath, ParentId, Sort, IsMenu) VALUES ('项目管理', 'project', '/project', NULL, 5, 1);
INSERT INTO TB_SYS_Permission (PermissionName, PermissionCode, MenuPath, ParentId, Sort, IsMenu) VALUES ('文档中心', 'document', '/document', NULL, 6, 1);
INSERT INTO TB_SYS_Permission (PermissionName, PermissionCode, MenuPath, ParentId, Sort, IsMenu) VALUES ('系统管理', 'system', NULL, NULL, 7, 1);
INSERT INTO TB_SYS_Permission (PermissionName, PermissionCode, MenuPath, ParentId, Sort, IsMenu) VALUES ('用户管理', 'system:user', '/system/user', 7, 1, 1);
INSERT INTO TB_SYS_Permission (PermissionName, PermissionCode, MenuPath, ParentId, Sort, IsMenu) VALUES ('角色管理', 'system:role', '/system/role', 7, 2, 1);
INSERT INTO TB_SYS_Permission (PermissionName, PermissionCode, MenuPath, ParentId, Sort, IsMenu) VALUES ('权限管理', 'system:permission', '/system/permission', 7, 3, 1);