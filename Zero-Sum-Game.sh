#!/bin/bash

# Function to simulate a Zero-Sum Game
function zero_sum_game {
    echo "Welcome to the Zero-Sum Game!"
    echo "In this game, there are two players: Player 1 and Player 2."
    echo "Every point one player earns is a point that the other player loses."
    echo ""
    echo "The game consists of multiple rounds where players select their strategies."
    echo "Here’s the payoff matrix for both players:"
    echo ""
    echo "              Player 2"
    echo "             | Column 1 | Column 2 "
    echo "-------------------------------------"
    echo "   Row 1  |   (3, -3)   |   (-1, 1)   "
    echo "   Row 2  |   (0, 0)     |   (2, -2)   "
    echo ""
    echo "This means:"
    echo " - If Player 1 chooses Row 1 and Player 2 chooses Column 1, Player 1 wins 3 points, and Player 2 loses 3 points."
    echo " - If Player 1 chooses Row 1 and Player 2 chooses Column 2, Player 1 wins -1 points (loses), and Player 2 gains 1 point."
    echo " - If Player 1 chooses Row 2 and Player 2 chooses Column 1, Player 1 earns 0 points, and Player 2 earns 0 points."
    echo " - If Player 1 chooses Row 2 and Player 2 chooses Column 2, Player 1 earns 2 points, and Player 2 loses 2 points."
    echo ""

    # Initialize scores
    score1=0
    score2=0

    # Number of rounds to simulate
    read -p "How many rounds would you like to play? " rounds

    # Loop through the number of rounds
    for (( i=0; i < rounds; i++ )); do
        echo "Round $((i + 1))"
        echo "Player 1, choose your strategy:"
        echo " (1) Row 1"
        echo " (2) Row 2"
        read -p "Enter your choice: " p1_choice

        echo "Player 2, choose your strategy:"
        echo " (1) Column 1"
        echo " (2) Column 2"
        read -p "Enter your choice: " p2_choice

        # Determine indices based on chosen strategies
        case $p1_choice in
            1)
                row_index=0
                ;;
            2)
                row_index=1
                ;;
            *)
                echo "Invalid choice for Player 1. Please choose 1 or 2."
                ((i--))  # Repeat round for invalid input
                continue
                ;;
        esac
        
        case $p2_choice in
            1)
                col_index=0
                ;;
            2)
                col_index=1
                ;;
            *)
                echo "Invalid choice for Player 2. Please choose 1 or 2."
                ((i--))  # Repeat round for invalid input
                continue
                ;;
        esac

        # Define the payoff matrix
        payoff_matrix=(
            3 -1  # Row 1 results
            0 2   # Row 2 results
        )

        # Update scores based on chosen strategies
        score1=$((score1 + payoff_matrix[$row_index * 2 + $col_index]))
        score2=$((score2 - payoff_matrix[$row_index * 2 + $col_index]))  # Zero-sum, so opposite for player 2

        # Display current scores
        echo "Points awarded this round: Player 1: ${payoff_matrix[$row_index * 2 + $col_index]}, Player 2: $((-payoff_matrix[$row_index * 2 + $col_index]))"
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
zero_sum_game
