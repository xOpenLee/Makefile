/*************************************************************************
	> File Name: edit.c
	> Author: xopenlee
	> Mail: 750haige@gmail.com
	> Created Time: Saturday, August 08, 2015 PM10:13:40 HKT
 ************************************************************************/

#include<stdio.h>
#include"utils.h"
#include"files.h"
#include"search.h"
#include"insert.h"
#include"display.h"
#include"cmd.h"

int main()
{
    printf("###INFO: start main\r\n");
	cmd();
	display();
	insert();
	search();
	files();
	utils();
}
