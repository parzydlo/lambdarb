class Visitor
    def visit(subject, *args)
        method_name = "visit_#{subject.class}".intern
        send(method_name, subject, *args)
    end

    def visit_children(subject, *args)
        if !subject.children.nil?
            subject.children.each { |child| visit(child, *args) }
        end
    end
end
