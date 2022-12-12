module Day8

function read_trees(filename)
    lines = readlines(filename)
    width = length(lines[begin])
    height = length(lines)
    trees = zeros(Int8, width, height)
    for (row, line) in enumerate(lines)
        for (col, char) in enumerate(line)
            trees[row, col] = parse(Int8, char)
        end
    end
    return trees
end

function find_visible_trees(enumeration)
    visible_trees = []
    max_so_far = -1
    for (i, tree) in enumeration
        if tree > max_so_far
            push!(visible_trees, i)
            max_so_far = tree
        end
    end
    return visible_trees
end

function directional_scenic_score(tree, range, lookupfn)
    score = 0
    for i in range
        score += 1
        if lookupfn(i) >= tree
            break
        end
    end
    return score
end

function highest_scenic_score(trees)
    highest_score = 0
    for i in CartesianIndices(trees)
        row, col = Tuple(i)
        tree = trees[row, col]

        left  = directional_scenic_score(tree, (col-1):-1:1,             c -> trees[row, c])
        right = directional_scenic_score(tree, (col+1):1:size(trees, 2), c -> trees[row, c])
        up    = directional_scenic_score(tree, (row-1):-1:1,             r -> trees[r, col])
        down  = directional_scenic_score(tree, (row+1):1:size(trees, 1), r -> trees[r, col])

        highest_score = max(highest_score, left * right * up * down)
    end
    return highest_score
end

function part1(filename)
    trees = read_trees(filename)
    visible_trees = Set()
    for (r, row) in enumerate(eachrow(trees))
        union!(visible_trees, [(r, c) for c in find_visible_trees(enumerate(row))])
        union!(visible_trees, [(r, c) for c in find_visible_trees(Iterators.reverse(enumerate(row)))])
    end
    for (c, col) in enumerate(eachcol(trees))
        union!(visible_trees, [(r, c) for r in find_visible_trees(enumerate(col))])
        union!(visible_trees, [(r, c) for r in find_visible_trees(Iterators.reverse(enumerate(col)))])
    end
    return length(visible_trees)
end

function part2(filename)
    trees = read_trees(filename)
    return highest_scenic_score(trees)
end

end  # module