pub type Expr {
  Var(String)
  App(Expr, Expr)
  Lam(String, Expr)
}
