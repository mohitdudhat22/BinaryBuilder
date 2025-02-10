%{
#include "parser.tab.h"
#include <string.h>

// Add string handling
char string_buffer[1024];
%}

%%

// Keywords
"if"        { return IF; }
"else"      { return ELSE; }
"while"     { return WHILE; }
"print"     { return PRINT; }

// Operators
"+"         { return PLUS; }
"-"         { return MINUS; }
"*"         { return MUL; }
"/"         { return DIV; }
"="         { return ASSIGN; }
"=="        { return EQ; }
"!="        { return NEQ; }
"<"         { return LT; }
">"         { return GT; }
"<="        { return LTE; }
">="        { return GTE; }

// Delimiters
"("         { return LPAREN; }
")"         { return RPAREN; }
"{"         { return LBRACE; }
"}"         { return RBRACE; }
";"         { return SEMICOLON; }

// Variables and literals
[a-zA-Z_][a-zA-Z0-9_]*  { 
    yylval.string = strdup(yytext); 
    return IDENTIFIER; 
}
[0-9]+      { 
    yylval.number = atoi(yytext); 
    return NUMBER; 
}
\"[^\"]*\"  {
    strcpy(string_buffer, yytext+1);
    string_buffer[strlen(string_buffer)-1] = '\0';
    yylval.string = strdup(string_buffer);
    return STRING;
}

[ \t\n]+    ;  // Ignore whitespace
.           { printf("Unknown character: %s\n", yytext); }

%%

int yywrap() {
    return 1;
}
