let rec generate_duck_helper (x : int) (ori : int) : string list = 
  if x = 0 then
    ["Mama duck went swimming one day\n" ^
    "Over the hills and far away\n" ^
    "The mama duck said, \"Quack, quack, quack, quack\"\n" ^
    "And all " ^ (string_of_int ori) ^ " little ducks came back\n"]

  else if x = 1 then
    ("1 little duck went swimming one day\n" ^
    "Over the hills and far away\n" ^
    "The mama duck said, \"Quack, quack, quack, quack\"\n" ^
    "And then no more little ducks came back\n") :: (generate_duck_helper (x-1) (ori))

  else if x = 2 then
    ("2 little ducks went swimming one day\n" ^
    "Over the hills and far away\n" ^
    "The mama duck said, \"Quack, quack, quack, quack\"\n" ^
    "And only 1 little duck came back\n") :: (generate_duck_helper (x-1) (ori))

  else if x > 2 then
    ((string_of_int x) ^ " little ducks went swimming one day\n" ^
    "Over the hills and far away\n" ^
    "The mama duck said, \"Quack, quack, quack, quack\"\n" ^
    "And only " ^ (string_of_int (x-1)) ^ " little ducks came back\n") :: (generate_duck_helper (x-1) (ori))

  else
    []

let generate_duck_verse (n : int) : string =
  if n != 1 then
    String.concat "\n" (generate_duck_helper n n)
  else 
    "1 little duck went swimming one day\n" ^
    "Over the hills and far away\n" ^
    "The mama duck said, \"Quack, quack, quack, quack\"\n" ^
    "And then no more little ducks came back\n\n" ^
    "Mama duck went swimming one day\n" ^
    "Over the hills and far away\n" ^
    "The mama duck said, \"Quack, quack, quack, quack\"\n" ^
    "And all 1 little duck came back\n"

let print_duck_verse (n: int) : unit =  
  print_endline (generate_duck_verse n);

