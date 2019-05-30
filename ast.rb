class ASTNode
    attr_reader :children, :pos

    def initialize(children, pos)
        @children = children
        @pos = pos
    end
end

class ExprNode < ASTNode
    def initialize(children, pos)
        super(children, pos)
    end
end

class AbstrNode < ASTNode
    def initialize(children, pos)
        super(children, pos)
    end
end

class AppNode < ASTNode
    def initialize(children, pos)
        super(children, pos)
    end
end

class IdNode < ASTNode
    attr_reader :value

    def initialize(children, pos, value)
        super(children, pos)
        @value = value
    end
end

class AtomNode < ASTNode
    def initialize(children, pos)
        super(children, pos)
    end
end
