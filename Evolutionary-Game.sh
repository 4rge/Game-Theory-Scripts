#!/bin/bash

# Function to simulate an evolutionary dynamic between cooperators and defectors
function evolutionary_game {
    local rounds=$1
    local initial_cooperators=$2
    local initial_defectors=$3
    local population=$((initial_cooperators + initial_defectors))

    # Payoff values
    local payoff_cooperator=3  # Payoff for cooperators
    local payoff_defector=5     # Payoff for defectors

    # Initialize counts for cooperators and defectors
    cooperators=$initial_cooperators
    defectors=$initial_defectors

    echo "Welcome to the Evolutionary Game Simulation!"
    echo "-----------------------------------------------"
    echo "Initial Population - Cooperators: $cooperators, Defectors: $defectors"
    echo ""

    for (( round=1; round<=rounds; round++ )); do
        # Calculate total payoffs for the current population
        local total_payoff_cooperators=$((cooperators * payoff_cooperator + defectors * payoff_defector))
        local total_payoff_defectors=$((defectors * payoff_defector))

        # Calculate the fitness of cooperators and defectors
        local fitness_cooperators=$(echo "scale=2; $total_payoff_cooperators / $population" | bc)
        local fitness_defectors=$(echo "scale=2; $total_payoff_defectors / $population" | bc)

        # Update strategy frequency based on fitness
        local new_cooperators=$(echo "scale=2; $cooperators + ($fitness_cooperators * 0.1)" | bc)
        local new_defectors=$(echo "scale=2; $defectors - ($fitness_defectors * 0.1)" | bc)

        # Normalize to ensure the total matches the initial population
        total_fitness=$(echo "$new_cooperators + $new_defectors" | bc)
        cooperators=$(echo "scale=2; $new_cooperators / $total_fitness * $population" | bc)
        defectors=$(echo "scale=2; $new_defectors / $total_fitness * $population" | bc)

        # Output the results of the current round
        echo "Round $round - Cooperators: $cooperators, Defectors: $defectors"
    done

    echo "-----------------------------------------------"
    echo "Simulation complete!"
    echo "Final counts - Cooperators: $cooperators, Defectors: $defectors"
}

# Start the evolutionary game simulation
echo "Welcome to the Evolutionary Game Simulation!"
read -p "Enter the number of rounds to simulate: " rounds
read -p "Enter initial number of Cooperators: " initial_cooperators
read -p "Enter initial number of Defectors: " initial_defectors

evolutionary_game $rounds $initial_cooperators $initial_defectors
