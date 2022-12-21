module Day14

export part1, part2

mutable struct Grid
    data::Matrix{Char}
    has_floor::Bool

    function Grid(paths::Vector, has_floor=false)
        dims = get_grid_dims(paths)
        grid = fill('.', dims...)
        for path in paths
            prev = nothing
            for coord in path
                grid[coord[2], coord[1]] = '#'
                if prev !== nothing
                    for row_between in coord_range(prev, coord, 1)
                        grid[coord[2], row_between] = '#'
                    end
                    for col_between in coord_range(prev, coord, 2)
                        grid[col_between, coord[1]] = '#'
                    end
                end
                prev = coord
            end
        end
        grid[1, 501] = '+'
        if has_floor
            grid = vcat(grid, fill('.', (1, size(grid, 2))))
            grid = vcat(grid, fill('#', (1, size(grid, 2))))
        end
        return new(grid, has_floor)
    end
end

get_tile(grid::Grid, coord) = return grid.data[coord...]
set_tile!(grid::Grid, coord, tile::Char) = grid.data[coord...] = tile
is_within_grid(grid::Grid, coord) = return checkbounds(Bool, grid.data, coord...)
is_blocking_tile(grid::Grid, coord) = return (get_tile(grid, coord) in ['#', 'o'])
is_open_tile(grid::Grid, coord) = return (is_within_grid(grid, coord) && !is_blocking_tile(grid, coord))

function resize_to_fit!(grid::Grid, coord)
    grid_resized = false
    while !is_within_grid(grid, coord)
        grid.data = hcat(grid.data, fill('.', (size(grid.data, 1), 1)))
        grid.data[end, end] = '#'
        grid_resized = true
    end
    return grid_resized
end

function drop_sand!(grid::Grid)
    rest = false
    coord = (1, 501)
    if get_tile(grid, coord) == 'o'
        return false
    end
    while true
        down = (coord[1] + 1, coord[2])
        down_left = (coord[1] + 1, coord[2] - 1)
        down_right = (coord[1] + 1, coord[2] + 1)
        if is_open_tile(grid, down)
            coord = down
        elseif is_open_tile(grid, down_left)
            coord = down_left
        elseif is_open_tile(grid, down_right)
            coord = down_right
        else
            if grid.has_floor && !is_within_grid(grid, down_right)
                resize_to_fit!(grid, down_right)
                rest = drop_sand!(grid)
            else
                rest = (is_within_grid(grid, down_left) && is_within_grid(grid, down_right))
            end
            break
        end
    end
    if rest
        set_tile!(grid, coord, 'o')
    end
    return rest
end

function save_grid(grid::Grid, name)
    open(name, "w") do io
        for row in eachrow(grid.data)
            println(io, String(row))
        end
    end
end

function populate_grid!(grid::Grid)
    count = 0
    while drop_sand!(grid)
        count += 1
    end
    return count
end

coord_range(c1, c2, axis) = return range(sort([c1[axis], c2[axis]])...)

function read_paths(filename)
    paths = []
    for line in readlines(filename)
        path = [map(Meta.parse, match.captures) for match in eachmatch(r"(\d+),(\d+)", line)]
        path = map(c -> (c[1] + 1, c[2] + 1), path)
        push!(paths, path)
    end
    return paths
end

function get_grid_dims(paths)
    rows = 1
    cols = 1
    for path in paths
        rows = max(rows, maximum(map(last, path)))
        cols = max(cols, maximum(map(first, path)))
    end
    return rows, cols
end

function part1(filename)
    paths = read_paths(filename)
    grid = Grid(paths, false)
    count = populate_grid!(grid)
    return count
end

function part2(filename)
    paths = read_paths(filename)
    grid = Grid(paths, true)
    count = populate_grid!(grid)
    return count
end

end  # module