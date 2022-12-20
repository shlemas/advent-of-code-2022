module Day13

export part1, part2

function read_packet_pairs(filename)
    pairs = []
    split_pairs = split(read(filename, String), "\n\n")
    for split_pair in split_pairs
        push!(pairs, map(eval ∘ Meta.parse, split(split_pair, "\n", keepempty=false)))
    end
    return pairs
end

function compare(left::Int64, right::Int64)
    if left < right
        return :less
    elseif left > right
        return :greater
    else
        return :equal
    end
end

function compare(left::Vector, right::Vector)
    target = (length(left) <= length(right)) ? left : right
    for i in 1:lastindex(target)
        result = compare(left[i], right[i])
        if result != :equal
            return result
        end
    end
    if length(left) < length(right)
        return :less
    elseif length(left) > length(right)
        return :greater
    else
        return :equal
    end
end

compare(left::Int64, right::Vector) = return compare([left], right)
compare(left::Vector, right::Int64) = return compare(left, [right])

lessthan(left, right) = return (compare(left, right) == :less)

function part1(filename)
    ordered_pairs = []
    pairs = read_packet_pairs(filename)
    for (i, (left, right)) in enumerate(pairs)
        if lessthan(left, right)
            push!(ordered_pairs, i)
        end
    end
    return sum(ordered_pairs)
end

function part2(filename)
    divider_packets = [[[2]], [[6]]]
    pairs = read_packet_pairs(filename)
    packets = cat(pairs..., divider_packets, dims=(1))
    sort!(packets, lt=lessthan)
    return prod(indexin(divider_packets, packets))
end

end  # module