require_relative 'token.rb'

class Lexer
    def self.call(string)
        new().send(:tokenise, string)
    end

    def self.to_proc
        method(:call).to_proc
    end

    private
        def tokenise(string)
            tokens = []
            string.each_char { |char| 
                case char
                when 'λ'
                    tokens << Token.new(:tklambda, char)
                when '.'
                    tokens << Token.new(:tkdot, char)
                when '('
                    tokens << Token.new(:tklparen, char)
                when ')'
                    tokens << Token.new(:tkrparen, char)
                else
                    tokens << Token.new(:tkid, char)
                end
            }
            return tokens
        end
end

if $0 == __FILE__
    input = ARGV[0]
    output = Lexer.call(input)
end
