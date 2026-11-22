"""Reads locators from Settings/Locators/*.yaml so no locator is hard-coded in .robot files."""
from pathlib import Path

import yaml

ROBOT_LIBRARY_SCOPE = "GLOBAL"

_LOCATOR_DIR = Path(__file__).resolve().parents[2] / "Settings" / "Locators"
_cache = {}


def _load_all():
    if not _cache:
        for path in sorted(_LOCATOR_DIR.glob("*.yaml")):
            with open(path, encoding="utf-8") as f:
                _cache.update(yaml.safe_load(f) or {})
    return _cache


def get_locator(page, name):
    """Return the SeleniumLibrary locator string for page/name, e.g. Get Locator  homepage  nokcash_banner."""
    locators = _load_all()
    try:
        return locators[page][name]
    except KeyError as exc:
        raise KeyError(f"Locator '{page}.{name}' not found in {_LOCATOR_DIR}") from exc
