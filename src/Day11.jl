module Day11

mutable struct Monkey
    items::Vector{Int}
    operation::Tuple{Function, Any}
    test_divisor::Int
    true_monkey::Int
    false_monkey::Int
    num_inspections::Int
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
            0
        )
        push!(monkeys, monkey)
    end
    return monkeys
end

function round!(monkeys::Vector{Monkey}, worryfn::Function)
    for monkey in monkeys
        while !isempty(monkey.items)
            monkey.num_inspections += 1
            item = popfirst!(monkey.items)
            operand = (monkey.operation[2] == "old") ? item : monkey.operation[2]
            item = monkey.operation[1](item, operand)
            item = worryfn(item)
            target_monkey = (mod(item, monkey.test_divisor) == 0) ? monkey.true_monkey : monkey.false_monkey
            push!(monkeys[target_monkey+1].items, item)
        end
    end
end

function monkey_business!(monkeys, num_rounds, relief_divisor)
    for _ in 1:num_rounds
        round!(monkeys, relief_divisor)
    end
    sort!(monkeys, by=m -> m.num_inspections, rev=true)
    top_2 = monkeys[1:2]
    return prod(monkey.num_inspections for monkey in top_2)
end

function part1(filename)
    monkeys = read_monkeys(filename)
    return monkey_business!(monkeys, 20, item -> Int(floor(item / 3)))
end

function part2(filename)
    monkeys = read_monkeys(filename)
    super_modulo = prod(monkey.test_divisor for monkey in monkeys)
    return monkey_business!(monkeys, 10000, item -> mod(item, super_modulo))
end

end  # module