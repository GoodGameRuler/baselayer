#include <stdio.h>
#include <string.h>
#include "strings.h"

int main(void) {

    char* literal = "Hello World";
    string_t* str = init_string(literal, strlen(literal));

    printf("%s - %d\n", str->ptr, str->length);
    char* literal2 = "Hello You Just Got Hacked";
    str = resize_string(literal2, str, strlen(literal2));
    printf("%s - %d\n", str->ptr, str->length);

    string_t* str_cpy = string_slice(str, 0, 5);
    printf("%s - %d\n", str_cpy->ptr, str_cpy->length);
    str->destroy_string(str);
    str_cpy->destroy_string(str_cpy);
}
