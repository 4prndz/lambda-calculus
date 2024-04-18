import gleam/io
import gleam/string
import types/lambda_term.{type LambdaTerm, Abs, App, Var}

pub fn parser(input: String) -> LambdaTerm {
  let x = string.split(string.trim(input), "")
  case x {
    [var] | [var, ")"] | ["(", var, ")"] -> {
      Var(var)
      |> io.debug()
    }
    ["λ", ..rest] -> {
      case rest {
        [id, ".", ..tail] -> {
          let lambda_term = string.drop_left(string.concat(tail), up_to: 1)
          let lambda_term = string.drop_right(lambda_term, up_to: 1)
          Abs(id, parser(lambda_term))
          |> io.debug()
        }
        _ -> panic("syntax error")
      }
    }
    ["(", ..rest] -> {
      case rest {
        [var, ")", ..rest] -> {
          App(parser(var), parser(string.concat(rest)))
          |> io.debug()
        }
        ["(", ..rest] -> {
          let assert [lterm, ..rterm] = string.split(string.concat(rest), " ")
          App(parser(lterm), parser(string.concat(rterm)))
          |> io.debug()
        }
        ["λ", ..rest] -> {
          let assert [lterm, ..rterm] = string.split(string.concat(rest), " ")
          let lterm = string.drop_right(lterm, up_to: 1)
          let rterm = string.drop_left(string.concat(rterm), up_to: 1)
          let rterm = string.drop_right(rterm, up_to: 1)
          App(parser("λ" <> lterm), parser(rterm))
          |> io.debug()
        }
        _ -> panic("syntax error")
      }
    }
    x -> {
      io.debug(string.concat(x))
      Var(string.concat(x))
    }
  }
}
