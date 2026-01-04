# VS Code Setup Guide for Open Notebook

This guide will help you set up Visual Studio Code for Open Notebook development with optimal configuration and extensions.

## 🚀 Quick Start

### Option 1: Open as Workspace (Recommended)

The repository includes a multi-root workspace configuration for better organization:

```bash
git clone https://github.com/lfnovo/open-notebook.git
cd open-notebook
code open-notebook.code-workspace
```

This workspace provides:
- 🏠 **Root** - Overall project configuration
- 🎨 **Frontend** - Next.js/React UI development
- 🔧 **API** - FastAPI backend
- 📦 **Core** - Core application logic
- 📝 **Documentation** - Project docs

### Option 2: Open as Folder

```bash
git clone https://github.com/lfnovo/open-notebook.git
cd open-notebook
code .
```

## 📦 Recommended Extensions

When you open the project, VS Code will prompt you to install recommended extensions. Click **"Install All"** to get:

### Essential Extensions

- **Python** (`ms-python.python`) - Python language support
- **Pylance** (`ms-python.vscode-pylance`) - Fast Python language server
- **Ruff** (`charliermarsh.ruff`) - Lightning-fast Python linter and formatter
- **ESLint** (`dbaeumer.vscode-eslint`) - JavaScript/TypeScript linting
- **Prettier** (`esbenp.prettier-vscode`) - Code formatter
- **Tailwind CSS IntelliSense** (`bradlc.vscode-tailwindcss`) - Tailwind CSS support
- **Docker** (`ms-azuretools.vscode-docker`) - Docker container management

### Helpful Extensions

- **GitLens** (`eamodio.gitlens`) - Enhanced Git capabilities
- **Error Lens** (`usernamehw.errorlens`) - Inline error highlighting
- **Path Intellisense** (`christian-kohler.path-intellisense`) - File path autocomplete
- **REST Client** (`humao.rest-client`) - Test API endpoints
- **Jinja** (`wholroyd.jinja`) - Jinja2 template support for prompts

### Optional but Recommended

- **GitHub Copilot** (`github.copilot`) - AI-powered code suggestions
- **Remote - Containers** (`ms-vscode-remote.remote-containers`) - Dev containers support

## 🔧 Configuration Included

The `.vscode/` directory includes pre-configured settings:

### Settings (`settings.json`)
- ✅ Python interpreter pointing to `.venv/`
- ✅ Auto-formatting on save (Ruff for Python, Prettier for JS/TS)
- ✅ Import sorting and organization
- ✅ Proper file associations (Jinja, .env files)
- ✅ Optimized search and file exclusions
- ✅ Tailwind CSS IntelliSense configuration

### Launch Configurations (`launch.json`)
Ready-to-use debug configurations:

1. **FastAPI: Run API Server** - Debug the FastAPI backend
2. **Python: Background Worker** - Debug the background task processor
3. **Next.js: Debug Frontend** - Debug the React frontend
4. **Python: Current File** - Debug any Python file
5. **Python: Pytest Current File** - Debug individual test files
6. **Full Stack: All Services** - Debug API + Frontend together

### Tasks (`tasks.json`)
Quick access to common development tasks:

- Start/Stop SurrealDB
- Install dependencies (Python & Frontend)
- Run tests with coverage
- Lint and format code
- Build frontend
- Start/Stop all services
- Full quality check (lint + format + type check + test)

### Extensions (`extensions.json`)
Curated list of recommended extensions specific to Open Notebook development.

## 🛠️ Development Workflow

### First-Time Setup

1. **Open the workspace:**
   ```bash
   code open-notebook.code-workspace
   ```

2. **Install recommended extensions** when prompted

3. **Create a virtual environment:**
   - The Python extension will detect you need a virtual environment
   - Press `Ctrl+Shift+P` (or `Cmd+Shift+P` on Mac)
   - Type "Python: Create Environment"
   - Select "Venv"
   - Select Python 3.11 or 3.12

   Or use the terminal:
   ```bash
   uv venv
   source .venv/bin/activate  # On Windows: .venv\Scripts\activate
   uv sync
   ```

4. **Install frontend dependencies:**
   ```bash
   cd frontend
   npm install
   ```

