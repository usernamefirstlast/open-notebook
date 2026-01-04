# Development Setup

This guide covers setting up Open Notebook for local development, contributing to the project, and running from source code.

## 🎯 Who This Guide Is For

This setup is ideal if you want to:
- **Contribute to Open Notebook** - Fix bugs, add features, or improve documentation
- **Customize the application** - Modify the code for your specific needs
- **Understand the codebase** - Learn how Open Notebook works internally
- **Develop integrations** - Build custom plugins or extensions

## 🛠️ Prerequisites

### System Requirements

- **Python 3.11+** - Required for the application
- **Node.js 18+** - For frontend development (if contributing to UI)
- **Git** - For version control
- **Docker** - For SurrealDB and optional services

### Development Tools

- **Code editor** - VS Code, PyCharm, or your preferred IDE
- **Terminal** - Command line access
- **Web browser** - For testing the application

## 📥 Installation

### Step 1: Clone the Repository

```bash
git clone https://github.com/lfnovo/open-notebook.git
cd open-notebook
```

### Step 2: Python Environment Setup

Open Notebook uses **uv** for dependency management:

```bash
# Install uv (if not already installed)
curl -LsSf https://astral.sh/uv/install.sh | sh

# Create and activate virtual environment
uv venv
source .venv/bin/activate  # On Windows: .venv\Scripts\activate

# Install dependencies
uv sync
```

### Step 3: Database Setup

#### Option A: Docker SurrealDB (Recommended)

```bash
# Start SurrealDB with Docker
docker run -d \
  --name surrealdb-dev \
  -p 8000:8000 \
  surrealdb/surrealdb:v1-latest \
  start --log trace --user root --pass root memory
```

#### Option B: Local SurrealDB Installation

```bash
# Install SurrealDB locally
curl -sSf https://install.surrealdb.com | sh

# Start SurrealDB
surreal start --log trace --user root --pass root memory
```

### Step 4: Environment Configuration

Create a `.env` file in the project root:

```env
# Database Configuration
SURREAL_URL=ws://localhost:8000/rpc
SURREAL_USER=root
SURREAL_PASSWORD=root
SURREAL_NAMESPACE=open_notebook
SURREAL_DATABASE=development

# Required: At least one AI provider
OPENAI_API_KEY=sk-your-openai-key

# Optional: Additional providers for testing
ANTHROPIC_API_KEY=sk-ant-your-anthropic-key
GOOGLE_API_KEY=your-google-key
GROQ_API_KEY=gsk_your-groq-key

# Optional: Development settings
LOG_LEVEL=DEBUG
ENABLE_ANALYTICS=false
```

### Step 5: Frontend Setup

Install frontend dependencies:

```bash
cd frontend
npm install
cd ..
```

> **Note**: Database migrations now run automatically when the API starts. No manual migration step is required.

### Step 6: Start the Application

#### Option A: Full Stack with Make

```bash
# Start all services (recommended for development)
make start-all
```

This starts:
- **SurrealDB** (if not already running)
- **FastAPI backend** on port 5055
- **Background worker** for async tasks
- **React frontend** on port 8502

#### Option B: Individual Services

Start services separately for debugging:

```bash
# Terminal 1: Start the API
uv run python api/main.py

# Terminal 2: Start the background worker
uv run python -m open_notebook.worker

# Terminal 3: Start the React frontend
cd frontend && npm run dev
```

## 🔧 Development Workflow

### Project Structure

```
open-notebook/
├── api/                    # FastAPI backend
│   ├── routers/           # API routes
│   └── main.py           # API entry point
├── frontend/              # React frontend (Next.js)
│   ├── src/              # React components and pages
│   └── public/           # Static assets
├── open_notebook/         # Core application
│   ├── domain/           # Business logic
│   ├── database/         # Database layer
│   └── graphs/           # LangGraph workflows
├── prompts/              # Jinja2 templates
├── docs/                 # Documentation
└── tests/                # Test files
```

### Development Commands

```bash
# Install new dependencies
uv add package-name

# Run tests
uv run pytest

# Run linting
uv run ruff check
uv run ruff format

# Type checking
uv run mypy .

# Start development server
make start-dev
```

### Making Changes

1. **Create a branch** for your feature/fix:
   ```bash
   git checkout -b feature/your-feature-name
   ```

2. **Make your changes** in the appropriate files

3. **Test your changes**:
   ```bash
   uv run pytest
   ```

4. **Format code**:
   ```bash
   uv run ruff format
   ```

5. **Commit your changes**:
   ```bash
   git add .
   git commit -m "feat: your descriptive commit message"
   ```

6. **Push and create a pull request**:
   ```bash
   git push origin feature/your-feature-name
   ```

## 🧪 Testing

### Running Tests

```bash
# Run all tests
uv run pytest

# Run specific test file
uv run pytest tests/test_specific.py

# Run with coverage
uv run pytest --cov=open_notebook

# Run integration tests
uv run pytest tests/integration/
```

### Test Structure

```
tests/
├── unit/               # Unit tests
├── integration/        # Integration tests
├── fixtures/          # Test fixtures
└── conftest.py        # Test configuration
```

### Writing Tests

```python
# Example test file
import pytest
from open_notebook.domain.notebook import Notebook

def test_notebook_creation():
    notebook = Notebook(name="Test Notebook", description="Test")
    assert notebook.name == "Test Notebook"
    assert notebook.description == "Test"
```

## 🚀 Building and Deployment

### Local Docker Build

```bash
# Build multi-container version
make docker-build-dev

# Build single-container version
make docker-build-single-dev

# Test the built image
docker run -p 8502:8502 \
  -v ./notebook_data:/app/data \
  -v ./surreal_data:/mydata \
  open_notebook:v1-latest
```

