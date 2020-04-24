open Graphics
open Board
open Game
open State

let keyboard st =
  let status = wait_next_event [Poll] in 
  if status.keypressed then 
    match read_key () with 
    | 'd' -> move "right" st
    | 'a' -> move "left" st
    | 'w' -> rotate "clockwise" 90
    | 's' | ' ' -> drop 
    | _ -> ignore





