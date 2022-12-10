function read_elves(filename)
    elves = []
    for line in eachline(filename)
        if isempty(elves) || isempty(line)
            push!(elves, [])
        end
        if !isempty(line)
            calories = parse(Int, line)
            push!(last(elves), calories)
        end
    end
    return elves
end

function part1(elves)
    return maximum(map(sum, elves))
end

function part2(elves)
    return sum(sort(map(sum, elves), rev=true)[1:3])
end

function day1(filename)
    elves = read_elves(filename)
    println(part1(elves))  # 70509
    println(part2(elves))  # 208567
end
