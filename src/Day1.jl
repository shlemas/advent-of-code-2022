module Day1

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

function part1(filename)
    elves = read_elves(filename)
    return maximum(map(sum, elves))
end

function part2(filename)
    elves = read_elves(filename)
    return sum(sort(map(sum, elves), rev=true)[1:3])
end

end  # module