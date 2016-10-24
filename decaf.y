%{
#include <cstdio>
#include <iostream>
#include <fstream>
using namespace std;

extern "C" int yylex();
extern "C" int yyparse();
extern "C" FILE *yyin;
int flag_check = 0;
ofstream out;

void yyerror(const char *s);
%}


%union {
    int ival;
    bool bval;
    char cval;
    char *sval;
}


%token CLASS PROGRAM VOID IF FOR ELSE RETURN BREAK CONTINUE CALLOUT INT_DECLARATION BOOLEAN_DECLARATION ID STRING  ASSIGN_OP ADD SUB DIV MUL MOD EQUAL SMALLER GREATER ESMALLER EGREATER EQUALEQUAL NOTEQUAL AND OR

%token <ival> INT
%token <bval> BOOLEAN
%token <cval> CHARACTER
%type <sval> ID
%type <sval> STRING

%left OR
%left AND
%nonassoc SMALLER GREATER ESMALLER EGREATER
%left EQUALEQUAL NOTEQUAL

%left ADD SUB
%left MUL DIV MOD

%precedence '!' USUB
%%

program:
    CLASS PROGRAM '{' field_declarations '}' { out << "PROGRAM ENCOUNTERED" << endl; }
    | CLASS PROGRAM '{' method_declarations '}' { out << "PROGRAM ENCOUNTERED" << endl; }
    | CLASS PROGRAM '{' field_declarations method_declarations '}' { out << "PROGRAM ENCOUNTERED" << endl; }
    | CLASS PROGRAM '{' '}' { out << "PROGRAM ENCOUNTERED" << endl; }
    ;



field_declarations:
    field_declarations field_declaration {out << "FIELD_DECLARATION ENCOUNTERED" << endl; } 
    | field_declaration {out << "FIELD_DECLARATION ENCOUNTERED" << endl; }
    ;
    
field_declaration:
    type id_comma ';'
    ;

id_comma:
    id_comma ',' ID { out << "ID=" << $3 << endl; }
    | id_comma ',' ID '[' INT ']' {out << "ID=" << $3 << endl; out << "SIZE=" << $5 << endl; }
    | ID {out << "ID=" << $1 << endl; }
    | ID '[' INT ']' {out << "ID=" << $1 << endl; out << "SIZE=" << $3 << endl; }
    ;
    

method_declarations:
    method_declarations method_declaration  { out << "METHOD_DECLARATION ENCOUNTERED" << endl; }
    | method_declaration { out << "METHOD_DECLARATION ENCOUNTERED" << endl; }
    ;

method_declaration:
    type ID '(' arguments ')' block { out << "METHOD=" << $2 << endl; }
    | VOID ID '(' arguments ')' block { out << "VOID ENCOUNTERED" << endl; out << "METHOD=" << $2 << endl; }
    ;

arguments:
    argument
    | empty
    ;
    
argument:
    argument ',' type ID { out << "ID=" << $4 << endl; }
    | type ID { out << "ID=" << $2 << endl; }
    ;
    
block:
    '{' var_declarations statements '}'
    | '{' statements '}'
    | '{' var_declarations '}'
    | '{' '}'
    ;
    
var_declarations:
    var_declarations var_declaration  {out << "VAR_DECLARATION ENCOUNTERED" << endl; }
    | var_declaration {out << "VAR_DECLARATION ENCOUNTERED" << endl; }
    ;
    
var_declaration:
    type id_commas ';'
    ;
    
id_commas:
    id_commas ',' ID  {out << "ID=" << $3 << endl; }
    | ID {out << "ID=" << $1 << endl; }
    ;

type:
    INT_DECLARATION                 { out << "INT_DECLARATION ENCOUNTERED" << endl; }
    | BOOLEAN_DECLARATION           { out << "BOOLEAN_DECLARATION ENCOUNTERED" << endl; }
    ;

statements:                         
    statements statement            {out << "STATEMENT ENCOUNTERED" << endl; }
    | statement                     {out << "STATEMENT ENCOUNTERED" << endl; }
    ;
    
