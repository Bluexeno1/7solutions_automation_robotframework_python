"""Loads Settings/Configs/config.yaml and Resources/Data/test_data.yaml for Robot Framework."""
import os
from pathlib import Path

import yaml

ROBOT_LIBRARY_SCOPE = "GLOBAL"

_ROOT = Path(__file__).resolve().parents[2]
_CONFIG_FILE = _ROOT / "Settings" / "Configs" / "config.yaml"
_DATA_FILE = _ROOT / "Resources" / "Data" / "test_data.yaml"

# config key -> environment variable that overrides it
_ENV_OVERRIDES = {
    "base_url": "NOKCASH_BASE_URL",
    "headless": "NOKCASH_HEADLESS",
    "browser": "NOKCASH_BROWSER",
    "login_required": "NOKCASH_LOGIN_REQUIRED",
}


def _read_yaml(path):
    with open(path, encoding="utf-8") as f:
        return yaml.safe_load(f) or {}


def _to_bool(value):
    return str(value).strip().lower() in ("1", "true", "yes", "y")


def get_config(key):
    """Return a config value; environment variables win over config.yaml."""
    env_name = _ENV_OVERRIDES.get(key)
    if env_name and os.environ.get(env_name) is not None:
        value = os.environ[env_name]
    else:
        config = _read_yaml(_CONFIG_FILE)
        if key not in config:
            raise KeyError(f"Config key '{key}' not found in {_CONFIG_FILE}")
        value = config[key]
    if key in ("headless", "login_required"):
        return _to_bool(value)
    return value


def get_test_data(section, key):
    """Return one value from Resources/Data/test_data.yaml, e.g. Get Test Data  amount_rules  min_amount."""
    data = _read_yaml(_DATA_FILE)
    try:
        return data[section][key]
    except KeyError as exc:
        raise KeyError(f"Test data '{section}.{key}' not found in {_DATA_FILE}") from exc


def build_chrome_options():
    """Return the Selenium options string for Open Browser, based on config."""
    args = [
        f"add_argument('--window-size={get_config('window_width')},{get_config('window_height')}')",
        "add_argument('--no-sandbox')",
        "add_argument('--disable-dev-shm-usage')",
        "add_argument('--lang=th-TH')",
    ]
    if get_config("headless"):
        args.insert(0, "add_argument('--headless=new')")
    return ";".join(args)


def get_session_cookie():
    """Return (name, value) from NOKCASH_SESSION_COOKIE='name=value'. Fails with a clear message if missing."""
    raw = os.environ.get("NOKCASH_SESSION_COOKIE", "")
    if "=" not in raw:
        raise AssertionError(
            "login_required is true but NOKCASH_SESSION_COOKIE is not set (expected 'name=value')."
        )
    name, value = raw.split("=", 1)
    return name.strip(), value.strip()
