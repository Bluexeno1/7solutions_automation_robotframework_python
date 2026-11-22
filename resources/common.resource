*** Settings ***
Library    SeleniumLibrary
Resource   ../config/settings.robot

*** Keywords ***
Open NokCash Website
    Open Browser    ${BASE_URL}    ${BROWSER}
    Set Selenium Timeout    ${SELENIUM_TIMEOUT}
    Set Selenium Implicit Wait    ${IMPLICIT_WAIT}
    Maximize Browser Window

Close NokCash Browser
    Close All Browsers