statement:
    location assign_op expr ';'  { out << "ASSIGN_OP ENCOUNTERED" << endl;}
    | method_call ';'
    | IF '(' expr ')' block else_block { out << "IF ENCOUNTERD" << endl; }
    | FOR ID EQUAL expr ',' expr block { out << "FOR ENCOUNTERED" << endl; out << "ID=" << $2 << endl; }
    | RETURN return_expr ';'       { out << "RETURN ENCOUNTERD" << endl; }
    | BREAK ';'                 { out << "BREAK ENCOUNTERED" << endl; }
    | CONTINUE ';'              { out << "CONTINUE ENCOUNTERED" << endl; }
    | block
    ;
    
return_expr:
    expr
    | empty
    ;
    
else_block:
    ELSE block                  { out << "ELSE ENCOUNTERED" << endl; }
    | empty;
    ;

method_call:
    method_name '(' expr_comma ')'
    | CALLOUT '(' STRING ')'        { out << "CALLOUT TO " << $3 << " ENCOUNTERED" << endl; }
    | CALLOUT '(' STRING ',' callout_arg_comma ')' { out << "CALLOUT TO " << $3 << " ENCOUNTERED" << endl; }
    ;


expr_comma:
    empty
    | expr_comma ',' expr
    | expr
    ;
     
expr:
    location
    | method_call
    | literal
    | expr ADD expr       { out << "ADD ENCOUNTERED" << endl; }
    | expr SUB expr       { out << "SUB ENCOUNTERED" << endl; }
    | expr MUL expr       { out << "MUL ENCOUNTERED" << endl; }
    | expr DIV expr       { out << "DIV ENCOUNTERED" << endl; }
    | expr MOD expr       { out << "MOD ENCOUNTERED" << endl; }
    | expr SMALLER expr    { out << "LESS THAN ENCOUNTERED" << endl; }
    | expr ESMALLER expr    { out << "LESS THAN EQUAL ENCOUNTERED" << endl; }
    | expr GREATER expr     { out << "GREATER THAN ENCOUNTERED" << endl; }
    | expr EGREATER expr    { out << "GREATER THAN EQUAL ENCOUNTERED" << endl; }
    | expr EQUALEQUAL expr  { out << "EQUAL EQUAL ENCOUNTERED" << endl; }
    | expr NOTEQUAL expr    { out << "NOT EQUAL ENCOUNTERED" << endl; }
    | expr AND expr         { out << "AND ENCOUNTERED" << endl; }
    | expr OR expr          { out << "OR ENCOUNTERED" << endl; }
    | SUB expr %prec USUB { out << "USUB ENCOUNTERED" << endl; }
    | '!' expr            { out << "NOT ENCOUNTERED" << endl; }
    | '(' expr ')'
    ;

location:
    ID                    { out << "LOCATION ENCOUNTERED=" << $1 << endl; }
    | ID '[' expr ']'     { out << "LOCATION ENCOUNTERED=" << $1 << endl; }
    ;

callout_arg_comma:
    callout_arg_comma ',' expr
    | callout_arg_comma ',' STRING { out << "STRING_ENCOUNTERED=" << $3 << endl;}
    | expr
    | STRING     { out << "STRING_ENCOUNTERED=" << $1 << endl;}
    ;

method_name:
    ID                  { out << "METHOD=" << $1 << endl; }
    ;


literal:
    INT                 { out << "INT ENCOUNTERED=" << $1 << endl; }
    | CHARACTER         { out << "CHAR ENCOUNTERED=" << $1 << endl; }
    | BOOLEAN           { out << "BOOLEAN ENCOUNTERED=" << $1 << endl; }
    ;

assign_op:
    EQUAL               { out << "ASSIGN_OP ENCOUNTERED" << endl; }
    | ASSIGN_OP         { out << "ASSIGN_OP ENCOUNTERED" << endl; }
    ;
    

empty:

%%
int main(int, char**) {
    // open a file handle to a particular file:
    FILE *myfile = fopen("test_program", "r");
    // make sure it's valid:
    
    yyin = myfile;
    
    out.open("bison_output.txt");
    do {
        yyparse();
    } while (!feof(yyin));
    
    out.close();

    cout << "Success" << endl;
}

void yyerror(const char *s) {
    cout << "Syntax error" << endl;
    exit(-1);
}