#!/bin/bash

# Output wordlist
output_file="2wordlist.txt"

# Clear the file if it already exists
> "$output_file"

# Define all placeholders and substitutions
placeholders=('@', ',', '%', '^')
substitutions=('4', '3', '0', '9') # Number substitutions for specific letters
fixed="krakencorp"

# Helper function to generate case variations for a word
generate_case_variants() {
  local word=$1
  echo $(echo "$word" | sed -r 's/(.)/\1/g' | awk '{
    n = length($0);
    for (i = 0; i < 2^n; i++) {
      mask = i;
      for (j = n; j > 0; j--) {
        if (and(mask, 1) == 1) printf toupper(substr($0, j, 1));
        else printf tolower(substr($0, j, 1));
        mask = int(mask / 2);
      }
      print "";
    }
  }')
}

# Helper function to create substitutions for "krakencorp"
generate_variants() {
  local word=$1
  local variants=($word)
  
  # Substitute specific letters with numbers (e.g., 'a' -> '4', etc.)
  for ((i = 0; i < ${#word}; i++)); do
    char="${word:$i:1}"
    case "$char" in
      a|A) new_chars=('4') ;;
      e|E) new_chars=('3') ;;
      o|O) new_chars=('0') ;;
      p|P) new_chars=('9') ;;
      *) new_chars=() ;;
    esac
    # Add substitutions
    for nc in "${new_chars[@]}"; do
      variants+=("${word:0:$i}${nc}${word:$((i + 1))}")
    done
  done

  echo "${variants[@]}"
}

# Generate case and substitution variants
case_variants=($(generate_case_variants "$fixed"))
kraken_variants=()
for case_variant in "${case_variants[@]}"; do
  kraken_variants+=($(generate_variants "$case_variant"))
done

# Generate patterns by adding placeholders before, within, or after
for variant in "${kraken_variants[@]}"; do
  for pos in {0..10}; do
    for placeholder in "${placeholders[@]}"; do
      # Insert placeholder in all positions while maintaining length 11
      if [[ $pos -lt ${#variant} ]]; then
        pattern="${variant:0:$pos}${placeholder}${variant:$pos}"
      else
        pattern="${variant}${placeholder}"
      fi

      # Ensure the pattern is exactly 11 characters
      if [[ ${#pattern} -eq 11 ]]; then
        crunch 11 11 -t "$pattern" >> "$output_file"
      fi
    done
  done
done

echo "Wordlist generation complete. Output saved to $output_file."
