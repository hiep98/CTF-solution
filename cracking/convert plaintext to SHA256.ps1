# Set the pah to the text file
$filePath = "D:\wordlist.txt"


$outputFilePath = "D:\out.txt"

# Read each line from the input file and compute the hash
Get-Content $filePath | ForEach-Object {
    # Compute the hash for each line using SHA256
    $line = $_
    $hash = [System.Security.Cryptography.SHA256]::Create().ComputeHash([System.Text.Encoding]::UTF8.GetBytes($line))
    
    # Convert the hash bytes to a hexadecimal string
    $hashHex = [BitConverter]::ToString($hash) -replace '-'
    
    # Write the hash to the output file
    $hashHex | Out-File -FilePath $outputFilePath -Append
}

Write-Host "Hashes have been written to $outputFilePath"
