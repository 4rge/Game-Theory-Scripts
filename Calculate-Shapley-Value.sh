#!/bin/bash

# Function to calculate the Shapley value for a cooperative game
function calculate_shapley_value {
    echo "Welcome to the Shapley Value Calculator!"
    echo "In cooperative game theory, the Shapley value is a way to fairly distribute the total payoff among players based on their contributions."
    echo ""
    echo "In this example, we have three players: A, B, and C, with the following coalition payoffs:"
    echo ""
    echo "Coalitions and their payoffs:"
    echo " - {A}: 10"
    echo " - {B}: 20"
    echo " - {C}: 30"
    echo " - {A, B}: 25"
    echo " - {A, C}: 35"
    echo " - {B, C}: 40"
    echo " - {A, B, C}: 50"
    echo ""

    # Define players and their coalitions with associated payoffs
    declare -A payoffs
    payoffs["A"]=10      # Total payoff for coalition {A}
    payoffs["B"]=20      # Total payoff for coalition {B}
    payoffs["C"]=30      # Total payoff for coalition {C}
    payoffs["AB"]=25     # Total payoff for coalition {A, B}
    payoffs["AC"]=35     # Total payoff for coalition {A, C}
    payoffs["BC"]=40     # Total payoff for coalition {B, C}
    payoffs["ABC"]=50    # Total payoff for coalition {A, B, C}

    # Initialize the Shapley values
    declare -A shapley_values
    shapley_values["A"]=0
    shapley_values["B"]=0
    shapley_values["C"]=0

    # Array of players
    currents=("A" "B" "C")
    n=${#currents[@]}  # Number of players
    
    for player in "${currents[@]}"; do
        for coalition in "${currents[@]}"; do
            # Ensure the coalition does not just consist of the current player
            if [[ $coalition != $player ]]; then
                # Calculate the marginal contribution of the player in the coalition
                if [[ "${payoffs[$coalition]}" && "${payoffs[$coalition$player]}" ]]; then
                    marginal_contribution=$((payoffs[$coalition$player] - payoffs[$coalition]))
                    shapley_values[$player]=$((shapley_values[$player] + marginal_contribution))
                fi
            fi
        done
    done

    # Normalize the Shapley values by the number of players
    for player in "${currents[@]}"; do
        shapley_values[$player]=$(echo "scale=2; ${shapley_values[$player]} / $n" | bc)
    done

    # Output the Shapley values
    echo "Shapley Values Distribution:"
    for player in "${currents[@]}"; do
        echo "Player $player receives: ${shapley_values[$player]}"
    done
}

# Start the cooperative game calculation
calculate_shapley_value
