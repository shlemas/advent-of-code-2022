module Day4

export part1, part2

function parse_sections(line::String)::Tuple{UnitRange, UnitRange}
    split_ints(section) = map(s -> parse(Int, s), map(String, split(section, "-")))
    section1, section2 = split(line, ",")
    section1_start, section1_end = split_ints(section1)
    section2_start, section2_end = split_ints(section2)
    return section1_start:section1_end, section2_start:section2_end
end

function process_sections(filename::String, predicate::Function)::Int
    count = 0
    for line in eachline(filename)
        section1, section2 = parse_sections(line)
        if predicate(section1, section2)
            count += 1
        end
    end
    return count
end

function part1(filename)
    predicate(s1, s2) = issubset(s1, s2) || issubset(s2, s1)
    return process_sections(filename, predicate)
end

function part2(filename)
    predicate(s1, s2) = !isempty(intersect(s1, s2))
    return process_sections(filename, predicate)
end

end  # module