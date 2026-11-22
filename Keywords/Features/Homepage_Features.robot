*** Settings ***
Documentation    Business-level keywords that combine page keywords for the homepage flow.
Resource         ../../Resources/Imports/Imports.resource
Resource         ../Pages/Homepage.robot
Resource         ../Pages/NokCash_TopUp.robot


*** Keywords ***
Launch Browser And Open Homepage
    ${url}=        Get Config    base_url
    ${browser}=    Get Config    browser
    ${options}=    Build Chrome Options
    Open Browser    ${url}    ${browser}    options=${options}
    Login If Required
    Open Homepage

Login If Required
    [Documentation]    LINE login cannot be automated. When the site needs a member session, inject a cookie from a manual login.
    ${required}=    Get Config    login_required
    IF    ${required}
        ${name}    ${value}=    Get Session Cookie
        Add Cookie    ${name}    ${value}
        Reload Page
    END

Open NokCash TopUp Page From Homepage
    Click NokCash Banner
    Wait Until TopUp Page Is Loaded

Close Browser Session
    Close All Browsers
