include Ast

module Parser = Parser
module Lexer = Lexer

let parse (s: string) : statement list = 
  let lexbuf = Lexing.from_string s in 
  let ast = Parser.main Lexer.token lexbuf in 
    ast

let string_of_expression : expression -> string = function 
  | Identifier v -> v
  | Number n -> string_of_int n
  | String str -> "\"" ^ str ^ "\""

let rec string_of_Statements ntabs (es : statement list) : string =
  List.fold_left (fun i x -> i ^ string_of_statement ntabs x ^ "\n") "" es

and string_of_statement (ntabs : int) : statement -> string =
  let rec repi i f acc = 
    if i <= 0 then acc else repi (i-1) f (f acc)
  in let tabs = repi ntabs (fun x -> x ^ "\t") ""
  in function 
  | Declaration (var, expr) -> tabs ^ "var " ^ var ^ " = " ^ string_of_expression expr
  | Assignment (var, expr) -> tabs ^ var ^ " = " ^ string_of_expression expr 
  | If_Else (expr, thenS, elseS) -> 
    tabs ^ "if (" ^ string_of_expression expr ^ ") {\n" ^
    string_of_Statements (ntabs+1) thenS ^
    tabs ^ "} else\n" ^
    string_of_Statements (ntabs+1) elseS ^ tabs ^ "}"

(* this function needs to be inputed with statement and not statement list *)
let string_of_program (es : statement list) : string =
  string_of_Statements 0 es

(* let string_of_program (s : string) : string =
  string_of_Statements 0 (parse s) *)
  
