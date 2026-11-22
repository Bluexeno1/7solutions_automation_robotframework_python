*** Settings ***
Library    SeleniumLibrary

*** Variables ***
# Replace with the actual field/button locators if the live page differs.
${TOPUP_AMOUNT_INPUT}    css=input[type="number"]
${CONTINUE_BUTTON}       xpath=//button[contains(translate(normalize-space(.),'ABCDEFGHIJKLMNOPQRSTUVWXYZ','abcdefghijklmnopqrstuvwxyz'),'continue') or contains(translate(normalize-space(.),'ABCDEFGHIJKLMNOPQRSTUVWXYZ','abcdefghijklmnopqrstuvwxyz'),'next') or contains(translate(normalize-space(.),'ABCDEFGHIJKLMNOPQRSTUVWXYZ','abcdefghijklmnopqrstuvwxyz'),'payment')]

*** Keywords ***
Top-up Page Should Be Open
    Wait Until Page Contains    NokCash

Enter Valid Top-up Amount
    [Arguments]    ${amount}
    Wait Until Element Is Visible    ${TOPUP_AMOUNT_INPUT}
    Clear Element Text    ${TOPUP_AMOUNT_INPUT}
    Input Text    ${TOPUP_AMOUNT_INPUT}    ${amount}

Continue To Payment
    Wait Until Element Is Enabled    ${CONTINUE_BUTTON}
    Click Element    ${CONTINUE_BUTTON}
