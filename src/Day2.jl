module Day2

export part1, part2

abstract type RockPaperScissors end
struct Rock <: RockPaperScissors end
struct Paper <: RockPaperScissors end
struct Scissors <: RockPaperScissors end

abstract type AbstractOutcome end
struct Loss <: AbstractOutcome end
struct Draw <: AbstractOutcome end
struct Win <: AbstractOutcome end

points(::Rock) = 1
points(::Paper) = 2
points(::Scissors) = 3
points(::Loss) = 0
points(::Draw) = 3
points(::Win) = 6

winning_strategy(::Rock) = Paper()
winning_strategy(::Paper) = Scissors()
winning_strategy(::Scissors) = Rock()

losing_strategy(::Rock) = Scissors()
losing_strategy(::Paper) = Rock()
losing_strategy(::Scissors) = Paper()

to_strategy = Dict(
    "A" => Rock(),
    "B" => Paper(),
    "C" => Scissors(),
    "X" => Rock(),
    "Y" => Paper(),
    "Z" => Scissors(),
)

to_outcome = Dict(
    "X" => Loss(),
    "Y" => Draw(),
    "Z" => Win(),
)

function determine_outcome(choice1::RockPaperScissors, choice2::RockPaperScissors)
    if choice1 == choice2
        return Draw()
    end
    return (winning_strategy(choice1) == choice2) ? Win() : Loss()
end

function fix_outcome(choice1::RockPaperScissors, desired_outcome::AbstractOutcome)
    if desired_outcome == Loss()
        return losing_strategy(choice1)
    elseif desired_outcome == Draw()
        return choice1
    elseif desired_outcome == Win()
        return winning_strategy(choice1)
    end
end

function play(choice1::RockPaperScissors, choice2::RockPaperScissors)
    outcome = determine_outcome(choice1, choice2)
    return points(choice2) + points(outcome)
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

end  # module