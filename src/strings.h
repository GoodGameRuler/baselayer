#ifndef STRINGS
#define STRINGS

typedef enum {
    ALLOC = 1,
    DEALLOC,
    STACK,
    STATIC,
} allocation;

typedef struct string_struct_type string_t;

struct string_struct_type {
    char* ptr;
    int length;
    void (*destroy_string)(string_t*);
    allocation state;
};

string_t* init_string(char* string_from, int length);
string_t* resize_string(char* string_from, string_t* string_to, int length);
string_t* string_cpy(string_t* string_t_from);
string_t* string_slice(string_t* string_t_from, int i, int j);

typedef struct {
    void* object;
    char* (*destroy_string)(void*);

} printable;

//TODO make printable interface function
#endif // !STRINGS
