# Quick Start: Clone and Load to VS Code

This guide will help you quickly clone the Open Notebook repository and load it into Visual Studio Code with optimal configuration.

## 📋 Prerequisites

Before you begin, make sure you have:

- **Git** - [Download Git](https://git-scm.com/downloads)
- **VS Code** - [Download VS Code](https://code.visualstudio.com/)
- **Python 3.11 or 3.12** - [Download Python](https://www.python.org/downloads/)
- **Node.js 18+** - [Download Node.js](https://nodejs.org/)

## 🚀 Quick Start (5 Minutes)

### Step 1: Clone the Repository

```bash
# Clone the repository
git clone https://github.com/lfnovo/open-notebook.git
cd open-notebook
```

### Step 2: Open in VS Code

**Option A: Open as Workspace (Recommended)**

```bash
# Open the pre-configured workspace
code open-notebook.code-workspace
```

This gives you:
- 🏠 Multi-root workspace with organized folders
- 🔧 Pre-configured debug configurations
- ⚡ Quick tasks for common operations
- 🎨 Proper settings for Python and TypeScript

**Option B: Open as Folder**

```bash
# Open the project folder
code .
```

### Step 3: Install Recommended Extensions

When VS Code opens, you'll see a prompt to install recommended extensions:

1. Click **"Install All"** in the notification
2. Wait for extensions to install
3. Reload VS Code if prompted

**Key extensions include:**
- Python + Pylance (Python development)
- Ruff (Python linting/formatting)
- ESLint + Prettier (JavaScript/TypeScript)
- Tailwind CSS IntelliSense
- Docker
- GitLens

### Step 4: Set Up Python Environment

**Option A: Let VS Code help you**

1. VS Code will detect you need a virtual environment
2. Press `Ctrl+Shift+P` (or `Cmd+Shift+P` on Mac)
3. Type "Python: Create Environment"
4. Select "Venv"
5. Select Python 3.11 or 3.12
6. Wait for environment to be created

**Option B: Use terminal**

```bash
# Create virtual environment using uv
curl -LsSf https://astral.sh/uv/install.sh | sh  # Install uv if needed
uv venv
source .venv/bin/activate  # On Windows: .venv\Scripts\activate
uv sync
```

### Step 5: Configure Environment

```bash
# Copy environment template
cp .env.example .env

# Edit .env and add your API keys
# At minimum, you need one AI provider key (e.g., OPENAI_API_KEY)
```

### Step 6: Install Frontend Dependencies

```bash
cd frontend
npm install
cd ..
```

### Step 7: Start Development

**Option A: Use VS Code Tasks (Easiest)**

1. Press `Ctrl+Shift+P` → "Tasks: Run Task"
2. Select **"Start All Services (Make)"**
3. Wait for services to start

**Option B: Use Make Commands**

```bash
make start-all
```

**Option C: Use Debug Configurations**

1. Go to **Run and Debug** panel (`Ctrl+Shift+D`)
2. Select **"Full Stack: All Services"**
3. Press `F5`

## ✅ Verify Installation

After starting services:

- **Frontend:** http://localhost:3000
- **API:** http://localhost:5055
- **API Docs:** http://localhost:5055/docs

## 🎯 Next Steps

### Learn the Workspace

- **`.vscode/README.md`** - Complete VS Code setup guide
- **Debug panel** (`Ctrl+Shift+D`) - Pre-configured debugging
- **Tasks** (`Ctrl+Shift+P` → Tasks) - Quick development commands

### Read Documentation

- **[Getting Started Guide](docs/getting-started/index.md)** - Learn Open Notebook basics
- **[Development Guide](docs/deployment/development.md)** - Development workflow
- **[Contributing Guide](CONTRIBUTING.md)** - How to contribute

### Try It Out

1. **Create your first notebook** - http://localhost:3000
2. **Add a source** - Upload a PDF or add a URL
3. **Chat with AI** - Ask questions about your content
4. **Generate a podcast** - Create an AI podcast from your sources

## 🐛 Troubleshooting

### Extensions not installing

- Open Extensions panel (`Ctrl+Shift+X`)
- Search for "Python" and "Pylance"
- Install manually if needed

### Python interpreter not found

1. Press `Ctrl+Shift+P`
2. Type "Python: Select Interpreter"
3. Choose `.venv/bin/python` (or `.venv\Scripts\python.exe` on Windows)

### Port already in use

If ports 3000, 5055, or 8000 are in use:

```bash
# Stop existing services
make stop-all

# Or kill specific port
# Linux/Mac:
lsof -ti:5055 | xargs kill -9

# Windows:
netstat -ano | findstr :5055
taskkill /PID <PID> /F
```

### Services not starting

```bash
# Check what's running
make status

# View logs
docker compose logs

# Restart services
make stop-all
make start-all
```

### Need more help?

- **Complete VS Code guide:** [.vscode/README.md](.vscode/README.md)
- **Development guide:** [docs/deployment/development.md](docs/deployment/development.md)
- **Discord:** [discord.gg/37XJPXfz2w](https://discord.gg/37XJPXfz2w)
- **GitHub Issues:** [github.com/lfnovo/open-notebook/issues](https://github.com/lfnovo/open-notebook/issues)

## 🎓 Learning Resources

### VS Code Tips

- **Command Palette:** `Ctrl+Shift+P` - Access all commands
- **Quick Open:** `Ctrl+P` - Quickly open files
- **Integrated Terminal:** `` Ctrl+` `` - Open terminal
- **Debug:** `F5` - Start debugging
- **Format:** `Shift+Alt+F` - Format current file

### Keyboard Shortcuts Cheat Sheet

See [.vscode/README.md](.vscode/README.md#-keyboard-shortcuts-cheat-sheet) for complete list.

### Video Tutorials

- [VS Code Python Tutorial](https://code.visualstudio.com/docs/python/python-tutorial)
- [VS Code Tips & Tricks](https://code.visualstudio.com/docs/getstarted/tips-and-tricks)
- [Debugging in VS Code](https://code.visualstudio.com/docs/editor/debugging)

## 📝 Quick Reference

### Common Commands

```bash
# Development
make start-all          # Start all services
make stop-all          # Stop all services
make status            # Check service status

# Quality Checks
make ruff              # Lint Python code
uv run pytest          # Run tests
make lint              # Type check with mypy

# Frontend
cd frontend
npm run dev            # Start dev server
npm run build          # Build for production
npm run lint           # Lint frontend code
```

### VS Code Tasks

Press `Ctrl+Shift+P` → "Tasks: Run Task":

- **Start All Services** - Start everything
- **Stop All Services** - Stop everything
- **Run Tests** - Execute test suite
- **Lint Python** - Run Ruff linter
- **Format Python** - Format with Ruff
- **Full Quality Check** - Lint + Format + Type Check + Test

### Debug Configurations

Press `Ctrl+Shift+D` and select:

- **FastAPI: Run API Server** - Debug backend
- **Python: Background Worker** - Debug worker
- **Next.js: Debug Frontend** - Debug frontend
- **Full Stack: All Services** - Debug everything

---

**You're all set! Happy coding! 🚀**

For more detailed information, see:
- [Complete VS Code Setup Guide](.vscode/README.md)
- [Development Documentation](docs/deployment/development.md)
- [Contributing Guidelines](CONTRIBUTING.md)