5. **Copy environment file:**
   ```bash
   cp .env.example .env
   # Edit .env with your API keys
   ```

### Running the Application

#### Using Tasks (Easiest)

Press `Ctrl+Shift+P` → "Tasks: Run Task" → Choose:
- **Start All Services (Make)** - Starts everything
- **Check Service Status** - See what's running
- **Stop All Services (Make)** - Stop everything

#### Using Debug Configurations

1. Go to **Run and Debug** panel (`Ctrl+Shift+D`)
2. Select a configuration from the dropdown:
   - **Full Stack: All Services** - Start and debug everything
   - **FastAPI: Run API Server** - Just the backend
   - **Next.js: Debug Frontend** - Just the frontend
3. Press `F5` or click the green play button

#### Using Terminal

```bash
# Start all services
make start-all

# Or individually
make database    # Start SurrealDB
make api        # Start FastAPI
make worker     # Start background worker
make frontend   # Start Next.js
```

### Debugging

#### Python Debugging

1. Set breakpoints by clicking in the gutter (left of line numbers)
2. Select **FastAPI: Run API Server** from debug dropdown
3. Press `F5` to start debugging
4. Trigger the breakpoint by making an API request
5. Use debug controls:
   - `F10` - Step over
   - `F11` - Step into
   - `F5` - Continue
   - `Shift+F5` - Stop

#### Frontend Debugging

1. Set breakpoints in TypeScript/React files
2. Select **Next.js: Debug Frontend**
3. Press `F5`
4. Your browser will open automatically
5. Breakpoints will trigger in VS Code

#### Testing

- **Run all tests:** `Ctrl+Shift+P` → "Tasks: Run Task" → "Run Tests"
- **Debug specific test:**
  1. Open test file
  2. Select **Python: Pytest Current File**
  3. Press `F5`

### Code Quality

All quality checks run automatically on save, but you can also run them manually:

#### Python

- **Format code:** `Ctrl+Shift+P` → "Tasks: Run Task" → "Format Python (Ruff)"
- **Lint code:** `Ctrl+Shift+P` → "Tasks: Run Task" → "Lint Python (Ruff)"
- **Type check:** `Ctrl+Shift+P` → "Tasks: Run Task" → "Type Check (MyPy)"

Or use shortcuts:
- `Shift+Alt+F` (or `Shift+Option+F` on Mac) - Format current file
- Code actions on save will fix imports and linting issues

#### Frontend

- **Lint:** `Ctrl+Shift+P` → "Tasks: Run Task" → "Lint Frontend (ESLint)"
- **Build:** `Ctrl+Shift+P` → "Tasks: Run Task" → "Build Frontend"

#### All-in-One Quality Check

Run everything at once:
- `Ctrl+Shift+P` → "Tasks: Run Task" → "Full Quality Check"

This runs: Ruff check → Ruff format → MyPy → Pytest

## 🔍 Useful Features

### IntelliSense & Auto-Complete

- **Python:** Pylance provides intelligent code completion for Python
- **TypeScript/React:** Built-in TypeScript server with React support
- **Tailwind CSS:** Tailwind IntelliSense shows class suggestions and previews
- **Path completion:** Auto-complete file paths in imports

### Code Navigation

- **Go to definition:** `F12` or `Ctrl+Click`
- **Go to type definition:** `Ctrl+Shift+F12`
- **Find all references:** `Shift+F12`
- **Go to symbol:** `Ctrl+Shift+O` (search functions/classes in file)
- **Go to symbol in workspace:** `Ctrl+T`

### Multi-Cursor Editing

- **Add cursor:** `Alt+Click` (or `Option+Click` on Mac)
- **Add cursor above/below:** `Ctrl+Alt+Up/Down`
- **Select all occurrences:** `Ctrl+Shift+L`
- **Select next occurrence:** `Ctrl+D`

### Integrated Terminal

- **Open terminal:** `` Ctrl+` ``
- **Split terminal:** `Ctrl+Shift+5`
- **Create new terminal:** `Ctrl+Shift+``
- Terminal automatically activates Python virtual environment

### File Search & Navigation

- **Quick open file:** `Ctrl+P`
- **Search in files:** `Ctrl+Shift+F`
- **Go to line:** `Ctrl+G`
- **Command palette:** `Ctrl+Shift+P`

