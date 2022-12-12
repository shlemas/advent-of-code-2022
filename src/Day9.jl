module Day9

function read_moves(filename)
    lines = readlines(filename)
    moves = map(split, lines)
    return map(v -> (v[1], parse(Int8, v[2])), moves)
end

function pull_rope(moves, num_knots)
    knots = [[1,1] for _ in 1:num_knots]
    tpos_history = Set([Tuple([1,1])])
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
                    push!(tpos_history, Tuple(knots[i]))
                    break
                end

                up    = (knots[i][1] - knots[i+1][1] >  1)
                down  = (knots[i][1] - knots[i+1][1] < -1)
                right = (knots[i][2] - knots[i+1][2] >  1)
                left  = (knots[i][2] - knots[i+1][2] < -1)

                if up
                    knots[i+1][1] = knots[i][1] - 1
                elseif down
                    knots[i+1][1] = knots[i][1] + 1
                elseif left || right
                    knots[i+1][1] = knots[i][1]
                end

                if right
                    knots[i+1][2] = knots[i][2] - 1
                elseif left
                    knots[i+1][2] = knots[i][2] + 1
                elseif up || down
                    knots[i+1][2] = knots[i][2]
                end
            end
            amount -= 1
        end
    end
    return length(tpos_history)
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