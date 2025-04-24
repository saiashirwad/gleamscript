import gleam/dict.{type Dict}

import ast

pub type Context {
  Context(variable_types: Dict(ast.Name, ast.Type))
}

pub fn empty_context() -> Context {
  Context(variable_types: dict.new())
}

pub fn add_variable(ctx: Context, name: ast.Name, typ: ast.Type) -> Context {
  Context(variable_types: dict.insert(ctx.variable_types, name, typ))
}

pub fn lookup_variable(ctx: Context, name: ast.Name) -> Result(ast.Type, Nil) {
  dict.get(ctx.variable_types, name)
}

pub type TypeError {
  UnboundVariable(name: ast.Name)
  NotImplementedYet(feature: String)
  // Future errors:
  // Mismatch(expected: ast.Type, found: ast.Type)
  // ArityError(function_name: ast.Name, expected: Int, found: Int)
  // InvalidFieldAccess(field_name: ast.Name, struct_type: ast.Type)
  // and more
}
