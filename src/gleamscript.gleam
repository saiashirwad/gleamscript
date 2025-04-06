import gleam/option.{type Option}

pub type Name =
  String

pub type LiteralValue {
  NumberLiteral(value: Int)
  StringLiteral(value: String)
  BoolLiteral(value: Bool)
  SymbolLiteral(value: String)
  NilLiteral
}

pub type Type {
  VarType(name: Name)
  NumberType
  StringType
  BooleanType
  NullType
  UnknownType
  LiteralType(value: LiteralValue)
  ListType(element_type: Type)
  StructType(kvs: List(#(Name, Type)))
  UnionType(types: List(Type))
  FunctionType(args: List(Type), result: Type)
}

pub type MatchCase {
  MatchCase(pattern: Pattern, expr: Expr)
}

pub type Expr {
  LiteralExpression(value: LiteralValue)
  VariableExpression(name: Name)
  ApplicationExpression(fn_expr: Expr, args: List(Expr))
  LetExpression(bindings: List(#(Name, Expr)), body: Expr)
  IfExpression(condition: Expr, then_expr: Expr, else_expr: Expr)
  LambdaExpression(
    args: List(#(Name, Type)),
    return_type: Option(Type),
    body: Expr,
  )
  MatchExpression(expr: Expr, cases: List(MatchCase))
  SequenceExpression(exprs: List(Expr))
}

pub type Pattern {
  PatWildcard
  PatVar(name: Name)
  PatLit(value: LiteralValue)
  PatCon(name: Name, patterns: List(Pattern))
  PatStruct(name: Name, fields: List(#(Name, Pattern)))
  PatList(patterns: List(Pattern))
}

pub type Definition {
  DefFun(
    fun_name: Name,
    fun_args: List(#(Name, Type)),
    fun_ret_type: Option(Type),
    fun_body: Expr,
  )
  DefType(type_name: Name, type_body: Type)
}

pub type Program =
  List(Definition)

pub fn main() {
  echo UnionType([
    LiteralType(NumberLiteral(2)),
    LiteralType(NumberLiteral(3)),
    StringType,
  ])
}
