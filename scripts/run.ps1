Param (
  [Parameter(Mandatory=$false)]
  [string]$config
)

# Get the directory where the script is located
$ScriptDir = Split-Path -Parent $MyInvocation.MyCommand.Path

# Create logs directory if it doesn't exist
$LogDir = Join-Path $ScriptDir ".." "test" "logs"
New-Item -ItemType Directory -Path $LogDir -Force | Out-Null

cargo build

if ($lastexitcode -ne 0) {
    exit 1
}

# Set environment variables for Neovim logging
$env:NVIM_LOG_FILE = $LogDir

if ($PSBoundParameters.ContainsKey('config')) {
    # If a config is provided, use it
    $InitLua = $config
} else {
    # Get the path to the minimal init file
    $InitLua = Join-Path $ScriptDir ".." "test" "config" "lazy-init.lua"
}

# Launch Neovim with the minimal config
& nvim -u $InitLua
