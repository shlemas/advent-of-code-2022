module Day10

export part1, part2

abstract type AbstractInstruction end

mutable struct Instruction <: AbstractInstruction
    cycles_remaining::Int
end

mutable struct AddXInstruction <: AbstractInstruction
    instruction::Instruction
    value::Int
    AddXInstruction(value) = new(Instruction(2), value)
end

mutable struct NoopInstruction <: AbstractInstruction
    instruction::Instruction
    NoopInstruction() = new(Instruction(1))
end

finished(instruction::Instruction) = return instruction.cycles_remaining <= 0
finished(instruction::AbstractInstruction) = return finished(instruction.instruction)

clock!(instruction::Instruction) = instruction.cycles_remaining -= 1
clock!(instruction::AbstractInstruction) = return clock!(instruction.instruction)

const Register = Int
mutable struct CPU
    x::Register
    history::Vector{Register}
    CPU() = new(1, [1])
end

record_register!(cpu::CPU) = push!(cpu.history, cpu.x)

side_effect!(::CPU, ::AbstractInstruction) = begin end
side_effect!(cpu::CPU, instruction::AddXInstruction) = cpu.x += instruction.value

function execute!(cpu::CPU, instruction::AbstractInstruction)
    while !finished(instruction)
        clock!(instruction)
        if finished(instruction)
            side_effect!(cpu, instruction)
        end
        record_register!(cpu)
    end
end

function read_instructions(filename)::Vector{AbstractInstruction}
    lines = readlines(filename)
    split_lines = map(split, lines)
    instructions = Vector{AbstractInstruction}()
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

signal_strength(cpu::CPU, cycle::Int)::Int = return cpu.history[cycle] * cycle

function render_crt(cpu::CPU)::String
    scan_lines::Vector{Vector{Char}} = [[]]
    line = 1
    pixel = 0
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