import types/lambda_term.{type LambdaTerm, Abs, App, Var}

pub fn expr_to_string(exp: LambdaTerm) -> String {
  case exp {
    Var(x) -> x
    App(left, right) -> {
      "(" <> expr_to_string(left) <> ") (" <> expr_to_string(right) <> ")"
    }
    Abs(str, exp) -> {
      "λ" <> str <> ".(" <> expr_to_string(exp) <> ")"
    }
  }
}
