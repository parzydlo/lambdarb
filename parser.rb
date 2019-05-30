require_relative 'token.rb'
require_relative 'ast.rb'

class Parser
    def self.call(tokens)
        new(tokens).send(:parse_expr)
    end

    def self.to_proc
        method(:call).to_proc
    end

    private
        def initialize(tokens)
            @tokens = tokens
            @l = -1
        end

        def parse_expr
            if lookahead.type == :tklambda
                return ExprNode.new([parse_abstraction], @l)
            else
                return ExprNode.new([parse_application], @l)
            end
        end

        def parse_abstraction
            match_token(:tklambda)
            id = parse_identifier
            match_token(:tkdot)
            expr = parse_expr
            return AbstrNode.new([id, expr], @l)
        end

        def parse_identifier
            id_token = match_token(:tkid)
            val = id_token.value
            return IdNode.new(nil, @l, val)
        end

        def parse_application
            left_child = parse_atom
            first_atom = [:tklparen, :tkid] # FIRST(ATOM)
            # application -> atom application'
            while !lookahead.nil? and first_atom.include?(lookahead.type)
                return AppNode.new([left_child, parse_application], @l)
            end
            # application' -> atom application' | ε
            return left_child
        end

        def parse_atom
            if lookahead.type == :tklparen
                match_token(:tklparen)
                expr = parse_expr
                match_token(:tkrparen)
                return AtomNode.new([expr], @l)
            else
                return AtomNode.new([parse_identifier], @l)
            end
        end
        
        def match_token(type = nil)
            if !type.nil? and lookahead.type != type
                raise "Unexpected token at #{@l + 1}. Expected: #{type}, "\
                      "got: #{lookahead.type}."
            end
            @l += 1
            return @tokens[@l]
        end

        def lookahead
            return @tokens[@l + 1]
        end
end
