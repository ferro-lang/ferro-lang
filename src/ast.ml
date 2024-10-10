type t =
| Integer of int
| Float of float
| Operation of Lexer.operator
| BinaryOperation of t * t * t

type program = 
| Program of t list

let print_program (program: program): unit =
  let rec print_expression (expression: t) (indent: int): unit = 
    match expression with
    | Float f -> 
      print_string (String.make indent ' ');
      print_string ("Float(" ^ string_of_float f ^ ")")
    | Integer i -> 
      print_string (String.make indent ' ');
      print_string ("Integer(" ^ string_of_int i ^ ")")
    | Operation op -> 
      print_string (String.make indent ' ');
      print_string (Lexer.string_of_operator op)
    | BinaryOperation (operator, left, right) ->
      print_string (String.make indent ' ');
      print_string "BinaryOperation(";
      print_newline ();
      print_string (String.make indent ' ');
      print_expression operator (indent + 1);
      print_string ",";
      print_newline ();
      print_string (String.make indent ' ');
      print_expression left (indent + 1);
      print_string ",";
      print_newline ();
      print_string (String.make indent ' ');
      print_expression right (indent + 1);
      print_string ",";
      print_newline ();
      print_string (String.make (indent) ' ');
      print_string ")"
  in
  match program with
  | Program expressions ->
    List.iter (fun expression -> print_expression expression 0) expressions
