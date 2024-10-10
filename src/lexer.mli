type operator = Plus | Minus | Times | Divide | Modulus
type t =
    Integer of int
  | Float of float
  | Operation of operator
  | LParan
  | RParan
val string_of_operator : operator -> string
val operator_of_char : char -> operator
val build_number : char list -> t
val lexer : string -> t list
val print_lexer : t list -> unit
