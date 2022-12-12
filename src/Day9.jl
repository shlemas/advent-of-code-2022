module Day9

function read_moves(filename)
    lines = readlines(filename)
    moves = map(split, lines)
    return map(v -> (v[1], parse(Int8, v[2])), moves)
end

function pull_rope(moves, num_knots)
    knots = [[1,1] for _ in 1:num_knots]
    tail_history = Set([Tuple([1,1])])
    for move in moves
        dir, amount = move
        while amount > 0
            if dir == "U"
                knots[1][1] += 1
            elseif dir == "D"
                knots[1][1] -= 1
            elseif dir == "R"
                knots[1][2] += 1
            elseif dir == "L"
                knots[1][2] -= 1
            end
            for i in eachindex(knots)
                if i == lastindex(knots)
                    push!(tail_history, Tuple(knots[i]))
                    break
                end

                vertical_diff   = knots[i][1] - knots[i+1][1]
                horizontal_diff = knots[i][2] - knots[i+1][2]

                pull_up    = (vertical_diff   >=  2)
                pull_down  = (vertical_diff   <= -2)
                pull_right = (horizontal_diff >=  2)
                pull_left  = (horizontal_diff <= -2)

                if pull_up
                    knots[i+1][1] += 1
                elseif pull_down
                    knots[i+1][1] -= 1
                elseif pull_left || pull_right
                    knots[i+1][1] = knots[i][1]
                end

                if pull_right
                    knots[i+1][2] += 1
                elseif pull_left
                    knots[i+1][2] -= 1
                elseif pull_up || pull_down
                    knots[i+1][2] = knots[i][2]
                end
            end
            amount -= 1
        end
    end
    return length(tail_history)
end

function part1(filename)
    moves = read_moves(filename)
    return pull_rope(moves, 2)
end

function part2(filename)
    moves = read_moves(filename)
    return pull_rope(moves, 10)
end

end  # module