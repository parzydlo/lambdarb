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
            string.each_char.with_index { |char, i| 
                case char
                when /[λ\\]/
                    tokens << Token.new(:tklambda, char)
                when /\./
                    tokens << Token.new(:tkdot, char)
                when /\(/
                    tokens << Token.new(:tklparen, char)
                when /\)/
                    tokens << Token.new(:tkrparen, char)
                when /[a-z]/
                    tokens << Token.new(:tkid, char)
                else
                    raise "Invalid character: \"#{char}\" at pos: #{i}"
                end
            }
            return tokens
        end
end

if $0 == __FILE__
    input = ARGV[0]
    output = Lexer.call(input)
end
