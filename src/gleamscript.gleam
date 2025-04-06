import ast
import gleam/option.{Some}

fn var(name: String) -> ast.Expr {
  ast.VariableExpression(name)
}

fn get_field(expr: ast.Expr, field: String) -> ast.Expr {
  ast.GetFieldExpression(expr, field)
}

pub fn main() {
  echo [
    ast.DefType(
      name: "Point",
      body: ast.StructType(kvs: [#("x", ast.NumberType), #("y", ast.NumberType)]),
    ),
    ast.DefFun(
      name: "distance-squared",
      args: [#("p", ast.VarType("Point"))],
      ret_type: Some(ast.NumberType),
      body: ast.LetExpression(
        bindings: [
          #("x", get_field(var("p"), "x")),
          #("y", get_field(var("p"), "y")),
        ],
        body: ast.ApplicationExpression(var("+"), [
          ast.ApplicationExpression(var("*"), [var("x"), var("x")]),
          ast.ApplicationExpression(var("*"), [var("y"), var("y")]),
        ]),
      ),
    ),
  ]
}
