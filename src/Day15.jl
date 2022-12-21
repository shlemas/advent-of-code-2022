module Day15

export part1, part2

using SparseArrays

const Point = Tuple{Int, Int}

struct Sensor
    location::Point
    closest_beacon::Point
end

manhattan_distance(p1::Point, p2::Point) = return abs(p1[1] - p2[1]) + abs(p1[2] - p2[2])
distance_to_closest_beacon(sensor::Sensor) = return manhattan_distance(sensor.location, sensor.closest_beacon)
distance_to_row(sensor::Sensor, row::Int) = abs(sensor.location[2] - row)

function reserved_in_row(sensor::Sensor, row::Int)::Union{UnitRange{Int}, Nothing}
    num_reserved = distance_to_closest_beacon(sensor) - distance_to_row(sensor, row)
    return (num_reserved >= 0) ? ((sensor.location[1] - num_reserved):(sensor.location[1] + num_reserved)) : nothing
end

function reserved_in_row(sensors::Vector{Sensor}, row::Int)::Set{Int}
    reserved = Set{Int}()
    for sensor in sensors
        reserved_indexes = reserved_in_row(sensor, row)
        if reserved_indexes !== nothing
            union!(reserved, reserved_indexes)
        end
        if sensor.closest_beacon[2] == row
            delete!(reserved, sensor.closest_beacon[1])
        end
    end
    return reserved
end

function filter_hidden_beacon!(reserved::Set{Int}, search_range::UnitRange{Int})
    intersect!(reserved, search_range)
    setdiff!(reserved, search_range)
end

function read_sensors(filename)::Vector{Sensor}
    sensors::Vector{Sensor} = []
    for line in readlines(filename)
        m = match(r"Sensor at x=(-?\d+), y=(-?\d+): closest beacon is at x=(-?\d+), y=(-?\d+)", line)
        captures = map(Meta.parse, m.captures)
        location = Point(captures[1:2])
        closest_beacon = Point(captures[3:4])
        push!(sensors, Sensor(location, closest_beacon))
    end
    return sensors
end

function part1(filename)
    sensors = read_sensors(filename)
    reserved = reserved_in_row(sensors, 2000000)
    return length(reserved)
end

function part2(filename)
    sensors = read_sensors(filename)
    matrix = spzeros(Int, 4000001, 4000001)
    # TODO
    return true
end

end  # module