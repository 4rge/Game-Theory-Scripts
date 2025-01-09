#!/bin/bash

# Function to calculate total output and market price
function cournot_oligopoly {
    local a=$1  # Price intercept
    local b=$2  # Slope of demand curve
    local c=$3  # Marginal cost
    local n=$4  # Number of firms

    # Calculate total output Q*
    local Q_star=$(echo "scale=2; ($n * ($a - $c)) / ($n + 1) / $b" | bc)
    
    # Calculate market price P*
    local P_star=$(echo "scale=2; $a - $b * $Q_star" | bc)

    # Output the results
    echo "Total Output (Q*): $Q_star"
    echo "Market Price (P*): $P_star"
    
    # Deriving and presenting observations based on total output thresholds
    if (( $(echo "$Q_star < 10" | bc -l) )); then
        echo "Observation: Total output is low. The market may be in an early stage of competition or firms might have high marginal costs."
    elif (( $(echo "$Q_star >= 10" | bc -l) && $(echo "$Q_star < 50" | bc -l) )); then
        echo "Observation: Total output is moderate. Firms are likely reaching a competitive equilibrium."
    elif (( $(echo "$Q_star >= 50" | bc -l) )); then
        echo "Observation: Total output is high. The market may be nearing saturation, increasing competition among firms."
    fi

    # Additional observation based on market price
    if (( $(echo "$P_star < $c" | bc -l) )); then
        echo "Observation: The market price is below marginal cost, indicating firms might incur losses."
    elif (( $(echo "$P_star >= $c" | bc -l) )); then
        echo "Observation: The market price is at or above marginal cost, suggesting firms are likely to cover their costs."
    fi
}

# Display notes to the user
echo "Welcome to the Cournot Oligopoly Model Calculator!"
echo ""
echo "Please provide the following parameters:"
echo ""
echo "a (Price Intercept): The theoretical maximum price when quantity is zero."
echo "b (Slope of Demand): Indicates how much price decreases with each additional unit of quantity supplied."
echo "c (Marginal Cost): The cost of producing one additional unit."
echo "n (Number of Firms): Indicates how many firms are competing in the market."
echo ""

# Read user inputs
read -p "Enter value for a: " a
read -p "Enter value for b: " b
read -p "Enter value for c: " c
read -p "Enter value for n: " n

# Call the function with the user-provided inputs
cournot_oligopoly $a $b $c $n
