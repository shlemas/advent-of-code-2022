module Day06

export part1, part2

function read_until_unique(data, n)
    window = []
    for (i, char) in enumerate(data)
        push!(window, char)
        if length(unique(window)) == n
            return i
        elseif length(window) >= n
            popfirst!(window)
        end
    end
    return nothing
end

function part1(filename)
    data = read(filename, String)
    return read_until_unique(data, 4)
end

function part2(filename)
    data = read(filename, String)
    return read_until_unique(data, 14)
end

end  # module