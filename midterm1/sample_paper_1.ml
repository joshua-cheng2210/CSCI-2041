(* let printing () = 
  print_string "hello world!";
in
printing;; *)

(* let () = print_endline "Hello world";;

let user_number_x = read_int (); *)

(* let greet greeting name
= greeting ^ " " ^ name ^ "!"
let greet_en = greet "Hello"
let greet_nl = greet "Hallo"
let with_jane greeter = greeter "Jane" *)

(* let greet_full = greet_en with_jane;; *)

(* let f a = a - 1 *)


(* let rec selfpair_each (lst: int list) : (int * int) list = 
match lst with
| [] -> []
| (h::tl) -> (h,h) :: selfpair_each tl

let rec selfpair_each lst = 
match lst with
| [] -> []
| (h::tl) -> (h,h) :: selfpair_each tl *)



(* lecture 3 - slide 33 - high order functions *)
(* 1) using match statements *)
(* let rec double_each lst = 
  match lst with
  | [] -> []
  | (h::tl) -> (2*h) :: double_each tl

let rec map f lst = 
  match lst with 
  | [] -> []
  | (h::tl) -> f h :: map f tl

(* 2) using let *)
let rec double_each lst = 
  (let f h = 
    2*h
  in map f lst)

let rec map f lst = 
match lst with 
| [] -> []
| (h::tl) -> 
    f h :: map f tl

3) using function
let rec double_each lst = map (fun h -> 2*h) lst

4) using List.map
let rec double_each lst =
  List.map (fun h -> 2*h) lst *)

(* type 'a tree = 
| Node of 'a tree * 'a tree
| Leaf of 'a

let rec sum_tree = 
function
| Leaf x -> x
| Node (l, r)
  -> sum_tree l + sum_tree r *)






(* let ap f a b = 
  match a with 
  | None -> None 
  | Some y -> f y b  *)
(* val ap : ('a -> 'b -> 'c option) -> 'a option -> 'b -> 'c option = <fun> *)

(* let rec hop = function 
| [] -> (0, 1) 
| h :: tl -> 
  let (a,b) = hop tl in (a + b, h) *)

  (* val hop : int list -> int * int = <fun> *)

(* let v=(let add1 x = x + 1 in 
(fun x f -> 
f (f x)) 3 add1) 
   *)


(* q2a *)

type cone = Kids | Medium | Deluxe 
type softserve = Vanilla | Chocolate | Swirl 
type icecream = Icecream of cone * int * softserve 

let isOK (ice : icecream) : bool =
  match ice with
  | Icecream (Kids, 8, _) -> true
  | Icecream (Medium, 8, _) -> true
  | Icecream (Medium, 15, _) -> true
  | Icecream (Medium, 20, _) -> true
  | Icecream (Deluxe, 15, _) -> true
  | Icecream (Deluxe, 20, _) -> true
  | _ -> false

let makeVanilla (ice : icecream) : icecream = 
  match ice with
  | Icecream (a, b, _) -> Icecream (a, b, Vanilla)

(* let rec removeNth (lst : 'a list) (index : int) : 'a list =
  let rec removeNth_helper (lst : 'a list) (index : int) (curr : int): 'a list =
    match (curr, lst) with
    | (_, []) -> []
    | (a, x :: y) -> 
      if a = index then 
        y
      else
        removeNth_helper y index a+1
  in
  removeNth_helper lst index 0 *)




let rec removeNth lst index =
  match lst with
  | [] -> []
  | x :: y -> 
    if index = 0 then
      y
    else
      x :: removeNth y (index-1)

(* let rec removeNth lst i = 
  match lst with
  | [] -> []
  | h::tl -> 
    if i = 0 then 
      tl 
    else 
      h::removeNth tl (i-1) *)

(* let get_next_index (lst : int list) : int = 
  match lst with
  | [] -> []
  | x :: y -> 
    match y with
    | [] -> [] *)

(* let rec findDifference (lst : int list) : (int * int) = 
  let rec findDifference_helper (lst : int list) (out : int * int) (max_diff : int): (int * int) = 
    match (lst, out, max_diff) with
    | ([], out, _) -> out
    | (x :: ([]), out, _) -> out
    | (x :: y :: z, out, diff) ->
        (* let curr_diff = abs (y-x) in *)

        let curr_diff =
          if y-x < 0 then
            x-y
          else
            y-x
        in

        if curr_diff > diff then
          findDifference_helper (y::z) (x,y) curr_diff
        else
          findDifference_helper (y::z) out diff
  in
  findDifference_helper lst (0,0) 0 *)

let rec findDifference lst = 
  match lst with
  | [a;b] -> (a,b)
  | h1::h2::tl -> 
    let (x,y) = 
      findDifference (h2::tl) in
      if (y - x) > (h2 - h1) then 
        (x,y) 
      else 
        (h1,h2)