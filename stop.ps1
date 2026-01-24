Write-Host "🛑 Stopping Open Notebook services..." -ForegroundColor Red

# Define patterns to kill
$patterns = @(
    "run_api.py",
    "surreal-commands-worker",
    "uvicorn",
    "next dev",
    "next-server",
    "node" 
)
# Added "node" generic because often start.ps1 runs npm which runs node.

# Kill Python/Node processes matching patterns
$procs = Get-CimInstance Win32_Process | Where-Object { 
    $cmd = $_.CommandLine
    if ($null -eq $cmd) { return $false }
    foreach ($p in $patterns) {
        if ($cmd -like "*$p*") { return $true }
    }
    return $false
}

foreach ($p in $procs) {
    Write-Host "   Killing PID $($p.ProcessId): $($p.CommandLine)" -ForegroundColor Gray
    try {
        Stop-Process -Id $p.ProcessId -Force -ErrorAction Stop
    } catch {
        Write-Host "   Failed to kill $($p.ProcessId)" -ForegroundColor DarkGray
    }
}

# Stop Docker services
Write-Host "   Stopping Docker containers..."
docker compose down

Write-Host "✅ Services stopped."
