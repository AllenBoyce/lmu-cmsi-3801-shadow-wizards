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
let meaningful_line_count file_name =
  let file = open_in filename in
  let rec aux count =
    match input_line file with
    | exception End_of_file -> count
    | line -> if String.trim line = "" then aux count else aux (count + 1)
  in
  let count = aux 0 in
  close_in file;
  count;;

  (* Write your shape type and associated functions here *)

(* Write your binary search tree implementation here *)
