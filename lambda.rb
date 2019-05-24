require_relative 'lexer.rb'
require_relative 'parser.rb'
require_relative 'utils.rb'
# Original grammar:
# TERM        -> APPLICATION | ABSTRACTION
# ABSRTACTION -> LAMBDA LCID DOT TERM
# APPLICATION -> APPLICATION ATOM | ATOM
# ATOM        -> LPAREN TERM RPAREN | LCID
#
# without left-recursion:
# TERM         -> APPLICATION | ABSTRACTION
# ABSRTACTION  -> LAMBDA LCID DOT TERM
# APPLICATION  -> ATOM APPLICATION'
# APPLICATION' -> ATOM APPLICATION' | ε       
# ATOM         -> LPAREN TERM RPAREN | LCID
# LAMBDA       -> λ | \
# DOT          -> .
# LCID         -> a | b | ... | z
#
# FIRST sets:
# LCID : { w : w ~= /a-z/ }
# DOT : { . }
# LAMBDA : { λ, \ }
# ATOM : { ( } v FIRST(LCID)
# APPLICATION : {  }

l = Lexer.to_proc
p = Parser.to_proc
#e = Evaluator.to_proc

input = ARGV[0]
ast = p[l[input]]
pretty_print_ast(ast)
