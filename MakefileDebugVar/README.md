# 如何调试makefile变量
六、七年前写过一篇《跟我一起写Makefile》，直到今天，还有一些朋友问我一些MAKE_VERSIONfile的问题，老实说，我有一段时间没有用Makefile了，生疏了。回顾，这几年来大家问题我的问题，其实很多时候是makefile的调试问题。所以，就像我在之前的那篇关于GDB的技巧的文章中做的一样，在这里向大家介绍一个小小的调试变量的技巧。相信一定对你有用。
对于Makefile中的各种变量，可能是我们比较头痛的事了。我们要查看他们并不是很方便，需要修改makefile加入echo命令。这有时候很不方便。其实我们可以制作下面一个专门用来输出变量的makefile（假设名字叫：vars.mk）

vars.mk
%:
    @echo '$*=$($*)'
d-%:
	@echo '$*=$($*)'
	@echo '  origin = $(origin $*)'
	@echo '   value = $(value  $*)'
	@echo '  flavor = $(flavor $*)'

这样一来，我们可以使用make命令的-f参数来查看makefile中的相关变量（包括make的内建变量，比如：COMPILE.c或MAKE_VERSION之类的）。注意：第二个以“d-”为前缀的目标可以用来打印关于这个变量更为详细的东西（后面有详细说明）

假设我们的makefile是这个样子（test.mk）

OBJDIR := objdir
OBJS := $(addprefix $(OBJDIR)/,foo.o bar.o baz.o)

foo = $(bar)bar = $(ugh)ugh = Huh?

CFLAGS = $(include_dirs) -O
include_dirs = -Ifoo -Ibar
CFLAGS := $(CFLAGS) -Wall

MYOBJ := a.o b.o c.o
MYSRC := $(MYOBJ:.o=.c)

那么，我们可以这样进行调试：


[hchen@RHELSVR5]$ make -f test.mk -f var.mk OBJS
OBJS=objdir/foo.o objdir/bar.o objdir/baz.o

[hchen@RHELSVR5]$ make -f test.mk -f var.mk d-foo
foo=Huh?
origin = file
value = $(bar)
flavor = recursive

[hchen@RHELSVR5]$ make -f test.mk -f var.mk d-CFLAGS
CFLAGS=-Ifoo -Ibar -O -O
origin = file
value = -Ifoo -Ibar -O -O
flavor = simple
[hchen@RHELSVR5]$  make -f test.mk -f var.mk d-COMPILE.c
COMPILE.c=cc -Ifoo -Ibar -O -Wall   -c
origin = default
flavor = recursive
value = $(CC) $(CFLAGS) $(CPPFLAGS) $(TARGET_ARCH) -c

我们可以看到：
make的第一个-f后是要测试的makefile，第二个是我们的debug makefile。
后面直接跟变量名，如果在变量名前加”d-“，则输出更为详细的东西。

说一说”d-” 前缀（其意为details），其中调用了下面三个参数。

$(origin)：告诉你这个变量是来自哪儿，file表示文件，environment表示环境变量，还有environment override，command line，override，automatic等。
$(value)：打出这个变量没有被展开的样子。比如上述示例中的 foo 变量。
$(flavor)：有两个值，simple表示是一般展开的变量，recursive表示递归展开的变量。
（全文完）

（转载本站文章请注明作者和出处 酷 壳 – CoolShell.cn ，请勿用于任何商业用途）
