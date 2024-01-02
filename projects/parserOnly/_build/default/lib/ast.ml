type typevariant = Variant of (string * string list)
type typedVariable = TypedVariable of (string * string)

type expression =
  | Application of (expression * expression)
  | Identifier of string
  (* | TypedVariable *)


type equality =
| Equality of (expression * expression)
(* | Statement of Matching_type of (expression * expression list) *)

type word_options = 
| Axiom
| Recursive
| Colon
| Induction of string

type statement = 
| ProofDeclaration of (string * typedVariable list * equality * word_options option)
(* | Function_call_with_only_match_statements of (word_options option * string * typedVariable list * word_options option * typedVariable option * equality) *)
| Function_call of (word_options option * string * typedVariable list * word_options option * typedVariable option * equality option * word_options option)
| Variant_type of (string * expression list)
| Matching_type of (expression * expression list)

