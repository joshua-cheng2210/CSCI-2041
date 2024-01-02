{
    open Parser
    exception SyntaxError of string
}

let newline = '\r' | '\n' | "\r\n"

rule token = parse
    | [' ' '\t'] { token lexbuf }
    | newline { Lexing.new_line lexbuf; token lexbuf }
    | "//" { line_comment lexbuf }
    | ";" { SEMI }
    | "{" {LCUR}
    | "}" {RCUR}
    | "(" {LPAREN}
    | ")" {RPAREN}
    | "=" {ASSIGN}
    | "\"" {stringParse lexbuf}
    | "var" {VAR}
    | "if" {IF}
    | "else" {ELSE}
    | ['a'-'z' 'A'-'Z']+ as id { IDENT id }
    | ['0'-'9']+ as n { NUM (int_of_string n) }
    | _ { raise (SyntaxError ("Unexpected char: " ^ Lexing.lexeme lexbuf))}
    | eof {EOF}

and stringParse = parse
    | (['a'-'z' 'A'-'Z' '0'-'9']* as str) "\"" {STRING str}

and line_comment = parse
| newline {Lexing.new_line lexbuf; token lexbuf}
| _ { line_comment lexbuf }
| eof {EOF}

