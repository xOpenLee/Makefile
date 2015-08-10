#$(wildcard *.c) 展开所有.c后缀的源文件
#patsubst 列出所有.c 对应的.o文件
objects := $(patsubst %.c, %.o, $(wildcard *.c))

define run-exec
	@cd /home/xopenlee 
	@pwd
endef

ifeq (0, $(MAKELEVEL))
	cur-dr := $(shell pwd)
	whoami := $(shell whoami)
	host-type :=$(shell arch)
	MAKE := $(MAKE) host-type = $(host-type) whoami = $(whoami)
endif

ifeq ($(origin FOO), undefined)
	FOO = bar
endif

foo := a.o b.o c.o
bar := $(foo:.o=.c) # 将a.o b.o c.o 替换 a.c b.c c.c
bar := $(foo:%.o=%.c) # 将a.o b.o c.o 替换 a.c b.c c.c
	
x = variable1
variable2 := hello
y = $(subst 1,2,$(x))
z = y
a := $($($(z)))

a_objects := a.o b.o c.o
1_objects := 1.o 2.o 3.o
sources := $($(a1)_objects:.o=.c)# ifeq (a1, a) $(sources) := 1.c 2.c 3.c

edit : $(objects)
	@echo "linking target..."
	cc -o edit $(objects)

$(objects) : %.o : %.c
	@echo "compiling... "
	cc  -c $< 

.PHONY:clean print all exec
all : progA  progB

exec:
	$(run-exec)

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
