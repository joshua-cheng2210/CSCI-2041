(* let ap f a b = 
  match a with 
  | None -> (None, b+1) 
  | Some y -> (Some ((f y) y),b)
val ap : ('a -> 'a -> 'b) -> 'a option -> int -> 'b option * int = <fun> *)

(* let rec bop f h = 
  f (bop f (h - 1))
val bop : ('a -> 'a) -> int -> 'a = <fun> *)

(* let v = (let id = (fun x -> x) in (id id))  *)

(* q2 *)

type flavor = Vanilla | Strawberry | Chocolate 
type topping = Sprinkles of int | Gummies of int 
type icecream = Icecream of flavor * int * (topping list) 

let rec countScoops = function
  | 1 | 2 | 3 -> true
  | _ -> false

let rec hasDuplicateToppings toppings =
  match toppings with
  | [] -> false
  | hd :: tl ->
    if List.mem hd tl then
      true
    else
      hasDuplicateToppings tl

let isOK (ice : icecream) : bool =
  match ice with
  | Icecream (_, scoops, toppings) ->
    countScoops scoops && not (hasDuplicateToppings toppings)


let computeCost (ice : icecream) : float =
  match ice with
  | Icecream (flavour, num_scoops, topping_list) ->
    let scoops_cost = 
      match num_scoops with
      | 1 -> 3.50
      | 2 -> 4.50
      | 3 -> 5.50
      | _ -> 0.00
    in

    let topping_cost = 
      List.fold_left(
        fun acc lst ->
        match lst with
        | Gummies num ->
          if num >= 10 then
            acc +. 2.00
          else
            acc
        | Sprinkles num ->
          if num >= 3 then
            acc +. 2.00
          else
            acc
        (* | _ -> acc *)
      ) 0.00 topping_list
    in
    scoops_cost +. topping_cost
  

let rec mapi f lst counter = 
  if counter = 0 || lst = [] then
    lst
  else if counter = 0 then 
    lst
  else
    match lst with
    | [] -> []
    | x :: y -> 
      f x :: mapi f y (counter-1)
    
let rec computeUnary (lst : int list) : (unit list) list =
  match lst with
  | [] -> []
  | x :: y ->

    let rec make_inner_lst (num : int) : unit list = 
      if num <= 0 then
        [] 
      else
        match num with
        | a -> () :: make_inner_lst (a-1)
    in

    make_inner_lst x :: computeUnary y

      
    


