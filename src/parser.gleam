import gleam/string
import types/lambda_term.{type LambdaTerm, Abs, App, Var}
import utility/utility.{remove_both_paren, remove_right_paren, split_once_last}

pub fn parser(input: String) -> LambdaTerm {
  let result =
    input
    |> string.trim()
    |> string.split("")
  case result {
    [var] | [var, ")"] | ["(", var, ")"] -> Var(var)
    ["λ", ..rest] -> {
      case rest {
        [id, ".", ..tail] -> {
          tail
          |> string.concat
          |> remove_both_paren
          |> parser
          |> Abs(id, _)
        }
        _ -> panic as input
      }
    }
    ["(", ..rest] -> {
      case rest {
        [var, ")", ..rest] -> App(parser(var), parser(string.concat(rest)))
        ["(", ..rest] -> {
          let assert [lterm, rterm] =
            rest
            |> string.concat
            |> split_once_last(" ", [""])
          App(parser("(" <> lterm), parser(rterm))
        }
        ["λ", ..rest] -> {
          let assert [lterm, rterm] =
            rest
            |> string.concat
            |> split_once_last(" ", [""])
          let lterm =
            lterm
            |> remove_right_paren
          rterm
          |> remove_both_paren
          |> parser
          |> App(parser("λ" <> lterm), _)
        }
        _ -> panic as input
      }
    }
    _ -> panic as input
  }
}
