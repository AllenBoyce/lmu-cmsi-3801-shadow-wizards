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

(* Write your first then apply function here *)
let first_then_apply array predicate consumer =
  match List.find_opt predicate array with
  | Some x -> consumer x
  | None -> None

(* Write your powers generator here *)

(* Write your line count function here *)
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
  
(* Write your shape type and associated functions here *)

(* Write your binary search tree implementation here *)
