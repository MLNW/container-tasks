#!/bin/bash

config_file=$1
image=$2
errors=""

while read -r software; do
  name=$(echo $software | jq -r '.name')
  check_command=$(echo $software | jq -r '.check_command // empty')
  expected_output=$(echo $software | jq -r '.expected_output // empty')

  if [ -z "$check_command" ]; then
    check_command="$name --version"
  fi

  installed_version=$(podman run --rm $image bash -c "$check_command" 2>&1)
  success=$?

  if [[ $success == 0 ]]; then
    if [[ -n "$expected_output" && $installed_version != *"$expected_output"* ]]; then
      errors+="$name version mismatch. Expected: $expected_output, found: $installed_version\n"
    else
      formatted_output=$(printf '%s\n' "$installed_version" | sed 's@^@    @g')
      printf "%s =>\n%s\n\n" "$check_command" "$formatted_output"
    fi
  else
    errors+="$name command execution failed. Found: $installed_version\n"
  fi
done < <(yq e '.software' $config_file -o=json | jq -c '.[]')

if [[ -n "$errors" ]]; then
  echo -e "\nThere were failures:"
  echo -e "$errors"
  exit 1
else
  echo "All checks passed."
fi
