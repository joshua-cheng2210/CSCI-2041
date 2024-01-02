%{
  open Ast
%}
%token <string> IDENT
%token COLON
%token LPAREN
%token RPAREN
%token PROVE
%token LET
%token RECURSIVE
%token TYPE
%token STAR
%token EQUAL
%token EOF
%token ARROW
%token HINT
%token ORSIGN
%token INDUCTION
%token MATCH
%token WITH
%token COMMA
%token ENDCOMMENT /* there is no startcomment, as it's called "hint", and proper comments are ignored by the lexer */
%token AXIOM
%start main
%type <statement list> main
%%

main:
| list(statement) EOF { $1 }
statement:
| LET ; PROVE ; lemma_name=IDENT ; args = list(argument) ; EQUAL ; eq = equality ; hint=option(word_options) 
   { ProofDeclaration (lemma_name, args, eq, hint) }
| LET; recursive=option(word_options) ; function_name=IDENT ; args = list(argument) ; colon=option(word_options) ; output=option(argument) ; EQUAL ; eq = option(equality) ; induction_hint=option(word_options)
   { Function_call (recursive, function_name, args, colon, output, eq, induction_hint) }
| TYPE ; variant_name=IDENT ; EQUAL ; variants=list(variant_stuffs)
   { Variant_type (variant_name, variants) }
| MATCH ; e = expression ; WITH ; variants = list(variant_stuffs)
   { Matching_type (e, variants) }

word_options:
| RECURSIVE { Recursive }
| COLON { Colon }
| HINT ; AXIOM ; ENDCOMMENT { Axiom }
| HINT ; INDUCTION ; nm=IDENT ; ENDCOMMENT { Induction ( nm) }

variant_stuffs:
| ORSIGN ; e1 = expression ; ARROW ; e2 = expression { Application (e1, e2)}
| ORSIGN ; ee = expression { ee }
// | ORSIGN ; x=IDENT ; arg = list(argument) ; ARROW

argument:
| nm = IDENT { TypedVariable (nm, "") }
| nm = IDENT; COLON; t = IDENT { TypedVariable (nm, t) }
| LPAREN ; arg = argument; RPAREN ; COMMA { arg }
| LPAREN ; arg = argument; RPAREN { arg }
equality:
| LPAREN ; e = equality ; RPAREN { e }
| lhs = expression ; EQUAL ; rhs = expression { Equality (lhs, rhs) }

expression:
| LPAREN ; e = expression_with_commas ; RPAREN { e }
| lhs = expression ; arg = IDENT { Application (lhs, Identifier arg) }
| lhs = expression ; LPAREN ; arg = expression_with_commas ; RPAREN
   { Application (lhs, arg) }
| LPAREN ; e1 = expression ; COLON ; e2 = expression ; RPAREN 
  { Application (Application (e1 , Identifier ":"), e2)}
| nm = IDENT { Identifier nm }

// these aren't in the gettingstarted.ml syntax,
// but here's a suggestion to deal with these anyways.
// We're using that "," is not a valid identifier
// We're using it as an identifier that stands for the function (fun x y -> (x, y))
// This also means we're representing (x,y,z) and ((x,y),z) as the same thing.
expression_with_commas:
| e = expression { e }
| e1 = expression_with_commas ; COMMA ; e2 = expression
  { Application (Application (e1 , Identifier ","), e2)}
| e1 = expression_with_commas ; STAR ; e2 = expression
  { Application (Application (e1, Identifier "*"), e2)}