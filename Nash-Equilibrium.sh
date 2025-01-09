#!/bin/bash

# This Bash script checks for Nash equilibria in a two-player game using a randomly generated payout matrix.

# This function checks if there is a Nash equilibrium given the values in the payoff matrix.
function check_nash_equilibrium {
    local payoff_matrix=("$@")
  
    echo "Payoff Matrix (P1, P2):"
    echo "P1 Strategy 0 vs P2 Strategy 0: ${payoff_matrix[0]} / ${payoff_matrix[1]}"
    echo "P1 Strategy 0 vs P2 Strategy 1: ${payoff_matrix[2]} / ${payoff_matrix[3]}"
    echo "P1 Strategy 1 vs P2 Strategy 0: ${payoff_matrix[4]} / ${payoff_matrix[5]}"
    echo "P1 Strategy 1 vs P2 Strategy 1: ${payoff_matrix[6]} / ${payoff_matrix[7]}"
    echo ""

    # The outer loop checks Player 1's strategies (Two options: 0 or 1)
    for player1_strategy in {0..1}; do
        # The inner loop checks Player 2's strategies (Two options: 0 or 1)
        for player2_strategy in {0..1}; do
            
            # Get the payoffs for the current strategies of both players
            p1_payoff=${payoff_matrix[$((player1_strategy * 4 + player2_strategy * 2))]}
            p2_payoff=${payoff_matrix[$((player1_strategy * 4 + player2_strategy * 2 + 1))]}
            
            # Assume that the current strategy is the best response for Player 1
            best_response_for_p1=1
            # Check if Player 1 can get a better payoff by switching strategies
            if [[ ${payoff_matrix[$((0 + player2_strategy * 2))]} -ge $p1_payoff ]]; then
                best_response_for_p1=0
            fi
            
            # Assume that the current strategy is the best response for Player 2
            best_response_for_p2=1
            # Check if Player 2 can get a better payoff by switching strategies
            if [[ ${payoff_matrix[$((2 + player1_strategy * 2))]} -ge $p2_payoff ]]; then
                best_response_for_p2=0
            fi
            
            # If neither player can improve their payoff by changing their strategy, we found a Nash Equilibrium
            if [[ $best_response_for_p1 -eq $player1_strategy && $best_response_for_p2 -eq $player2_strategy ]]; then
                echo "Nash Equilibrium found: Player 1 uses Strategy $player1_strategy, Player 2 uses Strategy $player2_strategy"
            fi
        done
    done
}

# Function to generate a fair payout matrix
function generate_fair_payout_matrix {
    # Random payouts for each player's strategy combination, ensuring fairness.
    local payouts=()
    for (( i=0; i<4; i++ )); do
        payouts+=($(( RANDOM % 6 ))) # Add a random payout between 0 and 5
    done
    echo "${payouts[@]}"
}

# Generate a fair payout matrix
read -a payoff_matrix <<< $(generate_fair_payout_matrix)

# Display the available strategies to the players
echo "Choose your strategies! Each player should choose either 0 or 1."

# Player 1 chooses their strategy
echo "Player 1, choose your strategy (0 or 1): "
read -s player1_choice

# Player 2 chooses their strategy (this is done after Player 1's choice, but hidden)
echo "Player 2, choose your strategy (0 or 1): "
read -s player2_choice

# Validate user input for both players
if [[ ! "$player1_choice" =~ ^[0-1]$ || ! "$player2_choice" =~ ^[0-1]$ ]]; then
    echo "Invalid input! Please choose 0 or 1."
    exit 1
fi

# Call the function to check for Nash equilibria
check_nash_equilibrium "${payoff_matrix[@]}"

# Display the results based on the player's choices
echo "Player 1 chose: Strategy $player1_choice"
echo "Player 2 chose: Strategy $player2_choice"
p1_output=${payoff_matrix[$((player1_choice * 4 + player2_choice * 2))]}
p2_output=${payoff_matrix[$((player1_choice * 4 + player2_choice * 2 + 1))]}
echo "Result of your choices: Player 1: $p1_output, Player 2: $p2_output"
