import gleam/io
import types/lambda_term.{Abs, App, Var}
import utility/utility.{lambda_to_string}

pub fn main() {
  let input = App(Abs("x", App(Var("x"), Var("x"))), Abs("y", Var("y")))
  input
  |> lambda_to_string()
  |> io.debug()
}
