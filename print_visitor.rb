require_relative 'visitor.rb'

class PrintVisitor < Visitor
    def visit_ExprNode(subject, depth = 0)
        repr = "EXPR"
        print_repr(repr, depth)
        visit_children(subject, depth + 1)
    end

    def visit_AbstrNode(subject, depth = 0)
        repr = "ABSTR"
        print_repr(repr, depth)
        visit_children(subject, depth + 1)
    end

    def visit_AppNode(subject, depth = 0)
        repr = "APP"
        print_repr(repr, depth)
        visit_children(subject, depth + 1)
    end

    def visit_IdNode(subject, depth = 0)
        repr = "ID(#{subject.value})"
        print_repr(repr, depth)
    end

    def visit_AtomNode(subject, depth = 0)
        repr = "ATOM"
        print_repr(repr, depth)
        visit_children(subject, depth + 1)
    end

    private

    def print_repr(repr, depth)
        str = repr.prepend("#{"  " * depth}")
        puts str
    end
end
