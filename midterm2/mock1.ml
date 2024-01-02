let rec append lst1 lst2 = 
  match lst1 with
  | [] -> lst2
  | hd::tl -> hd :: append tl lst2

let rec contains x lst =
  match lst with
  | [] -> false
  | hd::tl -> 
    if hd = x then true
    else 
      contains x tl

let or a b = if a then true else b

ap-nil    append [] lst2 = lst2
ap-c      append (hd::tl) lst2 = hd :: append lst2
or-t      or true b = true
or-f      or false b = b
cts-n     contains x [] = false
cts-c     contains x (hd::tl)
            = if hd = x then true else contains x tl
ite-t     (if true then a else b) = a
ite-f     (if false then a else b) = b


1a. Prove that: or x y = or y x

case: x = false, y = false

  or x y
= { case }
  or false false
= { or-f lemma }
  false
= { reverse or-f lemma }
  or false false
= { case }
  or y x


  or y x
= { case }
  or false false
= { or-f lemma }
  false
= { case }
  y

case x = true, y = false

  or x y
= { case }
  or true false
= { or-t lemma }
  true
= { or-f lemma }
  or false true
= { case }
  or y x

case x = false, y = true

  or x y
= { case }
  or false true
= { or-f lemma }
  true
= { or-t lemma }
  or true false
= { case }
  or y x

case x = true, y = true

  or x y
= { case }
  or true true
= { or-f lemma }
  true
= { or-t lemma }
  or true true
= { case }
  or y x

let this be lemma 1a

Prove that:
or (contains x lst1) (contains x lst2) = (contains x (append lst1 lst2))
use induction on lst1.

1b. Write the case for [] on this page:

case: for any lst2, let lst1 = [] 

  or (contains x lst1) (contains x lst2)
= { case }
  or (contains x []) (contains x lst2)
= { cts-n lemma }
  or false (contains x lst2)
= { or-f lemma }
  (contains x lst2)
= ( ap-nil )
  (contains x (append [] lst2))
= { case }
  (contains x (append lst1 lst2))



(* unnecessary *)
case: for any lst1, let lst2 = []

  or (contains x lst1) (contains x lst2)
= { case }
  or (contains x lst1) (contains x [])
= { cts-n lemma }
  or (contains x lst1) false
= { using lemma on 1a }
  or false (contains x lst1)
= { or-f lemma }
  (contains x lst1)
= { ap-nil }
  (contains x (append [] lst1))
= { apply append_associativity }
  (contains x (append lst1 []))
= { case }
  (contains x (append lst1 lst2))
  
  
lemma append_associativity
  prove : append [] a = append a []

case: given for any a
  
  append [] a
= { case }
  append [] a
= { ap-nil }
  a
= { reverse match }
  let rec append lst1 lst2 = 
    match [] with
      | [] -> lst2
      | hd::tl -> hd :: append tl lst2
= { reverse append def }
  a :: append [] []
= { after iterating through entire a, a = [] }
  hd :: append tl []
= { reverse match }
  let rec append lst1 lst2 = 
    match a with
    | [] -> lst2
    | hd::tl -> hd :: append tl lst2
= { reverse append def }
  append a []


  append a []
= { case }
  append a []
= { append def }
  let rec append lst1 lst2 = 
    match a with
    | [] -> lst2
    | hd::tl -> hd :: append tl lst2
= { apply match }
  hd :: append tl []
= { after iterating through entire a, a = [] }
  a :: append [] []
= { append def }
  let rec append lst1 lst2 = 
  match [] with
    | [] -> lst2
    | hd::tl -> hd :: append tl lst2
= { apply match }
  a :: []
  




1c. Write the inductive case on this page. Be sure to clearly write  your inductive hypothesis:

induction step: for any lst2, let lst1 = hd :: tl and also lst1 contain x, thus, contains x lst1 == true
{ IH }: or (contains x lst1) (contains x lst2) = (contains x (append lst1 lst2))

  or (contains x lst1) (contains x lst2)
= { case }
  or (contains x (hd :: tl)) (contains x lst2)
= { cts-c }
  or (if hd = x then true else contains x tl) (contains x lst2)






  (contains x (append lst1 lst2))
= { case }
  (contains x (append ( hd :: tl ) lst2))
= { ap-c }
  (contains x (hd :: append lst2))


______________________________________________________________________________________
  ap-nil    append [] lst2 = lst2
  ap-c      append (hd::tl) lst2 = hd :: append tl lst2
  or-t      or true b = true
  or-f      or false b = b
  cts-n     contains x [] = false
  cts-c     contains x (hd::tl)
              = if hd = x then true else contains x tl
  ite-t     (if true then a else b) = a
  ite-f     (if false then a else b) = b

1c: answers
or (contains x lst1) (contains x lst2) = (contains x (append lst1 lst2))

case: lst1 = h::tl

IH : or (contains x tl) (contains x lst2) = contains x (append tl lst2)
proof of lemma, case (h = x) = true

or (if h = x then true else contains x tl) (contains x lst2)
= {case}
or (if true then true else contains x tl) (contains x lst2)
= {ite-t}
or true (contains x lst2)
= {or-t}
true
= {or-t}
(if true then true else contains x (append tl lst2))
= {case}
if h = x then true else contains x (append tl lst2)



proof of lemma, case (h = x) = false
or (if h = x then true else contains x tl) (contains x lst2)
= {case}
or (if false then true else contains x tl) (contains x lst2)
= {ite-f}
or (contains x tl) (contains x lst2)


contains x (append lst1 lst2)
= { cns-c }
contains x (h :: append tl lst2 ) 

contains x (append tl lst2 ) (*start from here*)





= {IH}
contains x (append tl lst2)
= {or-f}
if false then true else contains x (append tl lst2)
= {case}
if h = x then true else contains x (append tl lst2)






q2a) 

Prove that Converse(L).union2 (referred to as union2 from here) satisfies the property:

or (elem e a) (elem e b) = elem e (union2 a b)




elem e (union2 a b)
= { union2 def }
elem e (L.union b a)
= {given}
or (elem e b) (elem e a)
= {ex 1}
or (elem e a) (elem e b)



q2b)
elem e a = elem e (foo a)

elem e (foo a)
= { foo def }
elem e (L.union a a)





























2. Functors (20 + 20)  
Consider the following module type with comments: 
module type lattice = sig 
 type 'a t 
 elem : 'a -> 'a t -> bool 
 (** must satisfy: 
 [ or (elem e a) (elem e b)  
 = elem e (union a b) ] **) 
 union : 'a t -> 'a t -> 'a t  end 
(Note that ‘'a list’, ‘contains’ and ‘append’, forms an example  instance of this signature.) 
Consider this functor: 
module Converse (L : lattice) = struct  type 'a t = 'a L.t 
 let elem = L.elem 
 let union2 x y 
 = L.union y x 
 let foo x 
 = L.union x x 
end 
You will be asked to prove a property about union2 and one about  foo. Assume L is a module that satisfies the properties as specified  in the signature lattice. 
You may use the rules about or from the previous exercise,  including that or x y = or y x (even if you failed to prove it).
2a. Prove that Converse(L).union2 (referred to as union2 from here)  satisfies the property: 
or (elem e a) (elem e b)  
 = elem e (union2 a b)
2a. Prove that Converse(L).foo (referred to as foo from here)  satisfies the property: 
elem e a = elem e (foo a)