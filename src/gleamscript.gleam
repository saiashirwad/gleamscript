import ast
import gleam/option.{Some}

fn var(name: String) -> ast.Expr {
  ast.VariableExpression(name)
}

fn get_field(expr: ast.Expr, field: String) -> ast.Expr {
  ast.GetFieldExpression(expr, field)
}

pub fn main() {
  let program_ast = [
    ast.DefType(
      type_name: "Point",
      type_body: ast.StructType(kvs: [
        #("x", ast.NumberType),
        #("y", ast.NumberType),
      ]),
    ),
    ast.DefFun(
      fun_name: "distance-squared",
      fun_args: [#("p", ast.VarType("Point"))],
      fun_ret_type: Some(ast.NumberType),
      fun_body: ast.LetExpression(
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
