import gleam/io
import gleam/string
import parser.{parser}
import types/lambda_term.{Abs, App, Var}
import utility/utility.{lambda_to_string, split_once_last}

pub fn main() {
  let input = App(App(Abs("x", Abs("y", Var("x"))), Var("z")), Var("w"))
  input
  |> lambda_to_string()
  |> io.debug()
}
