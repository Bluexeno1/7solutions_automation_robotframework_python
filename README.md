# NokCash — Robot Framework + Python

## Stack
- Python
- Robot Framework
- SeleniumLibrary
- Chrome browser

## POM design

- `tests/` contains readable Robot Framework test cases.
- `resources/pages/` contains page-specific keywords (page objects).
- `resources/common.resource` contains shared browser setup and teardown.
- `config/` contains URL, browser settings and test data.

## Setup (Windows CMD)

```cmd
cd robotframework-python
py -m venv .venv
.venv\Scripts\activate.bat
python -m pip install --upgrade pip
pip install -r requirements.txt
```

Make sure Google Chrome is installed. Selenium Manager normally obtains the matching driver automatically.

## Run

```cmd
robot -d results tests
```

Run one test:

```cmd
robot -d results -t "NC-002 NokCash banner opens top-up page" tests
```

Open `results\report.html` and `results\log.html` after execution.

## Configuration

Edit:
- `config/settings.robot` — base URL and browser options.
- `config/testdata.robot` — valid top-up amount.
- `resources/pages/*.resource` — page locators.

The default locators are examples and must be verified against the live website. If the site uses a different input, button or summary element, update the corresponding page resource only.

## Notes
- NC-015 assumes the payment page visibly displays the selected amount.
- NC-006 assumes the chosen amount in `testdata.robot` is valid under the site's actual rules.
- Payment is not submitted. The tests stop at order-summary validation.
