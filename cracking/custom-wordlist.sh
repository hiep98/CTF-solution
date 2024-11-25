#!binbash
# Update 1 -  fix properly to ensure we only mix uppercase and lowercase letters. earlier approach inadvertently reversed or misordered the krakencorp string

# Output wordlist
output_file=wordlist.txt

# Clear the file if it already exists
 $output_file

# Define all placeholders and substitutions
placeholders=('@', ',', '%', '^')
substitutions=('4', '3', '0', '9') # Number substitutions for specific letters
fixed=krakencorp

# Helper function to generate case variations for krakencorp
generate_case_variants() {
  local word=$1
  local n=${#word}
  local variants=()

  # Generate all combinations of upperlowercase
  for ((i = 0; i  (1  n); i++)); do
    local variant=
    for ((j = 0; j  n; j++)); do
      if ((i & (1  j))); then
        variant+=${wordj1}  # Lowercase
      else
        variant+=${wordj1}  # Uppercase
      fi
    done
    variants+=($variant)
  done

  echo ${variants[@]}
}

# Helper function to generate substitutions for krakencorp
generate_variants() {
  local word=$1
  local variants=($word)
  
  # Substitute specific letters with numbers (e.g., 'a' - '4', etc.)
  for ((i = 0; i  ${#word}; i++)); do
    char=${word$i1}
    case $char in
      aA) new_chars=('4') ;;
      eE) new_chars=('3') ;;
      oO) new_chars=('0') ;;
      pP) new_chars=('9') ;;
      ) new_chars=() ;;
    esac
    # Add substitutions
    for nc in ${new_chars[@]}; do
      variants+=(${word0$i}${nc}${word$((i + 1))})
    done
  done

  echo ${variants[@]}
}

# Generate case and substitution variants
case_variants=($(generate_case_variants $fixed))
kraken_variants=()
for case_variant in ${case_variants[@]}; do
  kraken_variants+=($(generate_variants $case_variant))
done

# Generate patterns by adding placeholders before, within, or after
for variant in ${kraken_variants[@]}; do
  for pos in {0..10}; do
    for placeholder in ${placeholders[@]}; do
      # Insert placeholder in all positions while maintaining length 11
      if [[ $pos -lt ${#variant} ]]; then
        pattern=${variant0$pos}${placeholder}${variant$pos}
      else
        pattern=${variant}${placeholder}
      fi

      # Ensure the pattern is exactly 11 characters
      if [[ ${#pattern} -eq 11 ]]; then
        crunch 11 11 -t $pattern  $output_file
      fi
    done
  done
done

echo Wordlist generation complete. Output saved to $output_file.