let leftover_count (lst : int list) (x : int) : int = 
  List.fold_left (
    fun acc num ->
      if acc = 0 then 
        (num-1) 
      else 
        (acc-1)
  ) x lst

let last_card (lst : int list) (x : int) : int = 
  let (a, b, c) = List.fold_left (
    fun acc num -> 
      match acc with
      | (counter, -1, false) ->
        if counter = 0 then
          (num-1, num, true)
        else
          (counter-1, -1, false)
      | (counter, last_card, true) ->
        if counter=0 then
          ((num-1), num, true)
        else
          (counter-1, last_card, true)
  ) (x, -1, false) lst
  in
  b
  
let num_greater_than_sum (lst : int list) : int = 
  let (a, b) = List.fold_left (
    fun acc num ->
      match acc with
      | (counter, sum) ->
        if (num > sum ) then
          (counter+1, sum+num)
        else
          (counter, sum+num)
  ) (0, 0) lst
  in
  a