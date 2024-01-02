match list with (* To simplify parsing, each variant starts with | *)
  | Nil
  | Cons of (int * list)

match l1 with
| Nil -> l2
| Cons ((h : int), (t : list)) -> Cons (h, append t l2)

  (*hint: induction l1 *)
(*testing for parsing functions calling*)
