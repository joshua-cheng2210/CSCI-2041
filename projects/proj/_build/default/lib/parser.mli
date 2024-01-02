
(* The type of tokens. *)

type token = 
  | VAR
  | STRING of (string)
  | SEMI
  | RPAREN
  | RCUR
  | NUM of (int)
  | LPAREN
  | LCUR
  | IF
  | IDENT of (string)
  | EOF
  | ELSE
  | ASSIGN

(* This exception is raised by the monolithic API functions. *)

exception Error

(* The monolithic API. *)

val main: (Lexing.lexbuf -> token) -> Lexing.lexbuf -> (Ast.statement list)
