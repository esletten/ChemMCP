$envFile = ".env"
try {
    if (Test-Path $envFile) {
        Get-Content $envFile | ForEach-Object {
            $line = $_.Trim()
            if ($line -and -not $line.StartsWith("#")) {
                $parts = $line -split "=", 2
                if ($parts.Length -eq 2) {
                    $name = $parts[0].Trim()
                    $value = $parts[1].Trim()
                    if ($name -and $value) {
                        [System.Environment]::SetEnvironmentVariable($name, $value, [System.EnvironmentVariableTarget]::Process)
                    }
                }
            }
        }
    }
}
catch {
    Write-Host "Error parsing .env file: $_"
    exit 1
}

$missing = @()

if (-not $env:TAVILY_API_KEY) { $missing += "TAVILY_API_KEY" }
if (-not $env:RXN4CHEM_API_KEY) { $missing += "RXN4CHEM_API_KEY" }
if (-not $env:ANTHROPIC_API_KEY) { $missing += "ANTHROPIC_API_KEY" }
if (-not $env:LLM_MODEL_NAME) { $missing += "LLM_MODEL_NAME" }

if ($missing.Count -eq 0) {
    Write-Host "Success: All API Keys are loaded."
    Write-Host "LLM Model: $env:LLM_MODEL_NAME"
}
else {
    Write-Host "Error: Missing keys: $($missing -join ', ')"
}
