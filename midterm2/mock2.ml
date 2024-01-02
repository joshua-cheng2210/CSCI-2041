1.
Prove that: mirror (mirror x) = x
Write the non-recursive case (base case) here:

case x = int n

  mirror (mirror x) = x
= { case }
  mirror (mirror (int n)) = x
= { mir-i lemma }
  mirror (int n)
= { mir-i lemma }
  int n
= { case }
  x


mir-i         mirror (Int n) = (Int n)
mir-p         mirror (Plus (l,r))
                = Plus (mirror l, mirror r)

Write the inductive case here (specify the IH(s) and variables used
clearly):

Induction step    : let x = Plus (l, r)
{ IH }            : mirror (mirror x) = x

wrong: l and r cannot be assume to be int
  mirror (mirror x)
= { case }
  mirror (mirror (Plus (l, r)))
= { mir-p lemma }
  mirror (Plus (mirror l, mirror r))
= { mir-i lemma }
  mirror (Plus (l, r))
= { mir-p lemma }
  Plus (mirror l, mirror r)
= { mir-i lemma }
  Plus (l, r)
= { case }
  x

correct
  mirror (mirror x)
= { case }
  mirror (mirror (Plus (l, r)))
= { mir-p lemma }
  mirror (Plus (mirror l, mirror r))
= { mir-p lemma }
  Plus (mirror (mirror l), mirror ( mirror r))
= { IH }
  Plus (l, mirror ( mirror r))
= { IH }
  Plus (l, r)
= { case }
  x

2a

Prove that:
map (rev lst) = rev (map lst)
use induction on lst. Write the base case here.

case: let lst = []

  map (rev lst)
= { case }
  map (rev [])
= { rev-n }
  map ( [] )
= { map-n }
  []
= { reverse rev-n lemma }
  rev ( [] )
= { reverse map-n lemma }
  rev (map ( [] ))
= { case }
  rev (map ( lst ))


2b. proceed with the inductive case here:

inductive step    : let lst = ( h :: tl )
{ IH }            : map (rev tl) = rev (map tl)

  map (rev lst)
= { case }
  map (rev ( h :: tl )))
= { rev-t }
  map ( append (rev tl) (h::[]) )
= { helper }
  append (map (rev tl)) (map h) 
= { IH }
  append (rev (map tl)) (map h) 
= { map-t }
  append (rev (map tl)) (Inverse.inv h :: map []) 
= { map-n }
  append (rev (map tl)) (Inverse.inv h :: []) (* i only understood till here*)



= { rev-t } (* my answers*)
  append ( append (rev []) (map tl :: []) ) (Inverse.inv h :: []) 
= { rev-n }
  append ( append [] (map tl :: []) ) (Inverse.inv h :: []) 
= { ap-n }
  append (map tl) (Inverse.inv h) 
= { map-t }
  append ( Inverse.inv tl :: map [] ) (Inverse.inv h) 
= { map-n }
  append ( Inverse.inv tl ) (Inverse.inv h) 




= {rev-c} (*answer given*)
  rev (Inverse.inv h::map tl)
= {map-c}
  rev (map (h::tl))
= {case}
  rev (map lst)


  rev (map lst) (* doing from the other side*)
= { case }
  rev (map (h :: tl))
= { map-t }
  rev ( Inverse.inv h :: map tl )
= { map-t }
  rev ( Inverse.inv h :: ( Inverse.inv tl :: map [] ) )
= { map-n }
  rev ( Inverse.inv h :: ( Inverse.inv tl ) )
= { rev-t }
  append (rev map tl) (map h::[]) (* connected to the left side somehow*)










2c. Prove that the identity function on integers given by:
let id (x : int) : int = x
constitutes a valid instance for Involution. Write the instance and
prove any required properties.

module identity = struct
  type t = int
  let inc = id
end





rev-t       rev (h::tl) = append (rev tl) (h::[])
helper (map)  : map & append
map           : Inverse.inv & map
ap            : append
rev           : append & rev





