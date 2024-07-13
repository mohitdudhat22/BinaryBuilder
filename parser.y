%{
#include <stdio.h>
#include <stdlib.h>

int yylex();
void yyerror(const char *s);

%}

%token NUMBER
%token PLUS MINUS MUL DIV
%token LPAREN RPAREN

%%

expr    : term 
        | term PLUS expr  { printf(" +"); }
        | term MINUS expr { printf(" -"); }
        ;

term    : factor 
        | factor MUL term { printf(" *"); }
        | factor DIV term { printf(" /"); }
        ;

factor  : NUMBER           { printf(" %d", $1); }
        | LPAREN expr RPAREN
        ;

%%

int main() {
    yyparse();
    return 0;
}

void yyerror(const char *s) {
    fprintf(stderr, "Error: %s\n", s);
}
