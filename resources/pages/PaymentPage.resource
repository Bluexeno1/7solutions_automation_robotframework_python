*** Settings ***
Library    SeleniumLibrary

*** Variables ***
# Example: match visible text containing the selected amount.
# Prefer a stable data-testid or dedicated amount element when available.
${ORDER_SUMMARY}    xpath=//*[contains(.,'Order') or contains(.,'Summary')]

*** Keywords ***
Payment Page Should Show Selected Amount
    [Arguments]    ${amount}
    Wait Until Page Contains    ${amount}
