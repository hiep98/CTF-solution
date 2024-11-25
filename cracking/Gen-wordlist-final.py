from itertools import product

# Fixed word
word = "krakencorp"

# Characters to insert (can be expanded)
insertable_chars = "abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789!@#$%^&*()-_=+[]{};:'\",.<>?/\\|`~"

# Define substitutions for specific letters in the word
substitutions = {
    'a': ('a', 'A', '4'),
    'e': ('e', 'E', '3'),
    'o': ('o', 'O', '0'),
}

# Generate options for each character in the word
char_options = [
    substitutions[char] if char in substitutions else (char.lower(), char.upper())
    for char in word
]

# Generate all combinations of the word with case transformations
case_combinations = map("".join, product(*char_options))

# Insert one additional character at all possible positions
final_combinations = set()
for base_word in case_combinations:
    for insert_char in insertable_chars:
        # Insert character at all positions
        for i in range(len(base_word) + 1):
            final_combinations.add(base_word[:i] + insert_char + base_word[i:])

# Write to file
with open("v_processed.txt", "w") as f:
    f.writelines(f"{combo}\n" for combo in final_combinations)

print("Wordlist with insertions saved to 'v_processed.txt'.")
