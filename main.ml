open Graphics
open Board
open Game
open State
open Command

exception InvalidFile
exception InvalidLineNum

let rec read_helper () =
  match read_line () with
  | exception End_of_file -> ()
  | _ -> ()

let rec run_game f lines game st = 
  try let x = keyboard game st in 
    x |> update game |> run_game f lines game with 
  | NoKeyPress -> run_game f lines game (update game st)
  | GameOver -> let again = end_keyboard () in if again 
    then (make_window (); start_game f lines) else () 

and start_game f lines = 
  let game = f |>  Yojson.Basic.from_file |> parse in 
  run_game f lines game (init_state game lines)

(** [main ()] prompts the user to choose a file of blocks to load, makes the 
    window, and starts the game engine.*)
let main () = 
  ANSITerminal.(print_string [red] "\n\nWelcome to OCaml Tetris.\n");
  ANSITerminal.(print_string [yellow] 
                  "Please enter the name of the Tetris mode you want to play:\n");
  ANSITerminal.(print_string [cyan] 
                  "tetris.json or pentris.json\n\n");
  print_string  "> ";
  let file_name =
    match read_line () with
    | exception End_of_file -> raise InvalidFile
    | read_name -> read_name in
  ANSITerminal.(print_string [magenta] 
                  "\nPlease enter the number of lines to win a game.\n\n");
  print_string  "> ";
  let lines_to_win =
    match read_line () with
    | exception End_of_file -> raise InvalidLineNum
    | lines -> int_of_string lines in
  make_window ();
  start_game file_name lines_to_win;
  read_helper ()

let () = main ()