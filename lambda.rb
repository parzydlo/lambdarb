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
# LAMBDA       -> λ
# DOT          -> .
# LCID         -> a | b | ... | z

input = ""
l = Lexer.to_proc
p = Parser.to_proc
e = Evaluator.to_proc

loop do
    begin
        e.call(p.call(l.call(input)))
    rescue => err
        print "Exception caught: #{err}"
    end
end
