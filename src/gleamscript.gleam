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

pub type Expr

pub fn main() {
  echo UnionType([
    LiteralType(NumberLiteral(2)),
    LiteralType(NumberLiteral(3)),
    StringType,
  ])
}
