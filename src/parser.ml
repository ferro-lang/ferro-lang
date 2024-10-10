
let rec parse (tokens: Lexer.t list): Ast.program = 
  match tokens with
  | [] -> Ast.Program []
  | _ -> 
    let (expr, remaining) = parse_expression tokens in
    if remaining <> [] then
      failwith "Parser error: Unexpected tokens after expression"
    else
      Ast.Program [expr]

and parse_expression (tokens: Lexer.t list): Ast.t * Lexer.t list = 
  parse_additive_expression tokens

and parse_additive_expression (tokens: Lexer.t list): Ast.t * Lexer.t list =
  let rec helper (lhs, tokens) =
    match tokens with
    | Lexer.Operation Lexer.Plus :: tail ->
        let (rhs, remaining) = parse_multiplicative_expression tail in
        helper (Ast.BinaryOperation (Ast.Operation Lexer.Plus, lhs, rhs), remaining)
    | Lexer.Operation Lexer.Minus :: tail ->
        let (rhs, remaining) = parse_multiplicative_expression tail in
        helper (Ast.BinaryOperation (Ast.Operation Lexer.Minus, lhs, rhs), remaining)
    | _ -> (lhs, tokens)
  in
  let (lhs, remaining) = parse_multiplicative_expression tokens in
  helper (lhs, remaining)

and parse_multiplicative_expression (tokens: Lexer.t list): Ast.t * Lexer.t list =
  let rec helper (lhs, tokens) =
    match tokens with
    | Lexer.Operation Lexer.Times :: tail ->
        let (rhs, remaining) = parse_primary_expression tail in
        helper (Ast.BinaryOperation (Ast.Operation Lexer.Times, lhs, rhs), remaining)
    | Lexer.Operation Lexer.Divide :: tail ->
        let (rhs, remaining) = parse_primary_expression tail in
        helper (Ast.BinaryOperation (Ast.Operation Lexer.Divide, lhs, rhs), remaining)
    | Lexer.Operation Lexer.Modulus :: tail ->
        let (rhs, remaining) = parse_primary_expression tail in
        helper (Ast.BinaryOperation (Ast.Operation Lexer.Modulus, lhs, rhs), remaining)
    | _ -> (lhs, tokens)
  in
  let (lhs, remaining) = parse_primary_expression tokens in
  helper (lhs, remaining)

and parse_primary_expression (tokens: Lexer.t list): Ast.t * Lexer.t list = 
  match tokens with
  | Lexer.Integer i :: tail -> (Ast.Integer i, tail)
  | Lexer.Float f :: tail -> (Ast.Float f, tail)
  | Lexer.LParan :: tail ->
    let (expr, tail') = parse_expression tail in
    (match tail' with
     | Lexer.RParan :: remaining -> (expr, remaining)
     | _ -> failwith "Parser error: Expected closing parenthesis")
  | [] -> failwith "Parser error: Unexpected end of input"
  | _ -> failwith "Parser error: Unexpected token"

