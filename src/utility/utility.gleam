import gleam/list
import gleam/string
import types/lambda_term.{type LambdaTerm, Abs, App, Var}

pub fn lambda_to_string(exp: LambdaTerm) -> String {
  case exp {
    Var(x) -> x
    App(left, right) -> {
      "(" <> lambda_to_string(left) <> ") (" <> lambda_to_string(right) <> ")"
    }
    Abs(str, exp) -> {
      "λ" <> str <> ".(" <> lambda_to_string(exp) <> ")"
    }
  }
}

pub fn split_once_last(
  input: String,
  substring: String,
  tc: List(String),
) -> List(String) {
  let result =
    input
    |> string.split(substring)
    |> list.filter(fn(elem) { elem != " " && elem != "" })
  case result {
    [head, tail] -> [
      tc
        |> list.append([head])
        |> string.concat(),
      tail,
    ]
    [head, ..tail] -> {
      tail
      |> list.map(fn(elem) { elem <> substring })
      |> string.concat
      |> string.drop_right(up_to: 1)
      |> split_once_last(" ", list.append(tc, [head, " "]))
    }
    x -> x
  }
}

pub fn remove_both_paren(input: String) -> String {
  input
  |> remove_right_paren
  |> remove_left_paren
}

pub fn remove_right_paren(input: String) -> String {
  case string.ends_with(input, ")") {
    True -> string.drop_right(input, up_to: 1)
    _ -> input
  }
}

pub fn remove_left_paren(input: String) -> String {
  case string.starts_with(input, "(") {
    True -> string.drop_left(input, up_to: 1)
    _ -> input
  }
}
