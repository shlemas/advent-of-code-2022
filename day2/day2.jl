@enum Choice rock=1 paper=2 scissors=3
@enum Outcome loss=0 draw=3 win=6

to_strategy = Dict(
    "A" => rock,
    "B" => paper,
    "C" => scissors,
    "X" => rock,
    "Y" => paper,
    "Z" => scissors,
)

to_outcome = Dict(
    "X" => loss,
    "Y" => draw,
    "Z" => win,
)

winning_strategy = Dict(
    scissors => rock,
    rock => paper,
    paper => scissors,
)

losing_strategy = Dict(value => key for (key, value) in winning_strategy)

function determine_outcome(choice1::Choice, choice2::Choice)::Outcome
    if choice1 == choice2
        return draw
    elseif (choice1, choice2) == (scissors, rock)
        return win
    elseif ((choice1, choice2) != (rock, scissors)) && (choice2 > choice1)
        return win
    end
    return loss
end

function fix_outcome(choice1::Choice, desired_outcome::Outcome)::Choice
    if desired_outcome == loss
        return losing_strategy[choice1]
    elseif desired_outcome == draw
        return choice1
    elseif desired_outcome == win
        return winning_strategy[choice1]
    end
end

function play(choice1::Choice, choice2::Choice)
    outcome = determine_outcome(choice1, choice2)
    return Int(choice2) + Int(outcome)
end

function part1(filename)
    score = 0
    for line in eachline(filename)
        player1, player2 = split(line)
        choice1 = to_strategy[player1]
        choice2 = to_strategy[player2]
        score += play(choice1, choice2)
    end
    return score
end

function part2(filename)
    score = 0
    for line in eachline(filename)
        player1, player2 = split(line)
        desired_outcome = to_outcome[player2]
        choice1 = to_strategy[player1]
        choice2 = fix_outcome(choice1, desired_outcome)
        score += play(choice1, choice2)
    end
    return score
end

function day2(filename)
    println(part1(filename))
    println(part2(filename))
end