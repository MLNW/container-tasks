#!/bin/bash

export PATH="$PATH:$HOME/.local/bin"

# Use explicit HTTPS URLs: owner/repo shorthand may pick SSH, which fails without known_hosts
claude plugin marketplace add https://github.com/mattpocock/skills.git
claude plugin install mattpocock-skills@mattpocock

claude plugin marketplace add https://github.com/DietrichGebert/ponytail.git
claude plugin install ponytail@ponytail

claude plugin marketplace add https://github.com/JuliusBrussee/caveman.git
claude plugin install caveman@caveman
