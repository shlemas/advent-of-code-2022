priority = Dict(zip(['a':'z'; 'A':'Z'], 1:52))

function part1(filename)
    score = 0
    for line in eachline(filename)
        middle = length(line) ÷ 2
        left = line[begin:middle]
        right = line[middle+1:end]
        shared_items = intersect(Set(left), Set(right))
        score += sum(priority[i] for i in shared_items)
    end
    return score
end

function part2(filename)
    score = 0
    open(filename, "r") do f
        while true
            elf1 = readline(f)
            elf2 = readline(f)
            elf3 = readline(f)
            shared_items = intersect(Set(elf1), Set(elf2), Set(elf3))
            score += sum(priority[i] for i in shared_items)
            if eof(f)
                break
            end
        end
    end
    return score
end

function day3(filename)
    println(part1(filename))
    println(part2(filename))
end