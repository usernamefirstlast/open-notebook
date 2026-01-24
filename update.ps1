Write-Host "🔄 Updating Open Notebook..." -ForegroundColor Cyan

# 1. Fetch latest changes from upstream
Write-Host "📡 Fetching latest changes from upstream..." -ForegroundColor Yellow
git fetch upstream

# 2. Merge upstream/main into current branch
Write-Host "🔀 Merging changes from upstream/main..." -ForegroundColor Yellow
git merge upstream/main

if ($LASTEXITCODE -ne 0) {
    Write-Error "❌ Git merge failed. You may have conflicts or need to commit local changes first."
    exit 1
}

# 3. Update Backend Dependencies
Write-Host "📦 Updating Backend Dependencies (uv sync)..." -ForegroundColor Yellow
python -m uv sync

# 4. Update Frontend Dependencies
Write-Host "📦 Updating Frontend Dependencies (npm install)..." -ForegroundColor Yellow
Push-Location frontend
npm install
Pop-Location

# 5. Check Docker Images (Optional but good practice)
# Write-Host "🐳 Pulling latest Docker images (if any)..." -ForegroundColor Yellow
# docker compose pull

Write-Host "✅ Update Complete!" -ForegroundColor Green
Write-Host "🚀 You can now restart the application with: .\start.ps1" -ForegroundColor Cyan
