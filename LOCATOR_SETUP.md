# Locator setup checklist

Inspect the live website and update these variables in the page resources:

| Element | File | Current example |
|---|---|---|
| NokCash banner | `resources/pages/HomePage.resource` | Text-based XPath |
| Top-up amount input | `resources/pages/TopUpPage.resource` | `css=input[type="number"]` |
| Continue button | `resources/pages/TopUpPage.resource` | Button text XPath |
| Payment summary / amount | `resources/pages/PaymentPage.resource` | Page text check |

Use browser DevTools → Inspect to identify stable IDs, names, labels or `data-testid` attributes.
