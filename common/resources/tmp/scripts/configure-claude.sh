#!/bin/bash

export PATH="$PATH:$HOME/.local/bin"

claude plugin marketplace add mattpocock/skills
claude plugin install mattpocock-skills@mattpocock

claude plugin marketplace add DietrichGebert/ponytail
claude plugin install ponytail@ponytail

claude plugin marketplace add JuliusBrussee/caveman
claude plugin install caveman@caveman
