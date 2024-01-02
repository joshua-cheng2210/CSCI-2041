# Code definitions:

```ocaml
let ( >>= ) o (f: ('a -> 'a option)) =
    match o with
    | None -> None
    | Some y -> f y

let return x = Some x
```

# Example Proof:

```
Prove:
	x >>= return = x, for (x: 'a option)

By cases on (x: 'a option):

Case x = None:

	x >>= return
= { case }
	None >>= return
= { bind def }
	match None with
	| None -> None
	| Some a -> return a
= { apply match }
	None
= { case }
	x

Case x = Some y:

	x >>= return
= { case }
	Some y >>= return
= { bind def }
	match Some y with
	| None -> None
	| Some a -> return a
= { apply match }
	return a
= { return def }
	Some a
= { case }
	x

We have proven the statement for all possible values of x, so the statement is true, namely x >>= return = x for any (x: 'a option)
```

# Problem 1

```
Prove:
	(x >>= g) >>= h = x >>= (fun y -> g y >>= h), for (x: 'a option)
```

Case x = None:

	(x >>= g) >>= h
= { case }
	(None >>= g) >>= h
= { bind def }
	(match None with
	| None -> None
	| Some a -> g a) >>= h
= { apply match }
	(None) >>= h
= { bind def }
	(match None with
	| None -> None 
	| Some a -> h a) 
= ( apply match )
	None
= ( reverse match )
	(match None with
	| None -> None 
	| Some a -> h a) 
= { reverse bind }
	(None) >>= h
= { reverse match }
	( match None with
	| None -> None 
	| Some a -> g a) >> = h
= { reverse bind }
	None >>= (fun y -> g y >>= h)
= { case }
	x >>= (fun y -> g y >>= h)



Case x = Some y:

	(x >>= g) >>= h
= { case }
	(Some y >>= g) >>= h
= { bind def }
	(match Some y with
	| None -> None
	| Some a -> g a) >>= h
= { apply match }
	(Some y) >>= h
= { bind def }
	(match Som e y with
	| None -> None 
	| Some a -> h a) 
= ( apply match )
	Some y
= { reverse match }
	(match None with
	| None -> None 
	| Some a -> h a) 
= { reverse bind }
	(Some y) >>= h
= { reverse match }
	( match Some y with
	| None -> None 
	| Some a -> g a) >> = h
= { reverse bind }
	Some y >>= (fun y -> g y >>= h)
= { case }
	x >>= (fun y -> g y >>= h)


# Problem 2

```
Prove:
	return x >>= f = f x, for (x: 'a option)

```

case x = None:

	return x >>= f
= { case }
	return None >>= f
= { apply return }
	None >>= f
=  { bind def }
	( match None with
	| None -> None 
	| Some a -> f a)
= { apply match }
	None
= { reverse f }
	f None
= { case }
	f x

case x = Some x:

	return x >>= f
= { case }
	return Some x >>= f
= { apply return }
	Some x >>= f
=  { bind def }
	( match Some x with
	| None -> None 
	| Some a -> f a)
= { apply match }
	some x
= { reverse f }
	f some x
= { case }
	f x

# Problem 3

```
Prove:
	x >>= (fun x' -> y >>= (fun y' -> plus x' y')) =
		match y with 
		| None -> None
		| Some y' -> (
			match x with 
			| None -> None
			| Some x' -> plus x' y')

```

case x = None, y = None:

	x >>= (fun x' -> y >>= (fun y' -> plus x' y'))
= { case }
	None >>= (fun x' -> None >>= (fun y' -> plus x' y'))
= { bind def }
	(match None with
	| None -> None 
	| Some a -> plus None (Some a))
= { apply match }
	None
= { reverse match }
	match None with 
	| None -> None
	| Some y' -> (
		match x with 
		| None -> None
		| Some x' -> plus x' y')
= { case }
	match y with 
	| None -> None
	| Some y' -> (
		match x with 
		| None -> None
		| Some x' -> plus x' y')


case x = None, y = Some:

	x >>= (fun x' -> y >>= (fun y' -> plus x' y'))
= { case }
	None >>= (fun x' -> None >>= (fun y' -> plus x' y'))
= { bind def }
	(match None with
	| None -> None 
	| Some a -> plus None (Some a))
= { apply match }
	None
= { reverse match }
	match None with 
		| None -> None
		| Some y' -> (
			match x with 
			| None -> None
			| Some x' -> plus x' y')
= { case }
	match y with 
	| None -> None
	| Some y' -> (
		match x with 
		| None -> None
		| Some x' -> plus x' y')

case x = some, y = None;

	x >>= (fun x' -> y >>= (fun y' -> plus x' y'))
= { case }
	Some x >>= (fun x' -> None >>= (fun y' -> plus x' y'))
= { bind def }
	match Some x with 
	| None -> None
	| Some x -> (fun x' -> None >>= (fun y' -> plus x' y'))
= { apply match }
	None >>= (fun y' -> plus x' y')
= { bind def }
	match None with 
	| None -> None
	| Some y -> fun y' -> plus x' y'
= { apply match}
	None
= { reverse match }
	match None with 
	| None -> None
	| Some y' -> (
		match x with 
		| None -> None
		| Some x' -> plus x' y')
= { case }
	match y with 
	| None -> None
	| Some y' -> (
		match x with 
		| None -> None
		| Some x' -> plus x' y')

case x = Some, y = Some;

	x >>= (fun x' -> y >>= (fun y' -> plus x' y'))
= { case }
	Some x >>= (fun x' -> Some y>>= (fun y' -> plus x' y'))
= { bind def }
	match some x with 
	| None -> None
	| Some x -> (fun x' -> Some y>>= (fun y' -> plus x' y'))
= { apply match }
	Some y >>= (fun y' -> plus x' y')
= { bind def }
	match some y with 
	| None -> None
	| Some y -> plus x' y
= { reverse match }
	match some y with 
	| None -> None
	| Some y' -> (
		match x with 
		| None -> None
		| Some x' -> plus x' y')
= { case }
	match y with 
	| None -> None
	| Some y' -> (
		match x with 
		| None -> None
		| Some x' -> plus x' y')
