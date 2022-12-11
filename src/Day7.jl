module Day7

mutable struct Directory
    parent::Union{Nothing, Directory}
    children::Dict{String, Union{Directory, Int}}
    size::Int
    Directory(parent=nothing) = new(parent, Dict(), 0)
end

function add_file(dir, name, size)
    if !haskey(dir.children, name)
        dir.children[name] = size
        while dir !== nothing
            dir.size += size
            dir = dir.parent
        end
    end
end

function find_dirs(dir::Directory, predicate)
    result = []
    if predicate(dir)
        push!(result, dir)
    end
    for child in values(dir.children)
        if isa(child, Directory)
            append!(result, find_dirs(child, predicate))
        end
    end
    return result
end

function build_dirs(commands)
    root = Directory()
    cd = root
    for command in commands
        if (m = match(r"\$ cd (.+)", command)) !== nothing
            dir = m.captures[1]
            if dir == "/"
                cd = root
            elseif dir == ".."
                cd = cd.parent
            else
                cd = get!(cd.children, dir, Directory(cd))
            end
        elseif (m = match(r"(\d+) (.+)", command)) !== nothing
            file_size, file_name = m.captures
            add_file(cd, file_name, parse(Int, file_size))
        end
    end
    return root
end

function part1(filename)
    commands = readlines(filename)
    root = build_dirs(commands)
    dirs = find_dirs(root, dir -> dir.size <= 100000)
    return sum(dir.size for dir in dirs)
end

function part2(filename)
    commands = readlines(filename)
    root = build_dirs(commands)
    free_space = 70000000 - root.size
    dirs = find_dirs(root, dir -> (dir.size + free_space) >= 30000000)
    return minimum(dir -> dir.size, dirs)
end

end  # module