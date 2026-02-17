@echo off
REM ==============================================================================
REM HumanForYou — Environment Setup (Windows)
REM ==============================================================================

set VENV_DIR=.venv

echo ==================================================
echo   HumanForYou — Environment Setup
echo ==================================================

REM Check Python
python --version >nul 2>&1
if errorlevel 1 (
    echo [ERROR] Python not found. Install Python 3.10+ first.
    exit /b 1
)

for /f "tokens=*" %%i in ('python -c "import sys; print(f'{sys.version_info.major}.{sys.version_info.minor}')"') do set PY_VERSION=%%i
echo [INFO] Python version detected.

REM Create virtual environment
if exist "%VENV_DIR%" (
    echo [INFO] Virtual environment already exists at %VENV_DIR%
    set /p RECREATE="  Recreate it? (y/N) "
    if /i "%RECREATE%"=="y" (
        rmdir /s /q "%VENV_DIR%"
        python -m venv "%VENV_DIR%"
        echo [OK] Virtual environment recreated.
    )
) else (
    python -m venv "%VENV_DIR%"
    echo [OK] Virtual environment created at %VENV_DIR%
)

REM Activate
call "%VENV_DIR%\Scripts\activate.bat"
echo [OK] Virtual environment activated.

REM Upgrade pip
pip install --upgrade pip setuptools wheel --quiet
echo [OK] pip upgraded.

REM Install dependencies
echo [INFO] Installing dependencies...
pip install -r requirements.txt
echo [OK] All dependencies installed.

REM Register Jupyter kernel
python -m ipykernel install --user --name humanforyou --display-name "Python (HumanForYou)"
echo [OK] Jupyter kernel 'HumanForYou' registered.

REM Create output directory
if not exist "outputs" mkdir outputs
echo [OK] outputs\ directory ready.

echo.
echo ==================================================
echo   Setup complete!
echo ==================================================
echo.
echo   To activate the environment:
echo     %VENV_DIR%\Scripts\activate
echo.
echo   To launch Jupyter:
echo     jupyter notebook notebooks/
echo.
echo   To deactivate:
echo     deactivate
echo ==================================================
