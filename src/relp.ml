let () =
  try 
    while true do
      print_string "> ";
      let line = read_line () in
      if line = "exit" then
        exit 0
      else
      print_endline line
    done
  with
  | End_of_file ->
      print_endline "Goodbye!"
  | e ->
      print_endline ("Error: " ^ Printexc.to_string e)
