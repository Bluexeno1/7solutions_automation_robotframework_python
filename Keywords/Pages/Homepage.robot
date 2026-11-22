*** Settings ***
Documentation    Page object: homepage.
Resource         ../../Resources/Imports/Imports.resource


*** Keywords ***
Open Homepage
    ${url}=    Get Config    base_url
    Go To    ${url}
    ${body}=    Get Locator    homepage    page_body
    Wait Until Element Is Visible    ${body}

Click NokCash Banner
    ${banner}=    Get Locator    homepage    nokcash_banner
    ${timeout}=    Get Config    timeout
    Wait Until Element Is Visible    ${banner}    ${timeout}
    Scroll Element Into View    ${banner}
    Click Element    ${banner}
