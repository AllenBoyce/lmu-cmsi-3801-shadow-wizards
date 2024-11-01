exception Negative_Amount

let change amount =
  if amount < 0 then
    raise Negative_Amount
  else
    let denominations = [25; 10; 5; 1] in
    let rec aux remaining denominations =
      match denominations with
      | [] -> []
      | d :: ds -> (remaining / d) :: aux (remaining mod d) ds
    in
    aux amount denominations


let first_then_apply array predicate consumer =
  match List.find_opt predicate array with
  | Some x -> consumer x
  | None -> None

let powers b = 
  Seq.unfold (fun n -> Some ( b ** float_of_int n, n + 1)) 0


  let meaningful_line_count filename =
    let meaningful_line line =
      let trimmed = String.trim line in
      String.length trimmed > 0 && not (String.starts_with ~prefix: "#" trimmed)
    in
    let the_file = open_in filename in
    let finally () = close_in the_file in
    let rec count_lines count =
      try
       let line = input_line (the_file) in
       if meaningful_line line then
        count_lines (count + 1)
       else
        count_lines count
     with
      End_of_file -> count
    in
    Fun.protect ~finally (fun () -> count_lines 0);;

type shape =
| Box of { width : float; height : float; depth : float }
| Sphere of { radius : float }

let surface_area s =
match s with
| Box { width; height; depth } ->
    2. *. (width *. height +. height *. depth +. depth *. width)
| Sphere { radius } -> 4. *. Float.pi *. radius ** 2.

let volume s =
match s with
| Box { width; height; depth } -> width *. height *. depth
| Sphere { radius } -> (4. /. 3.) *. Float.pi *. radius ** 3.

let string_of_shape s =
match s with
| Box { width; height; depth } ->
    Printf.sprintf "Box(width=%.2f, height=%.2f, depth=%.2f)" width height depth
| Sphere { radius } ->
    Printf.sprintf "Sphere(radius=%.2f)" radius

let equal_shape s1 s2 =
match (s1, s2) with
| Box { width = w1; height = h1; depth = d1 }, Box { width = w2; height = h2; depth = d2 } ->
    w1 = w2 && h1 = h2 && d1 = d2
| Sphere { radius = r1 }, Sphere { radius = r2 } ->
    r1 = r2
| _, _ -> false

(* Write your binary search tree implementation here *)
