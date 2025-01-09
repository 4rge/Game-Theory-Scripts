#!/bin/bash

# Function to simulate the Battle of the Sexes
function battle_of_the_sexes {
    echo "Welcome to the Battle of the Sexes!"
    echo "In this game, two players choose between two strategies: A and B."
    echo "Player 1 prefers strategy A, while Player 2 prefers strategy B."
    echo "The game consists of multiple rounds, and the players will receive points based on their choices."
    echo ""
    echo "Scoring System:"
    echo " - If both players choose A (A, A), each player gets 3 points."
    echo " - If Player 1 chooses A and Player 2 chooses B (A, B), Player 1 gets 2 points, and Player 2 gets 0 points."
    echo " - If Player 1 chooses B and Player 2 chooses A (B, A), Player 1 gets 0 points, and Player 2 gets 2 points."
    echo " - If both players choose B (B, B), each player gets 1 point."
    echo ""

    # Define payoffs for the strategies
    payoffs=(3 0 2 1)  # (P1, P2)

    # Initialize scores
    score1=0
    score2=0

    # Number of rounds to simulate
    read -p "How many rounds would you like to play? " rounds

    # Loop through the number of rounds
    for (( i=0; i < rounds; i++ )); do
        echo "Round $((i + 1))"
        read -p "Player 1, choose 'A' or 'B': " strategy1
        read -p "Player 2, choose 'A' or 'B': " strategy2

        # Determine scores based on strategies chosen
        if [[ $strategy1 == "A" && $strategy2 == "A" ]]; then
            score1=$((score1 + payoffs[0]))  # P1: 3
            score2=$((score2 + payoffs[0]))  # P2: 3
            echo "Both players chose A! (A, A) -> Points: Player 1: +3, Player 2: +3"
        elif [[ $strategy1 == "A" && $strategy2 == "B" ]]; then
            score1=$((score1 + payoffs[2]))  # P1: 2
            score2=$((score2 + payoffs[3]))  # P2: 0
            echo "Player 1 chose A and Player 2 chose B! (A, B) -> Points: Player 1: +2, Player 2: +0"
        elif [[ $strategy1 == "B" && $strategy2 == "A" ]]; then
            score1=$((score1 + payoffs[3]))  # P1: 0
            score2=$((score2 + payoffs[2]))  # P2: 2
            echo "Player 1 chose B and Player 2 chose A! (B, A) -> Points: Player 1: +0, Player 2: +2"
        elif [[ $strategy1 == "B" && $strategy2 == "B" ]]; then
            score1=$((score1 + payoffs[1]))  # P1: 1
            score2=$((score2 + payoffs[1]))  # P2: 1
            echo "Both players chose B! (B, B) -> Points: Player 1: +1, Player 2: +1"
        else
            echo "Invalid input. Please choose 'A' or 'B'."
            ((i--))  # Repeat round for invalid input
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

# Start the game
battle_of_the_sexes
