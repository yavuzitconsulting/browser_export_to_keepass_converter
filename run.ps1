# Global counter for all credentials converted
$totalConvertedCount = 0

# Check if 'input' directory exists, create it if not
if (-Not (Test-Path "./input")) {
    New-Item -Path "./input" -ItemType Directory
    Write-Host "Please put your browser csv export into the 'input' directory."
    return
}

# Check if 'output' directory exists, create it if not
if (-Not (Test-Path "./output")) {
    New-Item -Path "./output" -ItemType Directory
}

# Loop through each .csv file in the 'input' directory
Get-ChildItem "./input" -Filter *.csv | ForEach-Object {
    $inputFileName = $_.Name
    $outputFileName = "keepass_$inputFileName"

    Write-Host "Processing $inputFileName..."
    
    # Initialize an array to store the transformed data
    $transformedData = @()
    $transformedData += 'Account,"Login Name","Password","Web Site","Comments"'
    $convertedCount = 0

    $lines = Get-Content "./input/$inputFileName"
    foreach ($line in $lines[1..($lines.Length - 1)]) {
        Write-Host "Parsing line: $line"
        if ($line -match "android://") {
            Write-Host "Skipping line containing 'android://'"
            continue
        }
        
        $line = $line -replace '"', ''
        $fields = $line -split ','
        Write-Host "Parsed fields: $($fields -join ', ')"
        
        $url = $fields[0]
        $username = $fields[1]
        $password = $fields[2]

        $outputLine = "AutoImport,""$username"",""$password"",""$url"",""AutoImport"""
        Write-Host "Constructed output line: $outputLine"
        $transformedData += $outputLine
        $convertedCount++
    }

    $totalConvertedCount += $convertedCount

    Write-Host "Writing to output file..."
    $transformedData | Out-File "./output/$outputFileName"
    Write-Host "Done, $convertedCount credentials converted. Output saved as $outputFileName"
}

Write-Host "Total credentials converted: $totalConvertedCount"
