type statement = 
  | Declaration of ident * expression
  | Assignment of ident * expression
  | If_Else of expression * statement list * statement list

and expression = 
  | Number of int
  | String of string
  | Identifier of ident

and ident = string