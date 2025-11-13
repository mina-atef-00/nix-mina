#!/usr/bin/env bash

# Nix formatting and validation script
# This script can be run manually to check all Nix files in the repository

set -e

echo "Running Nix checks on all files..."

# Find all .nix files in the repository
NIX_FILES=$(find . -name "*.nix" -type f | tr '\n' ' ')

if [ -z "$NIX_FILES" ]; then
    echo "No Nix files found in repository."
    exit 0
fi

echo "Found Nix files: $NIX_FILES"

# Run nixfmt on all files
echo "Formatting all Nix files with nixfmt..."
echo "$NIX_FILES" | xargs -r nixfmt

# Run statix check on all files
echo "Running statix check on all files..."
for file in $NIX_FILES; do
    if [ -f "$file" ]; then
        if ! statix check "$file"; then
            echo "Statix check failed for $file"
            exit 1
        fi
    fi
done

# Run nix flake check if flake.nix exists
if [ -f "flake.nix" ]; then
    echo "Running nix flake check..."
    if ! nix flake check --extra-experimental-features "nix-command flakes"; then
        echo "Nix flake check failed"
        exit 1
    fi
fi

echo "All Nix checks passed!"