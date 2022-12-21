import AdventOfCode

using Test

@test AdventOfCode.Day01.part1("day01-input.txt") == 70509
@test AdventOfCode.Day01.part2("day01-input.txt") == 208567

@test AdventOfCode.Day02.part1("day02-input.txt") == 13675
@test AdventOfCode.Day02.part2("day02-input.txt") == 14184

@test AdventOfCode.Day03.part1("day03-input.txt") == 7863
@test AdventOfCode.Day03.part2("day03-input.txt") == 2488

@test AdventOfCode.Day04.part1("day04-input.txt") == 542
@test AdventOfCode.Day04.part2("day04-input.txt") == 900

@test AdventOfCode.Day05.part1("day05-input.txt") == "VPCDMSLWJ"
@test AdventOfCode.Day05.part2("day05-input.txt") == "TPWCGNCCG"

@test AdventOfCode.Day06.part1("day06-input.txt") == 1802
@test AdventOfCode.Day06.part2("day06-input.txt") == 3551

@test AdventOfCode.Day07.part1("day07-input.txt") == 1243729
@test AdventOfCode.Day07.part2("day07-input.txt") == 4443914

@test AdventOfCode.Day08.part1("day08-input.txt") == 1719
@test AdventOfCode.Day08.part2("day08-input.txt") == 590824

@test AdventOfCode.Day09.part1("day09-input.txt") == 6087
@test AdventOfCode.Day09.part2("day09-input.txt") == 2493

@test AdventOfCode.Day10.part1("day10-input.txt") == 13740
@test AdventOfCode.Day10.part2("day10-input.txt") ==
"""
####.#..#.###..###..####.####..##..#....
...#.#..#.#..#.#..#.#....#....#..#.#....
..#..#..#.#..#.#..#.###..###..#....#....
.#...#..#.###..###..#....#....#....#....
#....#..#.#....#.#..#....#....#..#.#....
####..##..#....#..#.#....####..##..####."""

@test AdventOfCode.Day11.part1("day11-input.txt") == 99840
@test AdventOfCode.Day11.part2("day11-input.txt") == 20683044837

@test AdventOfCode.Day12.part1("day12-input.txt") == 394
@test AdventOfCode.Day12.part2("day12-input.txt") == 388

@test AdventOfCode.Day13.lessthan([1,1,3,1,1], [1,1,5,1,1])
@test AdventOfCode.Day13.lessthan([[1],[2,3,4]], [[1],4])
@test !AdventOfCode.Day13.lessthan([9], [[8,7,6]])
@test AdventOfCode.Day13.lessthan([[4,4],4,4], [[4,4],4,4,4])
@test !AdventOfCode.Day13.lessthan([7,7,7,7], [7,7,7])
@test AdventOfCode.Day13.lessthan([], [3])
@test !AdventOfCode.Day13.lessthan([[[]]], [[]])
@test !AdventOfCode.Day13.lessthan([1,[2,[3,[4,[5,6,7]]]],8,9], [1,[2,[3,[4,[5,6,0]]]],8,9])
@test AdventOfCode.Day13.part1("day13-input.txt") == 5366
@test AdventOfCode.Day13.part2("day13-input.txt") == 23391

@test AdventOfCode.Day14.part1("day14-input.txt") == 757
@test AdventOfCode.Day14.part2("day14-input.txt") == 24943