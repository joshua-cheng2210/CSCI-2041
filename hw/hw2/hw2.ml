(* data structure *)
type exercise = 
| Int of int
| Mult of exercise * int
| Plus of exercise * int

let exercise_one = (Mult (Plus (Plus (Mult (Int 3, 15), 0), 2), 1))
let exercise_two = Mult (Plus (Mult (Plus (Int 0, 4), 1), 0), 6)
let exercise_three = (Int 64)

(* get the answer *)
let rec solution (prob : exercise) :  int =
	match prob with
	| Int i -> i
	| Mult (ex, n) -> n * solution ex
	| Plus (ex, n) -> n + solution ex
	(* raise (Failure "This function is not implemented") *)

	(* type the question in a string format *)
let rec string_of_exercise (prob : exercise) : string =
	match prob with
	| Int i -> string_of_int i
	| Mult (ex, num) -> string_of_exercise ex ^ " * " ^ string_of_int num  ^ " -> ... "
	| Plus (ex, num) -> string_of_exercise ex ^ " + " ^ string_of_int num  ^ " -> ... " 
	(* raise (Failure "This function is not implemented") *)

let rec string_of_solution (prob : exercise) : string =
	match prob with
	| Int i -> string_of_int i
	| Mult (ex, num) -> string_of_solution ex ^ " * " ^ string_of_int num ^ " -> " ^ string_of_int (num * solution ex)
	| Plus (ex, num) -> string_of_solution ex ^ " + " ^ string_of_int num ^ " -> " ^ string_of_int (num + solution ex)


let rec from_random (nums : int list) (signs : bool list) : exercise =
	if List.length nums - List.length signs != 1 then
		Int 0
	else
		match (nums, signs) with
		| [], _ -> Int 0
		| num :: nums, sign :: signs ->
			if sign then
				Mult (from_random nums signs, num)
			else
				Plus (from_random nums signs, num)
		| [num], [] -> Int num
		| _, _ -> Int 0
 
let rec filterNonTrivial (prob : exercise) : exercise =
	match prob with
	|Int i -> Int i
	|Plus(ex, 0) -> filterNonTrivial(ex)
	|Mult(ex, 1) -> filterNonTrivial(ex)
	|Plus(Int 0, ex) -> filterNonTrivial(Int ex)
	|Mult(Int 1, ex) -> filterNonTrivial(Int ex)
	|Plus(ex, n) -> Plus(filterNonTrivial(ex), n)
	|Mult(ex, n) -> Mult(filterNonTrivial(ex), n)
	

(* let rec splitOnMultZero (prob : exercise) : (exercise * exercise) option =
	match prob with
	(* | Mult (Int 0, _) -> Some (Int 0, prob) *)
	| Mult (_, Int 0) -> Some (prob, Int 0)
	| Mult (a, b) ->
		(match splitOnMultZero a, splitOnMultZero b with
		| Some (leftA, rightA), Some (leftB, rightB) ->
			Some (Mult (leftA, leftB), Mult (rightA, rightB))
		| _, _ -> None)
	| Plus (a, b) ->
		match splitOnMultZero a with
		| Some (left, right) -> Some (left, Plus (right, b))
		| _ -> None
	| _ -> None *)
	
let rec splitOnMultZero (prob : exercise) : (exercise * exercise) option =
	match prob with
	| Int i -> None
	| Mult(a, 0) -> Some (a, Int 0)
	| Plus(a, b) -> 
		(match (splitOnMultZero a) with
		| Some (c, d) -> Some (c, Plus(d, b))
		| None -> None
		)
	| Mult(a, b) -> 
		(match (splitOnMultZero a) with
		| Some (c, d) -> Some (c, Mult(d, b))
		| None -> None
		)
  

let rec keepSplitting (prob : exercise) : exercise list =
	match splitOnMultZero prob with
	| Some (a, b) -> keepSplitting a @ [b]
	| None -> [prob]

let rec printExercise (probs : exercise list) : unit =
  match probs with
  | h :: tl -> print_string ((string_of_exercise h)^"\n"^(string_of_solution h)^"\n\n"); printExercise tl
  | [] -> ()

let rec genProblems (nums : int list) (signs : bool list) : unit =
  (printExercise (keepSplitting (filterNonTrivial (from_random nums signs))))
