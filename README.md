镜像地址：https://hub.docker.com/r/cloaks/yapi

## 构建镜像

```shell
docker build -t yapi:tag .
```

## 运行

```
docker run -d --name my-yapi --restart always -p 3000:3000 cloaks/yapi:1.12.0 
```

启动后编辑容器 `my-yapi/config.json` 配置文件, 重启 docker：

```json
{
   "port": "3000",
   "closeRegister": false,              // 禁止用户注册
   "adminAccount": "admin@admin.com",   // 管理员用户名，默认密码 ymfe.org
   "timeout": 120000,
   "db": {
      "servername": "127.0.0.1",        // mongodb IP 地址，可用域名代替
      "DATABASE": "yapi",               // 数据库名称
      "port": 27017,                    // 数据库端口
      "user": "test1",                  // 用户名
      "pass": "test1",                  // 密码
      "authSource": ""                  // 验证源
   },
    "mail": {
        "enable": true,
        "host": "smtp.163.com",         //邮箱服务器
        "port": 465,                    //端口
        "from": "***@163.com",          //发送人邮箱
        "auth": {
            "user": "***@163.com",      //邮箱服务器账号
            "pass": "*****"             //邮箱服务器密码
        }
    },
    "ldapLogin": {
      "enable": false,
      "server": "ldap://l-ldapt1.com",
      "baseDn": "CN=Admin,CN=Users,DC=test,DC=com",
      "bindPassword": "password123",
      "searchDn": "OU=UserContainer,DC=test,DC=com",
      "searchStandard": "mail",         // 自定义格式： "searchStandard": "&(objectClass=user)(cn=%s)"
      "emailPostfix": "@163.com",
      "emailKey": "mail",
      "usernameKey": "name"
    }
}
```

* enable 表示是否配置 LDAP 登录，true(支持 LDAP登录 )/false(不支持LDAP登录);
* server LDAP 服务器地址，前面需要加上 ldap:// 前缀，也可以是 ldaps:// 表示是通过 SSL 连接;
* baseDn LDAP 服务器的登录用户名，必须是从根结点到用户节点的全路径(非必须);
* bindPassword 登录该 LDAP 服务器的密码(非必须);
* searchDn 查询用户数据的路径，类似数据库中的一张表的地址，注意这里也必须是全路径;
* searchStandard 查询条件，这里是 mail 表示查询用户信息是通过邮箱信息来查询的。注意，该字段信息与LDAP数据库存储数据的字段相对应，如果如果存储用户邮箱信息的字段是 email, 这里就需要修改成 email.（1.3.18+支持）自定义filter表达式，基本形式为：&(objectClass=user)(cn=%s), 其中%s会被username替换
* emailPostfix 登陆邮箱后缀（非必须）
* emailKey: ldap数据库存放邮箱信息的字段（v1.3.21 新增 非必须）
* usernameKey: ldap数据库存放用户名信息的字段（v1.3.21 新增 非必须）

如何配置 mongodb 集群

请升级到 yapi >= 1.4.0以上版本，然后在 config.json db项，配置 connectString:

```json
{
  "port": "***",
  "db": {
    "connectString": "mongodb://127.0.0.100:8418,127.0.0.101:8418,127.0.0.102:8418/yapidb?slaveOk=true",
    "user": "******",
    "pass": "******"
  },
}
```