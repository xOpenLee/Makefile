/*************************************************************************
	> File Name: main.c
	> Author: xopenlee
	> Mail: 750haige@gmail.com
	> Created Time: Monday, August 10, 2015 PM08:33:35 HKT
 ************************************************************************/

#include<stdio.h>

#include "first.h"
#include "second.h"

int main()
{
    printf("#INFO: %s\r\n", __FILE__);
    first();
    second();
    return 0;
}
