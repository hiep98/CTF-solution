# Define the fixed part of the password
$fixedPart = "krakencorp"

# Define the character set for the additional character
$charSet = "abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789!@#$%^&*()_+"

# Output file
$outputFile = "wordlist.txt"

# Clear the output file if it exists
Remove-Item $outputFile -ErrorAction SilentlyContinue

# Loop through each character in the set to generate the wordlist
foreach ($char1 in $charSet.ToCharArray()) {
    # Before
    "$char1$fixedPart" | Out-File -FilePath $outputFile -Append

    # After
    "$fixedPart$char1" | Out-File -FilePath $outputFile -Append

    # Inside (each position within "krakencorp")
    for ($i = 0; $i -le $fixedPart.Length; $i++) {
        $part1 = $fixedPart.Substring(0, $i)
        $part2 = $fixedPart.Substring($i)
        "$part1$char1$part2" | Out-File -FilePath $outputFile -Append
    }
}

Write-Output "Wordlist generated in $outputFile"
