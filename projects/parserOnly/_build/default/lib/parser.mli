
(* The type of tokens. *)

type token = 
  | WITH
  | TYPE
  | STAR
  | RPAREN
  | RECURSIVE
  | PROVE
  | ORSIGN
  | MATCH
  | LPAREN
  | LET
  | INDUCTION
  | IDENT of (string)
  | HINT
  | EQUAL
  | EOF
  | ENDCOMMENT
  | COMMA
  | COLON
  | AXIOM
  | ARROW

(* This exception is raised by the monolithic API functions. *)

exception Error

(* The monolithic API. *)

val main: (Lexing.lexbuf -> token) -> Lexing.lexbuf -> (Ast.statement list)
