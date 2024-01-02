%{
  open Ast
%}
%token SEMI
%token LCUR
%token RCUR
%token LPAREN
%token RPAREN
%token VAR
%token IF
%token ELSE
%token ASSIGN
%token <string> IDENT
%token <int> NUM
%token <string> STRING
%token EOF
%start main
%type <statement list> main
%type <statement> statement
%type <expression> expression
%%

main:
stmts = list(statement) ; EOF {stmts}

statement:
//variable declaration
| VAR ; var = IDENT ; ASSIGN ; expr = expression SEMI { Declaration (var, expr)}
//assignment
| var = IDENT ; ASSIGN ; expr = expression SEMI { Assignment (var, expr)}
// conditional
| IF ; LPAREN ; expr = expression ; RPAREN ; LCUR ; stmts1 = list(statement) ; RCUR ; 
    ELSE ; LCUR ; stmts2 = list(statement) ; RCUR { If_Else (expr, stmts1, stmts2)}

expression:
| LPAREN ; expr = expression ; RPAREN { expr }
| str = STRING { String str }
| var = IDENT { Identifier var }
| num = NUM { Number num }














