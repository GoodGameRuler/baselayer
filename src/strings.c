# include "strings.h"
#include <stdio.h>
#include <stdlib.h>
#include <string.h>

void destroy_string(string_t* string) {
    if(string->state != ALLOC) {
        return;
    }

    string->length = 0;
    string->state = (allocation) 0;
    string->destroy_string = NULL;

    char* ptr = string->ptr;
    string->ptr = NULL;

    free(ptr);
    free(string);
}

string_t* init_string(char* string_from, int length) {
    char* string_to = (char*) calloc(sizeof(char), length + 1);

    // if(strlen(string_from) != length) {
    //     return NULL;
    // }
    //
    strncpy(string_to, string_from, length);
    string_t* string_t_ptr = (string_t*) calloc(sizeof(string_t), 1);

    string_t_ptr->length = length;
    string_t_ptr->ptr = string_to;
    string_t_ptr->destroy_string = &destroy_string;
    string_t_ptr->state = ALLOC;

    return string_t_ptr;
}


string_t* resize_string(char* string_from, string_t* string_to, int length) {

    if(string_to->state != ALLOC) {
        fprintf(stderr, "[STRING] Error memory not alloced");
        return NULL;
    }

    if(strlen(string_from) != length) {
        return string_to;
    }

    string_to->ptr = (char*) realloc(string_to->ptr, sizeof(char) * (length + 1));
    memset(string_to->ptr, 0, length + 1);


    strncpy(string_to->ptr, string_from, length);

    string_to->length = length;

    return string_to;
}

string_t* string_cpy(string_t* string_t_from) {

    if(string_t_from->state != ALLOC) {
        return NULL;
    }

    return init_string(string_t_from->ptr, string_t_from->length);
}

string_t* string_slice(string_t* string_t_from, int i, int j) {

    if(string_t_from->state != ALLOC) {
        return NULL;
    }

    if(i > string_t_from->length || j > string_t_from->length) {

    // TODO think about adding circular slicing
    } else if(i > j) {
        return NULL;
    }

    return init_string(string_t_from->ptr + i, j - i);
}
