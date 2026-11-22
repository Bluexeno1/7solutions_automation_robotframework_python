# NokCash automation (Robot Framework + Python)

Automates 5 scenarios from `NokCash_Test_Design.xlsx`.

| Test | Scenario | Technique |
|---|---|---|
| TC1 | Banner opens the top-up page | Use case |
| TC2 | Amount = minimum - 1 is rejected | Boundary value |
| TC3 | Empty amount is rejected | Equivalence partitioning |
| TC4 | Preset amount equals order-summary amount | Use case |
| TC5 | Custom amount: summary amount and total = amount + fee | Use case / calculation |

None of the tests pays: they stop at the payment page.

## Structure
```
NokCash_automation/
├── Resources/
│   ├── Imports/Imports.resource        # all libraries in one place
│   ├── Data/test_data.yaml             # limits, fee, amounts
│   └── Python_handler/                 # config_handler, locator_handler, amount_helper
├── Keywords/
│   ├── Features/                       # business keywords (Homepage_Features, NokCash_Features)
│   └── Pages/                          # page objects (Homepage, NokCash_TopUp, Payment)
├── Settings/
│   ├── Configs/config.yaml
│   └── Locators/                       # *_locators.yaml
└── Tests/NokCash/                      # TC1..TC5
```

## Before the first real run
1. **Verify the locators** in `Settings/Locators/*.yaml`. They are placeholders written without access to the live DOM.
2. **Check `Resources/Data/test_data.yaml`**: min/max amount and fee are assumptions (same as the Excel Assumptions sheet).
3. **Login**: the site uses LINE login, which is not automated. If the top-up page needs a member, log in manually,
   copy the session cookie, then:
   `export NOKCASH_LOGIN_REQUIRED=true NOKCASH_SESSION_COOKIE="name=value"`

## Run
```
pip install -r requirements.txt          # Chrome + chromedriver must be installed (Selenium Manager can fetch the driver)
robot -d Results Tests/NokCash           # all five tests
robot -d Results -i smoke Tests/NokCash  # TC1 and TC4 only
NOKCASH_HEADLESS=false robot -d Results Tests/NokCash/TC1_Banner_Opens_TopUp_Page.robot   # watch it run
```
Run from the repository root (paths use `${EXECDIR}`). Screenshots are captured on failure and saved in `Results/`.
