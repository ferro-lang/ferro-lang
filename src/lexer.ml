type operator =
| Plus
| Minus
| Times
| Divide
| Modulus

type t = 
| Integer of int
| Float of float
| Operation of operator

let string_of_operator (operator: operator): string =
  match operator with
  | Plus -> "+"
  | Minus -> "-"
  | Times -> "*"
  | Divide -> "/"
  | Modulus -> "%"

let operator_of_char (char: char): operator =
  match char with
  | '+' -> Plus
  | '-' -> Minus
  | '*' -> Times
  | '/' -> Divide
  | '%' -> Modulus
  | _ -> failwith ("Lexer error: Invalid operator, expected one of the following: +, -, *, /, %, got " ^ String.make 1 char)

let build_number (number: char list): t =
  let string_number = List.fold_left (fun acc c -> acc ^ String.make 1 c) "" number in
  if String.contains string_number '.' then
    Float (float_of_string string_number)
  else
    Integer (int_of_string string_number)

let lexer (source: string): 'a list =
  let rec helper (position: int) (tokens: 'a list): 'a list =
    if position >= String.length source then
      List.rev tokens
    else
      match source.[position] with
      | '+' | '-' | '*' | '/' | '%' as c ->
        helper (position + 1) (Operation (operator_of_char c) :: tokens)
      | '0'..'9' ->
        let rec extract_number (number: char list) (position: int): (int * t) = 
          if position >= String.length source then
            (position, build_number (List.rev number))
          else
            match source.[position] with
            | '0'..'9' | '.' as c -> 
              if (c = '.' && List.mem '.' number) then
                failwith "Lexer error: A number cannot have multiple dots."
              else
                extract_number (source.[position] :: number) (position + 1)
            | _ -> (position, build_number (List.rev number))
          in 
        let (position, number) = extract_number [source.[position]] (position + 1) in
        helper position (number :: tokens)
      | _ -> helper (position + 1) tokens
  in helper 0 []

let print_lexer (tokens: t list): unit = 
  List.iteri (fun idx token ->
    let prefix = if idx = 0 then "" else "\n" in
    match token with
    | Integer i -> print_string (prefix ^ "Integer(" ^ string_of_int i ^ ")")
    | Float f -> print_string (prefix ^ "Float(" ^ string_of_float f ^ ")")
    | Operation op -> print_string (prefix ^ "Operation(" ^ string_of_operator op ^ ")")
  ) tokens;
  print_newline ()

