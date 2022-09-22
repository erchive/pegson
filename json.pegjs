{{
class ASTNode {
	constructor(value) { Object.assign(this, value); }
}

class ObjectNode extends ASTNode {}
class ObjectParameterNode extends ASTNode {}
class ArrayNode extends ASTNode {}
class StringNode extends ASTNode {}
class IntegerNode extends ASTNode {}
class FloatNode extends ASTNode {}
class BoolNode extends ASTNode {}
}}

Value
	= Float / Integer / Bool / String / Object / Array 
    
Bool
	= value:("true" / "false") { return new BoolNode({ value }) }
    
Float
	= value:([0-9]+ "." [0-9]+) { return new FloatNode({ value: text() }) }
    
Integer
	= value:[0-9]+ { return new IntegerNode({ value }) }
    
String
	= value:str { return new StringNode({ value }) }

Array
	= "[" _ items:ArrayItems* _ "]" { return new ArrayNode({ items: items.flat() }) }
    
ArrayItems
	= (Value _ "," _)* Value

Object
	= "{" _ parameters:ObjectParameters* _ "}" { return new ObjectNode({ parameters: parameters.flat() }); }
    
ObjectParameters
	= (ObjectParameter _ "," _)* ObjectParameter

ObjectParameter
	= name:str _ ":" _ value:Value { return new ObjectParameterNode({ name, value }); }

str
	= '"' value:$[^"]* '"' { return value; }

_ "whitespace"
	= [ \t\n\r]*
