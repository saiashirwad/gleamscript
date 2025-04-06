import ast
import gleam/option.{Some}

fn var(name: String) -> ast.Expr {
  ast.VariableExpression(name)
}

fn get_field(expr: ast.Expr, field: String) -> ast.Expr {
  ast.GetFieldExpression(expr, field)
}

pub fn main() {
  let point_type_def =
    ast.DefType(
      type_name: "Point",
      type_body: ast.StructType(kvs: [
        #("x", ast.NumberType),
        #("y", ast.NumberType),
      ]),
    )

  let program_ast = [
    point_type_def,
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

  echo program_ast
}
