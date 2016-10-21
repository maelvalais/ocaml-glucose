type var = int
type lit = int
type value = int (* F | T | X *)
type solution = SAT | UNSAT

external reset : unit -> unit = "glucose_reset"
external new_var : unit -> var = "glucose_new_var"
external pos_lit : var -> lit = "glucose_pos_lit"
external neg_lit : var -> lit = "glucose_neg_lit"
external add_clause : lit list -> unit = "glucose_add_clause"
external simplify_db : unit -> unit = "glucose_simplify_db"
external solve : unit -> solution = "glucose_solve"
external solve_with_assumption : lit list -> solution = "glucose_solve_with_assumption"
external value_of : var -> value = "glucose_value_of"

let string_of_value (v: value): string =
  match v with
  | 0 -> "false"
  | 1 -> "true"
  | 2 -> "unknown"
  | _ -> "error"
  (*
  | F -> "false"
  | T -> "true"
  | X -> "unknown"
  *)
