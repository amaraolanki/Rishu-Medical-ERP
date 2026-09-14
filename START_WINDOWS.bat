@echo off
cd /d "%~dp0"
where py >nul 2>nul
if %errorlevel%==0 (
  start "Rishu ERP Server" cmd /k "py -m http.server 8000 --bind 0.0.0.0"
) else (
  where python >nul 2>nul
  if %errorlevel%==0 (
    start "Rishu ERP Server" cmd /k "python -m http.server 8000 --bind 0.0.0.0"
  ) else (
    echo Python is not installed. Install Python 3 from python.org, then run this file again.
    pause
    exit /b 1
  )
)
timeout /t 2 >nul
start "" http://localhost:8000/
echo.
echo Rishu Medical ERP is running at http://localhost:8000/
echo Keep the server window open while using the ERP.
pause
