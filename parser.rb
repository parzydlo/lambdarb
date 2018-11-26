require_relative 'token.rb'
require_relative 'ast.rb'

class Parser
    def self.call(tokens)
        new(tokens).send(:parse_term)
    end

    private
        def initialize(tokens)
            @tokens = tokens
            @l = -1
        end

        def parse_term
            if next_token?(:tklambda)
                return ASTNode.new(:astterm, [parse_abstraction])
            else
                return ASTNode.new(:astterm, [parse_application0])
            end
        end

        def parse_abstraction
            consume_token(:tklambda)
            id = parse_identifier
            consume_token(:tkdot)
            term = parse_term
            return ASTNode.new(:astabstraction, [id, term])
        end

        def parse_identifier
            consume_token
            return ASTNode.new(:astidentifier, nil)
        end

        def parse_application0
            return ASTNode.new(:astapplication0, [parse_atom, parse_application1])
        end
        
        def parse_application1
            while next_token?(:tkid)            
                return ASTNode.new(:astapplication1, [parse_atom, parse_application1])
            end
            return nil
        end

        def parse_atom
            if next_token?(:tklparen)
                consume_token(:tklparen)
                term = parse_term
                consume_token(:tkrparen)
                return ASTNode.new(:astatom, [term])
            else
                return ASTNode.new(:asttoken, [parse_identifier])
            end
        end
        
        def consume_token(type = nil)
            if !type.nil? and !next_token?(type)
                raise "Unexpected token at #{@l + 1}, expecting #{type}."
            end
            @l += 1
        end

        def next_token?(type)
            return @tokens[@l + 1].type == type
        end
end
