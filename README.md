# Attempt to Implement a Interpreter for Lambda Calculus 

## Syntax:
- variable: `(x)`
- abstraction: `λx.(x)`
- application: `(λx.(x)) (x)`

## Lambda Term Type Custom
- `Var(String)`
- `App(LambdaTerm, LambdaTerm)`
- `Abs(String, LambdaTerm)`

## Refs: 
- https://dev.to/chshersh/learn-lambda-calculus-in-10-minutes-with-ocaml-56ba
- https://en.wikipedia.org/wiki/Lambda_calculus

## TODO: 
- Implements Tail Call Optimization in Parser
- Finish the Evalution
- Supports Body App :P
