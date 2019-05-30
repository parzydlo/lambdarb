require_relative 'lexer.rb'
require_relative 'parser.rb'
require_relative 'print_visitor.rb'

# Grammar:
# EXPR         -> APPLICATION | ABSTRACTION
# ABSTRACTION  -> LAMBDA LCID DOT EXPR
# APPLICATION  -> ATOM APPLICATION'
# APPLICATION' -> ATOM APPLICATION' | ε       
# ATOM         -> LPAREN EXPR RPAREN | LCID
# LAMBDA       -> λ | /
# DOT          -> .
# LCID         -> a | b | ... | z

l = Lexer.to_proc
p = Parser.to_proc

input = "(λx.x)(λy.y)"
ast = p[l[input]]
PrintVisitor.new.visit(ast)
