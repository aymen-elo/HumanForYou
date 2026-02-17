#!/usr/bin/env bash
# ==============================================================================
# HumanForYou — Environment Setup (Linux / macOS)
# ==============================================================================
set -e

VENV_DIR=".venv"
PYTHON="${PYTHON:-python3}"

echo "=================================================="
echo "  HumanForYou — Environment Setup"
echo "=================================================="

# Check Python version
if ! command -v "$PYTHON" &> /dev/null; then
    echo "[ERROR] Python not found. Install Python 3.10+ first."
    exit 1
fi

PY_VERSION=$("$PYTHON" -c "import sys; print(f'{sys.version_info.major}.{sys.version_info.minor}')")
echo "[INFO] Python version: $PY_VERSION"

# Create virtual environment
if [ -d "$VENV_DIR" ]; then
    echo "[INFO] Virtual environment already exists at $VENV_DIR"
    read -p "  Recreate it? (y/N) " -n 1 -r
    echo
    if [[ $REPLY =~ ^[Yy]$ ]]; then
        rm -rf "$VENV_DIR"
        "$PYTHON" -m venv "$VENV_DIR"
        echo "[OK] Virtual environment recreated."
    fi
else
    "$PYTHON" -m venv "$VENV_DIR"
    echo "[OK] Virtual environment created at $VENV_DIR"
fi

# Activate
source "$VENV_DIR/bin/activate"
echo "[OK] Virtual environment activated."

# Upgrade pip
pip install --upgrade pip setuptools wheel --quiet
echo "[OK] pip upgraded."

# Install dependencies
echo "[INFO] Installing dependencies..."
pip install -r requirements.txt
echo "[OK] All dependencies installed."

# Register Jupyter kernel
python -m ipykernel install --user --name humanforyou --display-name "Python (HumanForYou)"
echo "[OK] Jupyter kernel 'HumanForYou' registered."

# Create output directory
mkdir -p outputs
echo "[OK] outputs/ directory ready."

echo ""
echo "=================================================="
echo "  Setup complete!"
echo "=================================================="
echo ""
echo "  To activate the environment:"
echo "    source $VENV_DIR/bin/activate"
echo ""
echo "  To launch Jupyter:"
echo "    jupyter notebook notebooks/"
echo ""
echo "  To deactivate:"
echo "    deactivate"
echo "=================================================="
