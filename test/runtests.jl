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

@test AdventOfCode.Day5.part1("day5-input.txt") == "VPCDMSLWJ"
@test AdventOfCode.Day5.part2("day5-input.txt") == "TPWCGNCCG"

@test AdventOfCode.Day6.part1("day6-input.txt") == 1802
@test AdventOfCode.Day6.part2("day6-input.txt") == 3551

@test AdventOfCode.Day7.part1("day7-input.txt") == 1243729
@test AdventOfCode.Day7.part2("day7-input.txt") == 4443914

@test AdventOfCode.Day8.part1("day8-input.txt") == 1719
@test AdventOfCode.Day8.part2("day8-input.txt") == 590824