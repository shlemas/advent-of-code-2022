module Day11

struct Monkey
    starting_items::Vector{Int}
    operation::Tuple{Function, Any}
    test_divisor::Int
    true_outcome::Int
    false_outcome::Int
end

function read_starting_items(line)::Vector{Int}
    matches = [m.match for m in eachmatch(r"\d+", line)]
    starting_items = map(m -> parse(Int, m), matches)
    return starting_items
end

function read_operation(line)::Tuple{Function, Any}
    m = match(r"Operation: new = old (.) (\w+)", line)
    operator = (m.captures[1] == "*") ? (*) : (+)
    value = isnumeric(m.captures[2][1]) ? parse(Int, m.captures[2]) : m.captures[2]
    return operator, value
end

function read_test_divisor(line)::Int
    m = match(r"Test: divisible by (\d+)", line)
    divisor = parse(Int, m.captures[1])
    return divisor
end

function read_outcome(line)::Int
    m = match(r"If (?:true|false): throw to monkey (\d+)", line)
    monkey = parse(Int, m.captures[1])
    return monkey
end

function read_monkeys(filename)
    lines = readlines(filename)
    sections::Vector{Vector{String}} = [[]]
    monkeys::Vector{Monkey} = []
    for line in lines
        if !isempty(line)
            push!(sections[end], line)
        else
            push!(sections, [])
        end
    end
    for section in sections
        monkey = Monkey(
            read_starting_items(section[2]),
            read_operation(section[3]),
            read_test_divisor(section[4]),
            read_outcome(section[5]),
            read_outcome(section[6]),
        )
        push!(monkeys, monkey)
    end
    return monkeys
end

function part1(filename)
    return read_monkeys(filename)
end

function part2(filename)
    
end

end  # module