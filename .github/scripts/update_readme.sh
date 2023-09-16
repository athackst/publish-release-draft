#!/bin/bash

# Get the latest release tag from command-line argument
latest_tag=$1

# Read the README template file
readme_template=".github/scripts/README.md.template"
readme=$(cat "$readme_template")

# Replace the latest release tag in the README template
new_readme=${readme//LATEST_TAG/$latest_tag}

# Write the updated README file
echo "$new_readme" > README.md
