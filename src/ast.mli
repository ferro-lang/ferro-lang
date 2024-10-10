type t =
    Integer of int
  | Float of float
  | Operation of Lexer.operator
  | BinaryOperation of t * t * t
type program = Program of t list


val print_program : program -> unit