import gleeunit
import gleeunit/should
import parser.{parser}
import types/lambda_term.{Abs, App, Var}

pub fn main() {
  gleeunit.main()
}

// pub fn app_ident_function_test() {
//   let input = App(Abs("x", Abs("x", Var("x"))), Var("x"))
//   should.equal(parser("(λx.(λx.(x))) (x)"), input)
// }

// pub fn abs_const_function_test() {
//   let input = Abs("x", Abs("x", Var("y")))
//   should.equal(parser("λx.(λx.(y))"), input)
// }

// pub fn app_application_test() {
//   let input = App(Abs("x", Var("x")), Abs("y", Var("y")))
//   should.equal(parser("(λx.(x)) (λy.(y))"), input)
// }

pub fn nested_application_test() {
  let input = App(App(Abs("x", Abs("y", Var("x"))), Var("z")), Var("w"))
  should.equal(parser("((λx.(λy.(x))) (z)) (w)"), input)
}
// pub fn free_variable_test() {
//   let input = Abs("x", Var("y"))
//   input
//   |> should.equal(parser("λx.(y)"))
// }

// pub fn multiple_occurrences_test() {
//   let input = App(Abs("x", App(Var("x"), Var("x"))), Abs("y", Var("y")))
//   input
//   |> should.equal(parser("(λx.(x x)) (λy.(y))"))
// }
