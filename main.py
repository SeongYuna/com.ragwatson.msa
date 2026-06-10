"""Repo root entrypoint for `uvicorn main:app`.

FastAPI app lives in backend/main.py. Run from repo root:

    python -m uvicorn main:app --reload

Or from backend/:

    python -m uvicorn main:app --reload
"""
import importlib.util
import sys
from pathlib import Path

_ROOT = Path(__file__).resolve().parent
_BACKEND = _ROOT / "backend"
_APPS = _BACKEND / "apps"

for directory in (_BACKEND, _APPS):
    path = str(directory)
    if path not in sys.path:
        sys.path.insert(0, path)

_spec = importlib.util.spec_from_file_location("backend_main", _BACKEND / "main.py")
if _spec is None or _spec.loader is None:
    raise ImportError("backend/main.py 를 로드할 수 없습니다.")

_backend_main = importlib.util.module_from_spec(_spec)
_spec.loader.exec_module(_backend_main)

app = _backend_main.app
