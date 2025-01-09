#!/bin/bash

# Function to simulate mixed strategies
function mixed_strategies {
    local rounds=$1

    echo "Welcome to the Mixed Strategies Game Simulation!"
    echo "In this game, there are two players, each choosing from two strategies:"
    echo " - Player 1 can choose Strategy A or B."
    echo " - Player 2 can choose Strategy X or Y."
    echo ""
    echo "Here’s the payoff table for each combination of strategies:"
    echo ""
    echo "                Player 2"
    echo "             |   X   |   Y   "
    echo "---------------------------------"
    echo "   A       | (3, 2) | (0, 5) "
    echo "   B       | (5, 0) | (1, 1) "
    echo ""
    echo "This means:"
    echo " - If Player 1 chooses A and Player 2 chooses X, Player 1 scores 3 points while Player 2 scores 2 points."
    echo " - If Player 1 chooses A and Player 2 chooses Y, Player 1 scores 0 points and Player 2 scores 5 points."
    echo " - If Player 1 chooses B and Player 2 chooses X, Player 1 scores 5 points and Player 2 scores 0 points."
    echo " - If Player 1 chooses B and Player 2 chooses Y, both players score 1 point."
    echo ""

    # Initialize scores
    local score1=0
    local score2=0

    # Simulate the rounds based on random choices
    for ((i = 0; i < rounds; i++)); do
        # Generate random choices for each player
        rand1=$(( RANDOM % 2 ))  # 0 or 1 for Player 1
        rand2=$(( RANDOM % 2 ))  # 0 or 1 for Player 2

        # Choose strategies based on random number generated
        if [[ $rand1 -eq 0 ]]; then
            strategy1="A"
        else
            strategy1="B"
        fi

        if [[ $rand2 -eq 0 ]]; then
            strategy2="X"
        else
            strategy2="Y"
        fi

        # Payoff logic based on chosen strategies
        if [[ $strategy1 == "A" && $strategy2 == "X" ]]; then
            score1=$((score1 + 3))
            score2=$((score2 + 2))
        elif [[ $strategy1 == "A" && $strategy2 == "Y" ]]; then
            score1=$((score1 + 0))
            score2=$((score2 + 5))
        elif [[ $strategy1 == "B" && $strategy2 == "X" ]]; then
            score1=$((score1 + 5))
            score2=$((score2 + 0))
        elif [[ $strategy1 == "B" && $strategy2 == "Y" ]]; then
            score1=$((score1 + 1))
            score2=$((score2 + 1))
        fi

        # Display round results
        echo "Round $((i + 1)): Player 1 chose $strategy1, Player 2 chose $strategy2."
        echo "Current Scores - Player 1: $score1, Player 2: $score2"
        echo ""
    done

    # Display final scores
    echo "Final Scores after $rounds rounds - Player 1: $score1, Player 2: $score2"
    if [ $score1 -gt $score2 ]; then
        echo "Player 1 wins!"
    elif [ $score1 -lt $score2 ]; then
        echo "Player 2 wins!"
    else
        echo "It's a tie!"
    fi
}

# Number of rounds to simulate
read -p "Enter the number of rounds to play: " rounds

# Start the mixed strategies simulation
mixed_strategies $rounds
