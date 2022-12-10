import AdventOfCode

using Test

@test AdventOfCode.Day1.part1("day1-input.txt") == 70509
@test AdventOfCode.Day1.part2("day1-input.txt") == 208567

@test AdventOfCode.Day2.part1("day2-input.txt") == 13675
@test AdventOfCode.Day2.part2("day2-input.txt") == 14184

@test AdventOfCode.Day3.part1("day3-input.txt") == 7863
@test AdventOfCode.Day3.part2("day3-input.txt") == 2488

@test AdventOfCode.Day4.part1("day4-input.txt") == 542
@test AdventOfCode.Day4.part2("day4-input.txt") == 900