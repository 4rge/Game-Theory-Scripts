#!/bin/bash

# Function to simulate the Prisoner's Dilemma
function prisoners_dilemma {
    local rounds=$1
    local score1=0
    local score2=0

    echo "Welcome to the Prisoner's Dilemma Game!"
    echo "In this game, you and another player will make decisions to either Cooperate (C) or Defect (D)."
    echo "Your choices will lead to different outcomes, and the goal is to maximize your score over $rounds rounds."
    echo ""
    echo "Scoring System:"
    echo " - If both players Cooperate (C, C), each gets 3 points."
    echo " - If Player 1 Cooperates and Player 2 Defects (C, D), Player 1 gets 0 and Player 2 gets 5 points."
    echo " - If Player 1 Defects and Player 2 Cooperates (D, C), Player 1 gets 5 and Player 2 gets 0 points."
    echo " - If both players Defect (D, D), each gets 1 point."
    echo ""

    for (( i=0; i < rounds; i++ )); do
        # Prompt each player for their strategy
        read -p "Round $((i + 1)): Player 1, choose 'C' to Cooperate or 'D' to Defect: " strategy1
        read -p "Round $((i + 1)): Player 2, choose 'C' to Cooperate or 'D' to Defect: " strategy2
        
        # Payoff logic
        if [[ $strategy1 == "C" && $strategy2 == "C" ]]; then
            score1=$((score1 + 3))
            score2=$((score2 + 3))
            echo "Both players Cooperate! (C, C) -> Points: Player 1: +3, Player 2: +3"
        elif [[ $strategy1 == "C" && $strategy2 == "D" ]]; then
            score1=$((score1 + 0))
            score2=$((score2 + 5))
            echo "Player 1 Cooperates and Player 2 Defects! (C, D) -> Points: Player 1: +0, Player 2: +5"
        elif [[ $strategy1 == "D" && $strategy2 == "C" ]]; then
            score1=$((score1 + 5))
            score2=$((score2 + 0))
            echo "Player 1 Defects and Player 2 Cooperates! (D, C) -> Points: Player 1: +5, Player 2: +0"
        elif [[ $strategy1 == "D" && $strategy2 == "D" ]]; then
            score1=$((score1 + 1))
            score2=$((score2 + 1))
            echo "Both players Defect! (D, D) -> Points: Player 1: +1, Player 2: +1"
        else
            echo "Invalid input. Please choose 'C' or 'D'."
            ((i--))  # Repeat round for invalid input
            continue
        fi

        # Display current scores
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

# Number of rounds to play
rounds=5
# Start the game
prisoners_dilemma $rounds
