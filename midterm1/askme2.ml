type topping = A | B

topping -> bool
let hasDuplicates (lst : topping list) : bool = 
match lst with
| [] -> false
| [a] -> false| [A _]



let rec makeUnary (i : int) = 
  if i <= 0 then []
  else
    () :: makeUnary (i-1)

('a->'a->'b)->'a option-> int -> 'b option*int
let ap f a b = match a with None -> (None, b+1)
| Some y ->
  (Some((f y) y), b)

int->int->int list list
let countTO i n =
  (let rec countUp j = 
    if j = n then
      []
    else
      j :: countUp (j+1))