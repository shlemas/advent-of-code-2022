module Day5

function parse_crates(file)
    stacks = []
    for line in eachline(file)
        crates = [line[2], [line[i+2] for i in 4:4:length(line)]...]
        if isempty(stacks)
            stacks = [[] for _ in 1:length(crates)]
        end
        if isnumeric(crates[1])
            break
        end
        for (i, crate) in enumerate(crates)
            if !isspace(crate)
                push!(stacks[i], crate)
            end
        end
    end
    return stacks
end

function parse_moves(file)
    moves = []
    pattern = r"move (\d+) from (\d+) to (\d+)"
    for line in eachline(file)
        m = match(pattern, line)
        if !isnothing(m)
            push!(moves, map(s -> parse(Int, s), m.captures[1:3]))
        end
    end
    return moves
end

function parse_file(filename)
    file = open(filename, "r")
    stacks = parse_crates(file)
    moves = parse_moves(file)
    close(file)
    return stacks, moves
end

function make_message(stacks)
    return String([!isempty(stack) ? stack[1] : ' ' for stack in stacks])
end

function part1(filename)
    stacks, moves = parse_file(filename)
    for move in moves
        amount, source, target = move
        for _ in 1:amount
            pushfirst!(stacks[target], popfirst!(stacks[source]))
        end
    end
    return make_message(stacks)
end

function part2(filename)
    stacks, moves = parse_file(filename)
    for move in moves
        amount, source, target = move
        prepend!(stacks[target], stacks[source][1:amount])
        stacks[source] = stacks[source][amount+1:end]
    end
    return make_message(stacks)
end

end  # module