pub type LambdaTerm {
  Var(String)
  App(LambdaTerm, LambdaTerm)
  Abs(String, LambdaTerm)
}
