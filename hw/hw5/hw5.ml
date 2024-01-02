type tree =
  | Leaf
  | Node of int * tree * tree


let with_default (a : int) (b : int option) : int =
  match (a,b) with 
  | a, None -> a
  | a, Some b -> b


module type Tree_ops_sig = 
sig
  val sum : tree -> int  
  val tmax : tree -> int option
  val flatten : tree -> int list
  val is_tree_sorted : tree -> bool
end

module Tree_ops :Tree_ops_sig =
struct 
  let rec sum t =
    match t with
    | Leaf -> 0
    | Node (a, b, c) -> a + sum b + sum c
                                      
  let rec tmax t =
    match t with
    | Leaf -> None
    | Node (a, b, c) -> 
      (* let (maxx, tree) =  *)
        let rec tmax_helper max t =
          match (max, t) with 
          | (max, Leaf) -> max
          | (max, Node (a, b, c)) ->
            if a > max then
              tmax_helper (tmax_helper a b) c
            else
              tmax_helper (tmax_helper max b) c
        in
        match (tmax_helper a t) with
        (* | None -> None *)
        | xx -> Some xx
      (* maxx *)
    (* failwith "TODO" *)
          
  let rec flatten t =
    let rec flatten_helper t lst =
      match t with
      | Leaf -> lst
      | Node (a, b, c) ->
        flatten_helper b (a :: flatten_helper c lst)
    in
    flatten_helper t []
                                            
  let rec is_tree_sorted t =
    let rec get_max (t : tree) (max : int) : int = 
      match (t, max) with
      | Leaf, max -> max
      | Node (x, l, r), max -> get_max r x
    in

    (* let rec get_min t max=  *)
    let rec get_min (t : tree) (min : int) : int = 
      match (t, min) with
      | Leaf, min -> min
      | Node (x, l, r), min -> get_min l x
    in    

    match t with
    | Leaf -> true
    | Node (x, l, r) ->
      if x > (get_min r x) || x < (get_max l x) then 
        false
      else
        (is_tree_sorted l) && (is_tree_sorted r)
end