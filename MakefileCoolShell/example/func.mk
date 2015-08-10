
SOURCES := foo.c bar.c baz.s. ugh.h foo.c
SRC := $(wildcard *.c)
func_ret := $(subst ee,EE,     feet on the street    )
func_ret := $(patsubst %.c,%.o,$(SRC))
func:
	echo $(func_ret)
	echo $(SRC:*.o=*.c)
	echo $(strip $(func_ret))
	echo $(findstring on, $(func_ret))
	echo $(filter %.c, $(SOURCES))
	echo $(filter-out %.c, $(SOURCES))
	echo $(sort $(SOURCES))
	echo $(word 2, $(SOURCES))
	echo $(wordlist 2,3,$(SOURCES))
	echo $(words $(SOURCES))

