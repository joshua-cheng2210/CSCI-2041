let rec leftover_count (lst : int list) (x : int) : int = 
  match lst with
  | [] -> x
  | a :: b ->
    if x = 0 then
      leftover_count b (a-1)
    else 
      leftover_count b (x-1)

let rec last_card (lst : int list) (x : int) : int = 
  (* does x reset? cuz the third example reset and the other example did not reset *)
  match lst with
  | [] -> -1
  | a :: b -> 
    if x > 0 then
      last_card b (x-1)
    else
      let rec last_card_2 (lst : int list) (x : int) (last_val : int): int = 
        match lst with
        | [] -> last_val
        | a :: b ->
          if x = 0 then
            last_card_2 b (a-1) a
          else
            last_card_2 b (x-1) last_val
      in
      last_card_2 b (a-1) (a)

let rec num_greater_than_sum (lst : int list) : int = 
  let rec sum_helper (lst : int list) (counter : int) (sum : int) : int = 
    match lst, sum with
    | [], _ -> counter
    | (a :: b), x -> 
      if sum < a then
        sum_helper (b) (counter+1) (sum+a)
      else
        sum_helper b counter (sum+a)
  in
  sum_helper lst 0 0