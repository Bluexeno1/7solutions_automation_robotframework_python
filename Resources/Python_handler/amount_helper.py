"""Money helpers: parse text such as '฿1,250.00' or '1,250 บาท' and do the summary arithmetic."""
import re
from decimal import Decimal

ROBOT_LIBRARY_SCOPE = "GLOBAL"


def parse_amount(text):
    """Extract the numeric amount from display text. Returns a float. Fails if no number is found."""
    cleaned = str(text).replace(",", "").replace(" ", " ")
    match = re.search(r"-?\d+(?:\.\d+)?", cleaned)
    if not match:
        raise AssertionError(f"No amount found in text: {text!r}")
    return float(match.group())


def calculate_total(amount, fee):
    """Return amount + fee as a float (Decimal arithmetic avoids float noise)."""
    return float(Decimal(str(amount)) + Decimal(str(fee)))


def boundary_amount(limit, offset):
    """Return limit + offset as an int, e.g. boundary_amount(100, -1) -> 99."""
    return int(limit) + int(offset)


def amounts_should_be_equal(actual, expected, message=None):
    """Compare two amounts to the satang (2 decimals)."""
    if round(float(actual), 2) != round(float(expected), 2):
        raise AssertionError(message or f"Amount mismatch: actual {actual} != expected {expected}")
