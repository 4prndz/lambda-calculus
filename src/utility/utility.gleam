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
  let result = list.filter(result, fn(elem) { elem != " " && elem != "" })
  case result {
    [head, tail] -> [string.concat(list.append(tc, [head])), tail]
    [head, ..tail] -> {
      let result = list.map(tail, fn(elem) { elem <> substring })
      let result = string.drop_right(string.concat(result), up_to: 1)
      split_once_last(result, " ", list.append(tc, [head, " "]))
    }
    x -> x
  }
}
