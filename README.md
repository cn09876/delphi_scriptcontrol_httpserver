# delphi_scriptcontrol_httpserver
DELPHI7，使用古老的ScriptControl解析脚本，用INDY包了一层httpserver,做的一个类似ASP服务器的程序
使用tadoquery访问数据库（例子里用的ACCESS）

- 使用ScriptControl来解析VBS脚本
- 使用Indy的TIDHttpServer来接收HTTP请求
- 如果遇到.ssf文件，则直接解析程序同目录中的*.ssf并返回给网页显示
- 实现了数据库访问，脚本中可以直接调用sv,query,可直接返回记录集,祥见d.ssf
- 预定义了几个函数,echo,test，可以在tlb中增加或修改

