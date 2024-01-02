(* 
  Concatenates two integers x and y and returns a string that represents their sum.
  Example: plus 1 2 => "1 plus 2 is 3"
*)
let plus (x: int) (y: int) : string = 
  (string_of_int x) ^ " plus " ^ (string_of_int y) ^ " is " ^ (string_of_int (x + y))

(* 
  Helper function for generating a multiplication table for a number n.
  Starts from index i.
*)
let rec multHelper (i: int) (n: int) : int list = 
  if i > n then 
    []
  else 
    (i * n) :: multHelper (i + 1) n

(* 
  Generates a multiplication table for a number n.
  Returns a list of integers.
*)
let multTable (n : int) : int list =
  if n <= 0 then failwith "n should be greater than zero"
  else multHelper 1 n

(* 
  TODO for students: 
  Implement a function that multiplies two integers x and y and returns a string that represents their product.
  Example: multiply 2 3 => "2 multiplied by 3 is 6"
*)
let multiply (x: int) (y: int) : string =
  (string_of_int x) ^ " multiplied by " ^ (string_of_int y) ^ " is " ^ (string_of_int (x * y))

(* 
  TODO for students: 
  Implement a function that generates a multiplication table for a number n.
  Returns a list of strings.
*)
let multStringTable (n: int) : string list =
  if n <=0 then failwith "n should be greater than 0." else
  let rec multstringhelper (m: int) (x: int) = 
    if m > n then []
    else (multiply m x) :: multstringhelper (m+1) x
  in 
  multstringhelper 1 n

  (* failwith "TODO"   *)

(* 
  Bonus Question (just for fun): 
  Implement multHelper using tail recursion. 
  Tail recursion is beneficial for performance reasons.
*)
