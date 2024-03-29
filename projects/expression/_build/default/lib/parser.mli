
(* The type of tokens. *)

type token = 
  | RPAREN
  | PROVE
  | LPAREN
  | LET
  | IDENT of (string)
  | EOF

(* This exception is raised by the monolithic API functions. *)

exception Error

(* The monolithic API. *)

val main: (Lexing.lexbuf -> token) -> Lexing.lexbuf -> (Ast.expression list)
