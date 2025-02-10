%{
#include <stdio.h>
#include <stdlib.h>
#include <string.h>

void yyerror(const char *s);
int yylex(void);

// Symbol table structure
struct symbol {
    char *name;
    int value;
};
struct symbol symbols[100];
int symbol_count = 0;
%}

%union {
    int number;
    char *string;
}

// Token declarations
%token <number> NUMBER
%token <string> IDENTIFIER STRING
%token PLUS MINUS MUL DIV
%token ASSIGN EQ NEQ LT GT LTE GTE
%token IF ELSE WHILE PRINT
%token LPAREN RPAREN LBRACE RBRACE SEMICOLON

// Operator precedence
%left PLUS MINUS
%left MUL DIV

%%

program:
    | program statement
    ;

statement:
    expr SEMICOLON                    { printf("Result: %d\n", $1); }
    | IDENTIFIER ASSIGN expr SEMICOLON { 
        // Handle variable assignment
        int sym_idx = -1;
        for(int i = 0; i < symbol_count; i++) {
            if(strcmp(symbols[i].name, $1) == 0) {
                sym_idx = i;
                break;
            }
        }
        if(sym_idx == -1) {
            symbols[symbol_count].name = strdup($1);
            symbols[symbol_count].value = $3;
            symbol_count++;
        } else {
            symbols[sym_idx].value = $3;
        }
    }
    | PRINT expr SEMICOLON           { printf("%d\n", $2); }
    | if_statement
    | while_statement
    ;

if_statement:
    IF LPAREN expr RPAREN LBRACE program RBRACE
    | IF LPAREN expr RPAREN LBRACE program RBRACE ELSE LBRACE program RBRACE
    ;

while_statement:
    WHILE LPAREN expr RPAREN LBRACE program RBRACE
    ;

expr:
    NUMBER
    | IDENTIFIER    { 
        // Look up variable value
        for(int i = 0; i < symbol_count; i++) {
            if(strcmp(symbols[i].name, $1) == 0) {
                $$ = symbols[i].value;
                break;
            }
        }
    }
    | expr PLUS expr   { $$ = $1 + $3; }
    | expr MINUS expr  { $$ = $1 - $3; }
    | expr MUL expr    { $$ = $1 * $3; }
    | expr DIV expr    { $$ = $1 / $3; }
    | LPAREN expr RPAREN { $$ = $2; }
    ;

%%

void yyerror(const char *s) {
    fprintf(stderr, "Error: %s\n", s);
}

int main(void) {
    yyparse();
    return 0;
}
