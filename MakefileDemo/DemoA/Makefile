make_subdir := ./src/util/maker/ ./maker/  

all:  
	@for  subdir in $(make_subdir) ; do \
		echo "making $$subdir" ; \
		$(MAKE) -C $$subdir ; \
	done

.PHONY: clean
clean:
	@echo "send clean order..."
	@for subdir in $(make_subdir) ; do \
		$(MAKE) -C $$subdir clean ; \
	done
	@echo " recive singal of clean over"

