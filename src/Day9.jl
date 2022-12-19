module Day9

export part1, part2

mutable struct Knot
    x::Int
    y::Int
end

function read_moves(filename)
    lines = readlines(filename)
    moves = map(split, lines)
    return map(v -> (v[1], parse(Int8, v[2])), moves)
end

function drag_knot!(knot::Knot, direction::AbstractString)
    if direction == "U"
        knot.y += 1
    elseif direction == "D"
        knot.y -= 1
    elseif direction == "R"
        knot.x += 1
    elseif direction == "L"
        knot.x -= 1
    end
end

function drag_knot!(knot::Knot, target::Knot)
    drag_up    = ((target.y - knot.y) >=  2)
    drag_down  = ((target.y - knot.y) <= -2)
    drag_right = ((target.x - knot.x) >=  2)
    drag_left  = ((target.x - knot.x) <= -2)

    if drag_up
        knot.y += 1
    elseif drag_down
        knot.y -= 1
    elseif drag_left || drag_right
        knot.y = target.y
    end

    if drag_right
        knot.x += 1
    elseif drag_left
        knot.x -= 1
    elseif drag_up || drag_down
        knot.x = target.x
    end
end

function pull_rope(moves, num_knots)
    knots = [Knot(1,1) for _ in 1:num_knots]
    tail_history = Set([(1,1)])
    for move in moves
        direction, amount = move
        while amount > 0
            drag_knot!(knots[1], direction)
            for i in eachindex(knots)
                if i == lastindex(knots)
                    push!(tail_history, (knots[i].x, knots[i].y))
                    break
                end
                drag_knot!(knots[i+1], knots[i])
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