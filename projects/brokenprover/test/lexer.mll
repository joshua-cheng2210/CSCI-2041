{
 open Parser
 exception SyntaxError of string
}

let newline = '\r' | '\n' | "\r\n"

rule token = parse
 | [' ' '\t'] { token lexbuf }
 | newline { Lexing.new_line lexbuf;token lexbuf }
 | "(*prove*)" { PROVE }
 | "(*hint:" { HINT }
 | "(*" { comment 0 lexbuf }
 | "*)" { ENDCOMMENT }
 | "=" { EQUAL }
 | "*" { STAR }
 | "," { COMMA }
 | "->" { ARROW }
 | ":" { COLON }
 | "(" { LPAREN }
 | "|" { ORSIGN }
 | ")" { RPAREN }
 | "let" {LET}
 | "rec" {RECURSIVE}
 | "match" {MATCH}
 | "with" {WITH}
 | "type" {TYPE}
 | "axiom" { AXIOM }
 | "induction" {INDUCTION}
 | ['a'-'z' 'A'-'Z' '0'-'9' '?' '_' '\'' '*']+ as id { IDENT id }
 | _ { raise (SyntaxError ("Unexpected char: " ^ Lexing.lexeme lexbuf)) }
 | eof { EOF }

and comment level = parse
 | "*)" { if level = 0 then token lexbuf else comment (level - 1) lexbuf }
 | "(*" { comment (level + 1) lexbuf }
 | newline { Lexing.new_line lexbuf;comment level lexbuf }
 | _ { comment level lexbuf }
 | eof { raise (SyntaxError "Unclosed comment") }
