#!/bin/bash 
TARGET=edit
COPY_SAMPLE=kbd
OBJS=("cmd" "display" "insert" "search" "files" "utils")

suffix(){
    cp ${COPY_SAMPLE}.$2 $1.$2
    sed -i 's/'$COPY_SAMPLE'/'$1'/' $1.$2
}

do_copy(){

	for FILE in ${OBJS[@]}
	do
	    suffix ${FILE} c
	    suffix ${FILE} h
	done
	
}

do_clean(){
    for FILE in ${OBJS[@]}
    do
        rm -rf ${FILE}.*
        sed -i '/'${FILE}'/d' ${TARGET}.c
    done
}

do_install(){ 

    for FILE in ${OBJS[@]}
    do
        sed -i '/stdio/a#include"'${FILE}'.h"' ${TARGET}.c
        sed -i '/}/i\\t'${FILE}'();' ${TARGET}.c
    done
}


if [ "$1" = "-c" ];then
    do_copy
    exit 1
elif [ "$1" = "-m" ];then
    do_clean
    exit 2
elif [ "$1" = "-i" ];then
    do_install
    exit 3
else 
    echo "usage: ./copyShell.sh [OPTION]"
    echo "     -c, --copy copy file"
    echo "     -m, --move clean OBJS"
    echo "     -i, --install install the function to the TARGET"
    exit 4
fi

exit 0
