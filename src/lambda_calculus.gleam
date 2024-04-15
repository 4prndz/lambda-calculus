import types/expr.{type Expr, App, Lam, Var}
import gleam/io

pub fn main() {
  let x = Lam("x", App(Var("f"), Var("x")))
  print(x)
}

pub fn print(exp: Expr) -> String {
  case exp {
    Var(x) -> x
    App(left, right) -> {
      "(" <> print(left) <> ")" <> " " <> "(" <> print(right) <> ")"
    }
    Lam(str, exp) -> {
      io.print("λ" <> str <> ".(" <> print(exp) <> ")")
      ""
    }
  }
}
