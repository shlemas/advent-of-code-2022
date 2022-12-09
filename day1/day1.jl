function read_elves(io)
    elves = []
    for line in eachline(io)
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

function day1(io)
    elves = read_elves(io)
    println(part1(elves))
    println(part2(elves))
end
