module Day10

abstract type AbstractInstruction end

mutable struct AddXInstruction <: AbstractInstruction
    cycles_remaining::Int
    value::Int
    AddXInstruction(value) = new(2, value)
end

mutable struct NoopInstruction <: AbstractInstruction
    cycles_remaining::Int
    NoopInstruction() = new(1)
end

const Register = Int

mutable struct CPU
    x::Register
    history::Vector{Register}
    CPU() = new(1, [1])
end

function side_effect!(::CPU, ::AbstractInstruction) end
function side_effect!(cpu::CPU, instruction::AddXInstruction)
    cpu.x += instruction.value
end

function execute!(cpu::CPU, instruction::AbstractInstruction)
    while instruction.cycles_remaining > 0
        instruction.cycles_remaining -= 1
        if instruction.cycles_remaining == 0
            side_effect!(cpu, instruction)
        end
        push!(cpu.history, cpu.x)
    end
end

function read_instructions(filename)
    lines = readlines(filename)
    split_lines = map(split, lines)
    instructions = []
    for line in split_lines
        if line[1] == "addx"
            push!(instructions, AddXInstruction(parse(Int, line[2])))
        elseif line[1] == "noop"
            push!(instructions, NoopInstruction())
        else
            error("invalid instruction")
        end
    end
    return instructions
end

function signal_strength(cpu::CPU, cycle::Int)
    return cpu.history[cycle] * cycle
end

function render_crt(cpu::CPU)
    scan_lines::Vector{Vector{Char}} = [[]]
    line, pixel = 1, 0
    for x in cpu.history
        if pixel in (x-1):(x+1)
            push!(scan_lines[end], '#')
        else
            push!(scan_lines[end], '.')
        end
        if pixel < 39
            pixel += 1
        elseif line < 6
            pixel = 0
            line += 1
            push!(scan_lines, [])
        else
            break
        end
    end
    return SubstitutionString(join(map(String, scan_lines), "\n"))
end

function part1(filename)
    instructions = read_instructions(filename)
    cpu = CPU()
    for instruction in instructions
        execute!(cpu, instruction)
    end
    return sum(signal_strength(cpu, i) for i in [20, 60, 100, 140, 180, 220])
end

function part2(filename)
    instructions = read_instructions(filename)
    cpu = CPU()
    for instruction in instructions
        execute!(cpu, instruction)
    end
    return render_crt(cpu)
end

end  # module