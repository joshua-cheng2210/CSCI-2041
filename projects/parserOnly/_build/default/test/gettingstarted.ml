

let (*prove*) cf_idempotent (h : int)
 = (cf (cf h) = cf h)
(*hint: axiom *)

let (*prove*) inv_involution (h : int)
 = (inv (inv h) = h)
(*hint: axiom *)

type list = (* To simplify parsing, each variant starts with | *)
  | Nil
  | Cons of (int * list)

type abc =
| defg
| hijk of (a) -> lmnop

match abc with
| defg
| hijk of (a) -> lmnop

match list with (* To simplify parsing, each variant starts with | *)
  | Nil
  | Cons of (int * list)

match l1 with
| Nil -> l2
| Cons ((h : int), (t : list)) -> Cons (h, append t l2)

let (*prove*) cf_inv_commute (h : int)
 = (cf (inv h) = inv (cf h))
(*hint: axiom *)

(* This should now be provable from the axioms: *)
let (*prove*) cf_inv_property (h : int)
 = (cf (inv (cf (inv h))) = cf h)
(* no hints! *)

(*testing for parsing functions calling*)

(* This  v=10       =20       = 30 *)
let cf_inv_property (h : int) =
 (cf (inv (cf (inv h))) = cf h)
(* no hints! *)

(* Output should read something like this:
Proof of cf_inv_property:
cf (inv (cf (inv h)))
= {lemma cf_inv_commute}
inv (cf (cf (inv h)))
= {lemma cf_idempotent}
inv (cf (inv h))
= {lemma cf_inv_commute}
inv (inv (cf h))
= {lemma inv_involution}
cf h
*)

(* This  v=10       =20       = 30 *)
let cf_inv_property (h : int) : string =
   (cf (inv (cf (inv h))) = cf h)
  (* no hints! *)



  