import gleam/io
import gleam/list
import gleam/string
import types/lambda_term.{type LambdaTerm, Abs, App, Var}
import utility/utility.{expr_to_string}

pub fn main() {
  io.println("expr -> string")
  let x = App(Abs("x", Abs("x", Var("x"))), Var("x"))
  expr_to_string(x)
  |> io.debug()

  let input = "λx.(λx.(y))"
  // let input = "(λx.(λx.(x))) (x)"
  io.println("string -> expr")
  input
  |> parser()
  |> io.debug()
}

pub fn parser(input: String) -> LambdaTerm {
  let x = string.split(string.trim(input), "")
  io.debug(string.concat(x))
  case x {
    ["λ", ..rest] -> {
      case rest {
        [id, ".", ..tail] -> {
          let lambda_term = string.drop_left(string.concat(tail), up_to: 1)
          let lambda_term = string.drop_right(lambda_term, up_to: 1)
          Abs(id, parser(lambda_term))
        }
        _ -> panic("syntax error")
      }
    }
    ["(", ..rest] -> {
      case rest {
        [var, ")", ..rest] -> App(parser(var), parser(string.concat(rest)))
        ["λ", ..rest] -> {
          let assert [lterm, rterm] = string.split(string.concat(rest), " ")
          let lterm = string.drop_right(lterm, up_to: 1)
          let rterm = string.drop_left(rterm, up_to: 1)
          let rterm = string.drop_right(rterm, up_to: 1)
          App(parser("λ" <> lterm), parser(rterm))
        }
        _ -> panic("syntax error")
      }
    }
    [var] -> Var(var)
    _ -> Var("n")
  }
}