## 📂 Project Structure

Understanding the project layout helps with navigation:

```
open-notebook/
├── .vscode/              # VS Code configuration (you're here!)
│   ├── settings.json     # Editor and language settings
│   ├── launch.json       # Debug configurations
│   ├── tasks.json        # Quick tasks
│   └── extensions.json   # Recommended extensions
├── api/                  # FastAPI backend
│   ├── main.py          # API entry point
│   └── routers/         # API route handlers
├── frontend/            # Next.js/React frontend
│   ├── src/            # React components and pages
│   └── public/         # Static assets
├── open_notebook/       # Core Python application
│   ├── domain/         # Business logic
│   ├── database/       # Database operations
│   └── graphs/         # LangGraph AI workflows
├── prompts/            # Jinja2 AI prompt templates
├── docs/              # Documentation
├── tests/             # Test files
├── .env.example       # Environment template
└── Makefile          # Development commands
```

## 🎯 Keyboard Shortcuts Cheat Sheet

### Essential Shortcuts

| Action | Windows/Linux | macOS |
|--------|---------------|-------|
| Command Palette | `Ctrl+Shift+P` | `Cmd+Shift+P` |
| Quick Open File | `Ctrl+P` | `Cmd+P` |
| Toggle Terminal | ``Ctrl+` `` | ``Cmd+` `` |
| Start Debugging | `F5` | `F5` |
| Format Document | `Shift+Alt+F` | `Shift+Option+F` |
| Go to Definition | `F12` | `F12` |
| Find in Files | `Ctrl+Shift+F` | `Cmd+Shift+F` |
| Toggle Sidebar | `Ctrl+B` | `Cmd+B` |
| Run Task | `Ctrl+Shift+P` → Tasks | `Cmd+Shift+P` → Tasks |

## 🐛 Troubleshooting

### Python Interpreter Not Found

1. Press `Ctrl+Shift+P`
2. Type "Python: Select Interpreter"
3. Choose the `.venv` interpreter
4. If not listed, choose "Enter interpreter path" → `.venv/bin/python`

### Extensions Not Working

1. Check extensions are installed: `Ctrl+Shift+X`
2. Reload window: `Ctrl+Shift+P` → "Developer: Reload Window"
3. Restart VS Code

### Formatting Not Working

1. Check default formatter: `Ctrl+Shift+P` → "Format Document With..."
2. Select "Ruff" for Python, "Prettier" for TypeScript
3. Check "Format on Save" is enabled in settings

### IntelliSense Not Working

1. Ensure Pylance/TypeScript extensions are active
2. Check Python interpreter is selected
3. Reload window: `Ctrl+Shift+P` → "Developer: Reload Window"

### Tasks/Debug Not Working

1. Make sure you're in the workspace root
2. Check `.vscode/tasks.json` and `.vscode/launch.json` exist
3. Open Command Palette → "Tasks: Run Task" to see available tasks

## 💡 Tips & Best Practices

1. **Use the workspace file** (`open-notebook.code-workspace`) for better organization
2. **Run quality checks before committing:** Use "Full Quality Check" task
3. **Use compound debug configurations** to debug frontend + backend together
4. **Create custom tasks** in `.vscode/tasks.json` for repetitive commands
5. **Use keyboard shortcuts** to speed up your workflow
6. **Enable auto-save:** File → Auto Save (or `Ctrl+,` → search "auto save")
7. **Use the integrated terminal** to keep everything in one window

## 📚 Additional Resources

- [VS Code Python Tutorial](https://code.visualstudio.com/docs/python/python-tutorial)
- [VS Code TypeScript Tutorial](https://code.visualstudio.com/docs/typescript/typescript-tutorial)
- [VS Code Debugging Guide](https://code.visualstudio.com/docs/editor/debugging)
- [Open Notebook Documentation](docs/index.md)
- [Open Notebook Contributing Guide](CONTRIBUTING.md)

## 🆘 Getting Help

- **Discord Community:** [discord.gg/37XJPXfz2w](https://discord.gg/37XJPXfz2w)
- **GitHub Issues:** [github.com/lfnovo/open-notebook/issues](https://github.com/lfnovo/open-notebook/issues)
- **Documentation:** [docs/](docs/)

---

Happy coding! 🚀