### Production Build

```bash
# Build with multi-platform support
make docker-build

# Build and push to registry
make docker-push
```

## 🔍 Debugging

### Common Development Issues

#### Database Connection Errors

```bash
# Check if SurrealDB is running
docker ps | grep surrealdb

# Check SurrealDB logs
docker logs surrealdb-dev

# Test connection
curl -X POST http://localhost:8000/sql \
  -H "Content-Type: application/json" \
  -d '{"sql": "SELECT * FROM VERSION"}'
```

#### API Not Starting

```bash
# Check Python environment
uv run python --version

# Check dependencies
uv run pip list | grep fastapi

# Start with debug mode
uv run python api/main.py --debug
```

#### Frontend Issues

```bash
# Check Node.js and npm versions
node --version
npm --version

# Reinstall frontend dependencies
cd frontend
rm -rf node_modules package-lock.json
npm install

# Start frontend in development mode
npm run dev
```

### Debugging Tools

#### VS Code Configuration (Included!)

**Good news!** The repository now includes comprehensive VS Code configuration out of the box:

- **`.vscode/settings.json`** - Python, TypeScript, and editor settings
- **`.vscode/launch.json`** - Debug configurations for API, Worker, Frontend
- **`.vscode/tasks.json`** - Quick tasks for common development operations
- **`.vscode/extensions.json`** - Recommended extensions
- **`open-notebook.code-workspace`** - Multi-root workspace file

**To get started:**

```bash
# Open as workspace (recommended)
code open-notebook.code-workspace

# Or open as folder
code .
```

When prompted, install the recommended extensions for the best experience.

**See the complete guide:** [`.vscode/README.md`](../../.vscode/README.md) for detailed setup instructions, debugging tips, and keyboard shortcuts.

#### Python Debugging

```python
# Add breakpoints in code
import pdb; pdb.set_trace()

# Or use debugger
import debugpy
debugpy.listen(5678)
debugpy.wait_for_client()
```

## 📝 Code Style and Standards

### Python Style Guide

- **Formatting**: Use `ruff format` for code formatting
- **Linting**: Use `ruff check` for linting
- **Type hints**: Use type hints for all functions
- **Docstrings**: Document all public functions and classes

### Example Code Style

```python
from typing import List, Optional
from pydantic import BaseModel

class Notebook(BaseModel):
    """A notebook for organizing research sources."""
    
    name: str
    description: Optional[str] = None
    sources: List[str] = []
    
    def add_source(self, source_id: str) -> None:
        """Add a source to the notebook.
        
        Args:
            source_id: The ID of the source to add
        """
        if source_id not in self.sources:
            self.sources.append(source_id)
```

### Commit Message Format

Follow conventional commits:

```
feat: add new podcast generation feature
fix: resolve database connection issue
docs: update deployment guide
refactor: improve source processing logic
test: add tests for notebook creation
```

## 🤝 Contributing

### Before Contributing

1. **Read the contribution guidelines** in `CONTRIBUTING.md`
2. **Join the Discord** for discussion: [discord.gg/37XJPXfz2w](https://discord.gg/37XJPXfz2w)
3. **Check existing issues** to avoid duplicates
4. **Discuss major changes** before implementing

### Contribution Process

1. **Fork the repository** on GitHub
2. **Create a feature branch** from `main`
3. **Make your changes** following the coding standards
4. **Add tests** for new functionality
5. **Update documentation** as needed
6. **Submit a pull request** with a clear description

### Areas for Contribution

- **Frontend Development** - Modern React/Next.js UI improvements
- **Backend Features** - API endpoints, new functionality
- **AI Integrations** - New model providers, better prompts
- **Documentation** - Guides, tutorials, API docs
- **Testing** - Unit tests, integration tests
- **Bug Fixes** - Resolve existing issues

## 📚 Development Resources

### Documentation

- **[API Documentation](../api-reference.md)** - REST API reference
- **[Architecture Guide](../architecture.md)** - System architecture
- **[Plugin Development](../plugins.md)** - Creating custom plugins

### External Resources

- **[SurrealDB Documentation](https://surrealdb.com/docs)** - Database queries and schema
- **[FastAPI Documentation](https://fastapi.tiangolo.com/)** - API framework
- **[Next.js Documentation](https://nextjs.org/docs)** - React framework
- **[LangChain Documentation](https://python.langchain.com/)** - AI workflows

### Getting Help

- **[Discord Server](https://discord.gg/37XJPXfz2w)** - Real-time development help
- **[GitHub Discussions](https://github.com/lfnovo/open-notebook/discussions)** - Design discussions
- **[GitHub Issues](https://github.com/lfnovo/open-notebook/issues)** - Bug reports and feature requests

## 🔄 Maintenance

### Keeping Your Fork Updated

```bash
# Add upstream remote
git remote add upstream https://github.com/lfnovo/open-notebook.git

# Fetch upstream changes
git fetch upstream

# Merge upstream changes
git checkout main
git merge upstream/main
```

### Dependency Updates

```bash
# Update dependencies
uv sync --upgrade

# Check for security issues
uv audit

# Update pre-commit hooks
pre-commit autoupdate
```

### Database Migrations

Database migrations now run automatically when the API starts. When you need to create new migrations:

```bash
# Create new migration file
# Add your migration to migrations/ folder with incremental number

# Migrations are automatically applied on API startup
uv run python api/main.py
```

---

**Ready to contribute?** Start by forking the repository and following the installation steps above. Join our Discord for real-time help and discussion!