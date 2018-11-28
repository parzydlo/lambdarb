def pretty_print_ast(root, indent = 0)
    puts " " * indent + root.ast_type.to_s
    if !root.ast_children.nil?
        root.ast_children.each { |child| 
            pretty_print_ast(child, indent + 2)
        }
    end
end
