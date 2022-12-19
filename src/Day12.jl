module Day12

export part1, part2

using Graphs

struct Peak
    elevation::Char
    vertex::Int
    starting::Bool
    target::Bool

    function Peak(char, vertex)
        elevation = char
        starting = false
        target = false
        if char == 'S'
            elevation = 'a'
            starting = true
        elseif char == 'E'
            elevation = 'z'
            target = true
        end
        return new(elevation, vertex, starting, target)
    end
end

function read_peaks(filename)
    lines = readlines(filename)
    width = length(lines[begin])
    height = length(lines)
    peaks = Array{Peak}(undef, height, width)
    vertex = 1
    for (row, line) in enumerate(lines)
        for (col, char) in enumerate(line)
            peaks[row, col] = Peak(char, vertex)
            vertex += 1
        end
    end
    return peaks
end

function build_graph(peaks)
    graph = DiGraph(length(peaks))
    for i in CartesianIndices(peaks)
        row, col = Tuple(i)
        peak = peaks[row, col]
        up = (row > firstindex(peaks, 1)) ? peaks[row-1, col] : nothing
        down = (row < lastindex(peaks, 1)) ? peaks[row+1, col] : nothing
        left = (col > firstindex(peaks, 2)) ? peaks[row, col-1] : nothing
        right = (col < lastindex(peaks, 2)) ? peaks[row, col+1] : nothing
        for other in [up, down, left, right]
            if other !== nothing && Int(other.elevation) <= (Int(peak.elevation) + 1)
                add_edge!(graph, peak.vertex, other.vertex)
            end
        end
    end
    return graph
end

function find_starting(peaks)
    return [peak for peak in peaks if peak.starting][begin]
end

function find_target(peaks)
    return [peak for peak in peaks if peak.target][begin]
end

function find_lowest_elevations(peaks)
    return [peak for peak in peaks if peak.elevation in ['S', 'a']]
end

function part1(filename)
    peaks = read_peaks(filename)
    graph = build_graph(peaks)
    starting = find_starting(peaks)
    target = find_target(peaks)
    paths = dijkstra_shortest_paths(graph, starting.vertex)
    return paths.dists[target.vertex]
end

function part2(filename)
    peaks = read_peaks(filename)
    graph = reverse(build_graph(peaks))
    target = find_target(peaks)
    lowest_elevations = find_lowest_elevations(peaks)
    paths = dijkstra_shortest_paths(graph, target.vertex)
    distances = [paths.dists[peak.vertex] for peak in lowest_elevations]
    return sort(distances)[begin]
end

end  # module