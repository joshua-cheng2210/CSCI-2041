include Ast

module Parser = Parser
module Lexer = Lexer

let parse (s : string) : statement list =
  let lexbuf = Lexing.from_string s in
  let ast = Parser.main Lexer.token lexbuf in
     ast

let rec string_of_expression (e : expression) : string =
  match e with
  | Application (e, arg) ->
    (string_of_expression e) ^ " (" ^ string_of_expression arg ^ ")"
  | Identifier name -> name

let string_of_variants (e : expression) : string =
  match e with
  | Application (e, arg) ->
    "\n| " ^ (string_of_expression e) ^ " -> " ^ string_of_expression arg
  | Identifier name -> 
    "\n| " ^ name

let string_of_equality (e : equality) : string =
  match e with
  | Equality (e1, e2) -> "(" ^ (string_of_expression e1) ^ " = " ^ (string_of_expression e2) ^ ")"
  (* | Statement of  *)

let string_of_equality_option (e : equality option) : string =
  match e with
  | Some e1 -> string_of_equality e1
  | None -> ""
  
let string_of_typedvariable (TypedVariable (name, type_name) : typedVariable) : string =
  (* if type_name = "" then 
    name ^ " = \n"
  else  *)
    "(" ^ name ^ " : " ^ type_name ^ ")"

let string_of_word_options (xxx : word_options option) : string = 
  match xxx with
  | Some Axiom -> "\n(*hint: axiom *)"
  | Some Recursive -> "rec "
  | Some Colon -> ": "
  | Some (Induction x) -> "\n(*hint: induction " ^ string_of_expression (Identifier x) ^ " *)"
  | None -> ""

let string_of_output (output : typedVariable option) : string =
  match output with
  | Some (TypedVariable (name, type_name)) -> 
    if type_name = "" then 
      name 
    else 
      "(" ^ name ^ " : " ^ type_name ^ ")"
  | None -> ""

let string_of_statement (d : statement) : string =
  match d with
  | ProofDeclaration (name, args, equality, hint) ->
    let arg_strings = List.map string_of_typedvariable args in
    "let (*prove*) " ^ name ^ " " ^ (String.concat " " arg_strings) ^ " = "
     ^ string_of_equality equality ^ string_of_word_options hint
  | Function_call (recursive, function_name, args, colon, output, eq, induc) ->
    let arg_strings = List.map string_of_typedvariable args in
    "let " ^ string_of_word_options recursive ^ function_name ^ (String.concat " " arg_strings) ^ " " ^ string_of_word_options colon ^ string_of_output output ^ " =\n" ^ string_of_equality_option eq ^ string_of_word_options induc
  | Variant_type (variant_name, variants) ->
    let variant_list = List.map string_of_variants variants in
    "type " ^ variant_name ^ " = " ^ (String.concat " " variant_list)
  | Matching_type (matching_name, variants) ->
    let matching_list = List.map string_of_variants variants in
    "match " ^ string_of_expression matching_name ^ " with " ^ (String.concat " " matching_list)

