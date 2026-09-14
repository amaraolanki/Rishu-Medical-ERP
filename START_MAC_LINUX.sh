#!/bin/sh
cd "$(dirname "$0")"
if command -v python3 >/dev/null 2>&1; then
  python3 -m http.server 8000 --bind 0.0.0.0
elif command -v python >/dev/null 2>&1; then
  python -m http.server 8000 --bind 0.0.0.0
else
  echo "Python 3 is required."
  exit 1
fi
