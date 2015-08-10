#层级目录结构Makefile模板
##功能
	1.makefile主要内容都放在顶层目录下的Makefile.env中，子层Makefile包含这个
Makefile.env，只要增加一些变量就可以编译，特别方便添加新的功能模块
    2.自动解析头文件依赖
##目录结构
	1. 源文件目录src，模块xxx放在src/xxx下，主程序在src/main下面
	
	2.公共头文件放在include目录下，模块xxx的头文件放在include/xxx目录下
	
	3.模块输出的链接库放在lib目录下
	
	4.可执行文件放在bin目录下
###博客应用
http://www.cnblogs.com/coderkian/p/3479564.html
