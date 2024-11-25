# Define the fixed part of the password
$fixedPart = "krakencorp"

# Define the character set for the additional characters
$charSet = "abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789{}.,<>/?!@#$%^&*()_+-=|[]";

# Output file
$outputFile = "2wordlist.txt"

# Clear the output file if it exists
Remove-Item $outputFile -ErrorAction SilentlyContinue

# Function to generate all combinations of two characters
function Get-Combinations {
    param (
        [string]$set
    )
    $combinations = @()
    foreach ($char1 in $set.ToCharArray()) {
        foreach ($char2 in $set.ToCharArray()) {
            if ($char1 -ne $char2) {
                $combinations += "$char1$char2"
            }
        }
    }
    return $combinations
}

# Generate all combinations of two characters
$combinations = Get-Combinations -set $charSet

# Loop through each combination to generate the wordlist
foreach ($combination in $combinations) {
    $char1 = $combination.Substring(0,1)
    $char2 = $combination.Substring(1,1)

    # Before
    "$char1$char2$fixedPart" | Out-File -FilePath $outputFile -Append
    "$char2$char1$fixedPart" | Out-File -FilePath $outputFile -Append

    # After
    "$fixedPart$char1$char2" | Out-File -FilePath $outputFile -Append
    "$fixedPart$char2$char1" | Out-File -FilePath $outputFile -Append

    # Inside (each non-adjacent position within "krakencorp")
    for ($i = 0; $i -lt $fixedPart.Length; $i++) {
        for ($j = $i+1; $j -le $fixedPart.Length; $j++) {
            $part1 = $fixedPart.Substring(0, $i)
            $part2 = $fixedPart.Substring($i, $j - $i)
            $part3 = $fixedPart.Substring($j)

            "$part1$char1$part2$char2$part3" | Out-File -FilePath $outputFile -Append
            "$part1$char2$part2$char1$part3" | Out-File -FilePath $outputFile -Append
        }
    }
}

Write-Output "Wordlist generated in $outputFile"
