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
                return ASTNode.new(:astexpr, [parse_abstraction])
            else
                return ASTNode.new(:astexpr, [parse_application])
            end
        end

        def parse_abstraction
            consume_token(:tklambda)
            id = parse_identifier
            consume_token(:tkdot)
            expr = parse_expr
            return ASTNode.new(:astabstraction, [id, expr])
        end

        def parse_identifier
            consume_token
            return ASTNode.new(:astidentifier, nil)
        end

        def parse_application
            left_child = parse_atom
            first_atom = [:tklparen, :tkid] # FIRST(ATOM)
            # application -> atom application'
            while !lookahead.nil? and first_atom.include?(lookahead.type)
                consume_token
                return ASTNode.new(:astapplication, [left_child, parse_application])
            end
            # application' -> atom application' | ε
            return left_child
        end

        def parse_atom
            if lookahead.type == :tklparen
                consume_token(:tklparen)
                expr = parse_expr
                consume_token(:tkrparen)
                return ASTNode.new(:astatom, [expr])
            else
                return ASTNode.new(:astatom, [parse_identifier])
            end
        end
        
        def consume_token(type = nil)
            if !type.nil? and lookahead.type != type
                raise "Unexpected token at #{@l + 1}, expecting #{type}."
            end
            @l += 1
        end

        def lookahead
            nt = @tokens[@l + 1]
            return nt
        end
end
