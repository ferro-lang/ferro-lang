let () =
  try 
    while true do
      print_newline ();
      print_string "> ";
      let line = read_line () in
      if line = "exit" then
        exit 0
      else
        try 
          let tokens = Lexer.lexer line in
          Lexer.print_lexer tokens;
        with
        | Failure msg -> print_endline (Stdout.color_string Stdout.Red msg)
    done
  with
  | End_of_file ->
      print_endline "Goodbye!"
  | e ->
      print_endline ("Error: " ^ Printexc.to_string e)
