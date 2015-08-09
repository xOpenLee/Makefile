#$(wildcard *.c) 展开所有.c后缀的源文件
#patsubst 列出所有.c 对应的.o文件
objects := $(patsubst %.c, %.o, $(wildcard *.c))

edit : $(objects)
	cc -o edit $(objects)

$(objects) : %.o : %.c
	cc  -c $< 

.PHONY:clean print all
all : progA  progB

clean :
	-rm -rf $(objects)

print : *.c
	lpr -p $?
	touch print

progA:utils.o
	cc -o utils utils.o

progB:files.o
	cc -o files files.o

#include include.mk
