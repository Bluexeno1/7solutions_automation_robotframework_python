*** Settings ***
Library    SeleniumLibrary

*** Variables ***
# Example locator. Confirm the actual banner text/attribute on the live site.
${NOKCASH_BANNER}    xpath=//*[self::a or self::button][contains(translate(normalize-space(.),'ABCDEFGHIJKLMNOPQRSTUVWXYZ','abcdefghijklmnopqrstuvwxyz'),'nokcash')]

*** Keywords ***
Click NokCash Banner
    Wait Until Element Is Visible    ${NOKCASH_BANNER}
    Click Element    ${NOKCASH_BANNER}
