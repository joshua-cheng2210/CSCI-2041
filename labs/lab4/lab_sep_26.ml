(* Example *)
let parenthesis_check_rec (lst: string list) : int option =
	let rec helper lst accu = 
		match lst with
		| [] -> accu
		| h :: t -> helper t (
			match h, accu with 
			| ")", Some x -> if (x - 1) < 0 then 
                None 
            else 
                Some (x - 1)
			| "(", Some x -> 
                Some (x + 1)
			| _, y -> y
		)
	in
	helper lst (Some 0)

(* Example *)
let parenthesis_check_fold (lst: string list) : int option =
	List.fold_left (
		fun accu h -> 
			match h, accu with 
			| ")", Some x -> if (x - 1) < 0 then None else Some (x - 1)
			| "(", Some x -> Some (x + 1)
			| _, y -> y
		) (Some 0) lst

let rec remove_not_marco_polo (lst: string list) : string list = 
    match lst with
    | str :: strs ->
        if str = "marco" || str = "polo" then
            str :: remove_not_marco_polo strs
        else 
            remove_not_marco_polo strs
    | [] ->
        []

let rec marco_polo_rec (lst: string list) : bool option =
    let lst = remove_not_marco_polo lst in
    match lst with
    | [] -> 
        Some(false)
    | str1 :: str ->
        if str1 = "polo" then
            None
        else if str1 = "marco" && str = [] then
            Some(true)
        (* else if str1 = "marco" && str2 = "polo" && str = [] then *)
            (* Some(false) *)
        else
            match str with
            | str2 :: str3 ->
                if str1 = str2 then
                    None
                else if str1 = "marco" && str2 = "polo" && str = [] then
                    Some(false)
                else
                    marco_polo_rec str3
  
let marco_polo_fold (lst: string list) : bool option =
    List.fold_left (
        fun acc lst ->
            match acc, lst with
            | Some false , "marco" -> Some true
            | Some true , "polo" -> Some false
            | Some false , "polo" -> None
            | Some true , "marco" -> None
            | x, _ -> x
            (* | Some(true), [] -> Some true
            | Some(false), [] -> Some false
            | Some(true), _ -> Some true
            | Some(false), _ -> Some false *)
    ) (Some false)  lst
	(* raise (Failure "TODO") *)

(* TODO *)
let combine_fold (lst: string list) : int option * bool option = 
	List.fold_left(
        fun acc lst -> 
            match acc, lst with 
			| (Some x, aaa), ")" -> 
                if (x - 1) < 0 then 
                    (None, aaa) 
                else 
                    ((Some (x - 1)), aaa)
			| (Some x, aaa), "(" -> 
                ((Some (x + 1)), aaa)

            | (bbb, Some false) , "marco" -> (bbb, Some true)
            | (bbb, Some true) , "polo" -> (bbb, Some false)
            | (bbb, Some false) , "polo" -> (bbb, None)
            | (bbb, Some true) , "marco" -> (bbb, None)

			| y, _ -> y

    ) (Some 0, Some false) lst
	(* raise (Failure "TODO") *)


(* TODO *)
let combine_rec (lst: string list) : int option * bool option = 
    (parenthesis_check_rec lst, marco_polo_fold lst)
	(* raise (Failure "TODO") *)

(* Tests for marco_polo_rec *)
let test_marco_polo_rec () =
    assert (marco_polo_rec ["marco"; "polo"; "marco"; "polo"] = Some false);
    assert (marco_polo_rec ["marco"; "marco"] = None);
    assert (marco_polo_rec ["polo"; "polo"] = None);
    print_endline "All tests for marco_polo_rec passed!"

(* Tests for marco_polo_fold *)
let test_marco_polo_fold () =
    assert (marco_polo_fold ["marco"; "polo"; "marco"; "polo"] = Some false);
    assert (marco_polo_fold ["marco"; "marco"] = None);
    assert (marco_polo_fold ["polo"; "polo"] = None);
    print_endline "All tests for marco_polo_fold passed!"

(* Tests for combine_fold *)
(* Tests for combine_fold *)
let test_combine_fold () =
    assert (combine_fold ["("; ")"; "marco"; "polo"] = (Some 0, Some false));
    assert (combine_fold [")"; ")"; "marco"; "marco"] = (None, None));
    assert (combine_fold ["("; "("; "polo"; "polo"] = (Some 2, None));
    assert (combine_fold ["("; ""; ")"] = (Some 0, Some false));
    print_endline "All tests for combine_fold passed!"

(* Tests for combine_rec *)
let test_combine_rec () =
    assert (combine_fold ["("; ")"; "marco"; "polo"] = (Some 0, Some false));
    assert (combine_fold [")"; ")"; "marco"; "marco"] = (None, None));
    assert (combine_fold ["("; "("; "polo"; "polo"] = (Some 2, None));
    assert (combine_fold ["("; ""; ")"] = (Some 0, Some false));
    print_endline "All tests for combine_rec passed!"

(* Run all tests *)
let run_all_tests () =
    test_marco_polo_rec ();
    test_marco_polo_fold ();
    test_combine_fold ();
    test_combine_rec ();
    print_endline "All tests passed!"

(* UNCOMMENT THE BELOW LINE TO RUN TESTS *)
(*
let _ = run_all_tests ()
*)
