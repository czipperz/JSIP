#include "Debug.h"
#include "String.h"

#include <stdarg.h>
#include <stdio.h>
#include <stdlib.h>
#include <string.h>

String stringPrintf(const char* fmt, ...) {
    int size = strlen(fmt);
    String str;
    va_list ap;
    while(1) {
        str.resize(size);
        va_start(ap,fmt);
        int n = vsnprintf((char *)str.data(), size, fmt, ap);
        va_end(ap);
        
