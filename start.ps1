Write-Host "🚀 Starting Open Notebook (Database + API + Worker + Frontend)..." -ForegroundColor Cyan

# Check if Docker is running
docker info > $null 2>&1
if ($LASTEXITCODE -ne 0) {
    Write-Error "Docker is not running. Please start Docker Desktop and try again."
    exit 1
}

# Start Database
Write-Host "📊 Starting SurrealDB..." -ForegroundColor Yellow
docker compose up -d surrealdb
Start-Sleep -Seconds 3

# Start API Backend
Write-Host "🔧 Starting API backend..." -ForegroundColor Yellow
Write-Host "  -> Launching API in new window..." -ForegroundColor Gray
Start-Process -FilePath "python" -ArgumentList "-m", "uv", "run", "run_api.py"

Start-Sleep -Seconds 3

# Start Worker
Write-Host "⚙️ Starting background worker..." -ForegroundColor Yellow
Write-Host "  -> Launching Worker in new window..." -ForegroundColor Gray
Start-Process -FilePath "python" -ArgumentList "-m", "uv", "run", "--env-file", ".env", "surreal-commands-worker", "--import-modules", "commands"

Start-Sleep -Seconds 2

# Start Frontend
Write-Host "🌐 Starting Next.js frontend..." -ForegroundColor Yellow
Write-Host "✅ All services started!" -ForegroundColor Green
Write-Host "📱 Frontend: http://localhost:3000" -ForegroundColor Cyan
Write-Host "🔗 API: http://localhost:5055" -ForegroundColor Cyan
Write-Host "📚 API Docs: http://localhost:5055/docs" -ForegroundColor Cyan

Set-Location frontend
npm run dev
