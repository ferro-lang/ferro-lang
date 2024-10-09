type color = 
| Red

let color_string (color: color) (str: string): string =
  match color with
  | Red -> "\027[31m" ^ str ^ "\027[0m"