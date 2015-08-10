SRCPATH:=../

#得到所有.c文件的名称，去除路径
SRC:=$(wildcard $(SRCPATH)*.c)
SRC:=$(notdir $(SRC))

#得到即将要被生成的.o文件名称
OBJS:=$(SRC:.c=.o)

CC = gcc

INCLUDE = .

CFLAGS = -g -Wall

# makefile 的程序入口！
all : $(OBJS)

#引入.d文件，.d文件中包含了.c文件中头文件的依赖关系！
include $(OBJS:.o=.d)

%.d: $(SRCPATH)%.c
	set -e;rm -f $@;\
	$(CC) -MM $(CFLAGS) $< > $@.$$$$; \
	sed 's,\($*\)\.o[ :]*,\1.o $@ : ,g' < $@.$$$$ > $@; \
	rm -f $@.$$$$

%.o : $(SRCPATH)%.c
	$(CC) -I$(INCLUDE) $(CFLAGS) -c $< -o $@

.PHONY:all clean print

clean:
	@echo "i will clean..."
	-rm -rf *.o *.d main
	@echo "ok,i have cleaned!"
	
print:
	@echo $(OBJS)
